#include "uart.h"
#include "lock.h"
#include "eeprom.h"

#include <avr/power.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/sleep.h>
#include <util/atomic.h>

#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

#define F_CPU 16000000UL
/* lenght in bytes of read and write buffers */
#define BUFFER_LEN (128)

static const uint32_t uart_baudrate = 19200;			     /* Baud rate (Baud / second) 	    */
static const uint16_t ubrr_val = (F_CPU / (16 * uart_baudrate)) - 1; /* Value to be placed in UBRR register.*/
uint8_t	rdbuff[BUFFER_LEN] = {'\0'}, wrbuff[BUFFER_LEN] = {'\0'};    /* Read and write buffers 		    */
volatile bool txcflag = true;
volatile bool rxcflag = false;
static uint8_t rdind = 0, wrind = 0;

volatile bool uart_tx_complete_flag = true;

/* USART RX Complete interrupt handler */
ISR(USART_RX_vect, ISR_BLOCK)
{	
	/* Buffer will contain the last N = <buffer_len> chars read */
	rdbuff[rdind] = UDR0;

	if ('\n' == rdbuff[rdind]) {
		rdbuff[rdind] = '\0';
		rxcflag = true;
		rdind = 0;
	} else {
		rxcflag = false;
		rdind++;
	}

	if (rdind >= BUFFER_LEN)
		rdind = 0;
}


/* USART Data Register Empty interrupt handler */
ISR(USART_UDRE_vect, ISR_BLOCK)
{
	if (('\0' == wrbuff[wrind]) || txcflag) {
		/* If nothing to transmit - disable this interrupt and exit */
		UCSR0B &= ~(1 << UDRIE0);
		txcflag = true;
		return;
	}

	UDR0 = wrbuff[wrind++];	

	/* Really we don't need this as long as every string ends with '\0' */
	if (wrind >= BUFFER_LEN)
		wrind = 0;
}


/* USART TX Complete interrupt handler */
ISR(USART_TX_vect, ISR_BLOCK)
{
	/* When data register is empty and after the shift register contents */
	/* are already transfered, this interrupt is raised */
	UCSR0B &= ~(1 << TXCIE0);
}


void uart_init(void)
{
	/* To use USART module, we need to power it on first */
	power_usart0_enable();

	/* Configure prescaler */
	UBRR0L = ubrr_val & 0xFF; /* Lower byte */
	UBRR0H = (ubrr_val >> 8) & 0xFF;   /* Higher byte */
	/* Or we could use UBRR0 (16-bit defined) instead */

	/* Set operation mode */
	/* Asynchronous mode, even parity, 2 stop bits, 8 data bits */
	UCSR0C = (1 << UPM01) | (1 << USBS0) | (1 << UCSZ00) | (1 << UCSZ01);

	/* Continue setup & enable USART in one operation */
	/* RX & TX complete, Data reg empty interrupts enabled */
	UCSR0B = (1 << RXCIE0) | (1 << RXEN0) | (1 << TXEN0);
	
	set_sleep_mode(SLEEP_MODE_IDLE);
	sleep_enable();
	sei();
}


void uart_put(char *str)
{
	/* If buffer contents have not been transfered yet -- put MCU to sleep */
	while(!txcflag)
		sleep_cpu();

	/* No interrupts can occur while this block is executed */
	ATOMIC_BLOCK(ATOMIC_RESTORESTATE) {
		for (uint8_t i = 0; i < BUFFER_LEN; i++) {
			wrbuff[i] = str[i];
			if ('\0' == str[i])
				break;
		}
		/* if the lenght of str is more than 128 symbols - cut it using '\0' symbol */
		wrbuff[BUFFER_LEN - 1] = '\0';

		wrind = 0;
		txcflag = false; /* programmatic transfer complete flag */
		/* Enable transmitter interrupts */
		UCSR0B |= (1 << TXCIE0) | (1 << UDRIE0);
	}
}


bool atomic_str_eq(uint8_t *str1, char *str2)
{
	bool res = true;
	ATOMIC_BLOCK(ATOMIC_RESTORESTATE) {
		for (uint8_t i = 0; i < BUFFER_LEN; i++) {
			if (str1[i] != str2[i]) {
				res = false;
				break;
			}
			if ('\0' == str1[i])
				break;
		}
	}
	return res;
}


bool uart_compare_with_rdbuff(char *str)
{
	return atomic_str_eq(rdbuff, str);
}


extern void uart_print_str(char *str);


void uart_print_uint8_dec(uint8_t arg)
{
	char* str = malloc(sizeof(*str) * 4); /* 4 because max uint8_t decimal number is 255 + '\0' symbol */
	if (NULL == str)
		return;
	
	str[3] = '\0';
	
	if (arg < 10) {
		str[0] = ' ';
		str[1] = ' ';
		str[2] = 48 + arg; /* 48 is '0' symbol in ASCII */
	} else if (arg < 100 && arg > 9) {
		str[0] = ' ';
		str[1] = 48 + arg / 10;
		str[2] = 48 + arg % 10;
	} else if (arg > 99) {
		str[0] = 48 +  arg / 100;
		str[1] = 48 + (arg % 100) / 10;
		str[2] = 48 +  arg % 10 ;
	}
	
	uart_put(str);	
	
	free(str);
	return;
}


void uart_print_uint8_hex(uint8_t arg)
{
	char* str = malloc(sizeof(*str) * 3); /* 4 because max uint8_t hex number is FF + '\0' symbol */
	if (NULL == str)
		return;
	
	str[2] = '\0';
	
	const char arr[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
	
	if (arg < 16) {
		str[0] = ' ';
		str[1] = arr[arg];
	} else {
		str[0] = arr[arg / 16];
		str[1] = arr[arg % 16];
	}
	
	uart_put(str);
	
	free(str);
	return;
}


void uart_print_uint8_key_hex(uint8_t *key)
{
	if (NULL == key)
		return;
	
	uint8_t key_type = 0b00000011 & key[0];
	switch (key_type) {
		case 0:
			uart_print_str("Password   ");
			break;
		case 1:
			uart_print_str("1-Wire     ");
			break;
		case 2:
			uart_print_str("RFID       ");
			break;
		default:
			uart_print_str("Unknown key type: ");
			break;
	}
	
	for (uint8_t i = 1; i < 9; i++) {
		uart_print_uint8_hex(key[i]);
		uart_print_str(" ");
	}
	
	uart_print_str("\n");
	return;
}


bool uart_read_pass (uint8_t *key_arr)
{
	rxcflag = false;
	while (!rxcflag); /* waiting for a password from user */	
	
	if (NULL == key_arr) {
		key_arr = malloc (sizeof(*key_arr) * KEY_LENGHT);
		if (NULL == key_arr)
			return false;
	}
	
	ATOMIC_BLOCK(ATOMIC_RESTORESTATE) {
		/* check the spaces */
		for (uint8_t i = 1; i < 14; i += 2) {
			if (rdbuff[i] != ' ')
				return false;
		}
		
		/* check that user entered valid numbers */
		for (uint8_t i = 0; i <= 14; i += 2) {
			if (rdbuff[i] < 48 || rdbuff[i] > 57)
				return false;
		}
		
		for (uint8_t i = 0; i <= 14; i += 2) {
			key_arr[i / 2 + 1] = (rdbuff[i] - 48);
		}
	}
	key_arr[0] = 0; /* Use this line to notice that key_arr is UART/keyboard password */
	
	return true;
}


void uart_print_commands_list(void)
{
	uart_print_str("\n\nAvaiable UART commands:\n");
	uart_print_str("watch all keys (admin)         - print a list of all_avaiable keys\n");
	uart_print_str("update admin password (admin)  - change the admin key\n");
	uart_print_str("add new password (admin)          - add a new user UART/keyboard key\n");
	uart_print_str("add new 1-Wire key (admin)        - add a new user 1-Wire device key\n");
	uart_print_str("add new RFID key (admin)        - add a new user RFID device key\n");
	uart_print_str("delete user key (admin) - delete one of existing keys\n");
	uart_print_str("commands list                     - watch this command list\n");
	uart_print_str("unlock (user)                       - unlock the lock for a few time\n");
	
	return;
}


bool uart_check_admin_pass(uint8_t *key_arr)
{
	if (NULL == key_arr)
		return false;
	
	uart_print_str("\nEnter admin's password (each number separated by spaces):\n ");
	
	if (false == uart_read_pass(key_arr)) {
		uart_print_str("Invalid password, you entered: \n");
		uart_print_str(rdbuff);
		rxcflag = false;
		return false;
	}
	
	if (false == is_admin_key_valid(key_arr)) {
		uart_print_str("Invalid password, you entered: \n");
		uart_print_str(rdbuff);
		rxcflag = false;
		return false;
	}
	
	return true;
}


void uart_read_command(struct lock_st *lock)
{
	while (rxcflag) {
		uint8_t key_arr[9] = {0};
		if (uart_compare_with_rdbuff("watch all keys")) {
			if (false == uart_check_admin_pass(key_arr))
				continue;

			uart_print_str("You entered: "); 
			uart_print_str(rdbuff); 
			uart_print_str("\n"); 
			for (uint8_t i = 1; i < lock->num_keys + 1; i++) {
				uart_print_uint8_dec(i);
				uart_print_str(" key =    ");
				eeprom_read_key(i, key_arr);
				uart_print_uint8_key_hex(key_arr);
			}
		}
		else if (uart_compare_with_rdbuff("update admin password")) {
			if (false == uart_check_admin_pass(key_arr))
				continue;
			
			uart_print_str("Enter new admin's password: \n");
			if (false == uart_read_pass(key_arr)) {
				uart_print_str("Invalid password format, you entered: \n");
				uart_print_str(rdbuff);
				rxcflag = false;
				continue;
			}
			eeprom_update_admin_key(key_arr);
			uart_print_str("\nAdmins password was succesfully updated to\n");
			uart_print_str(rdbuff);
			uart_print_str("\n\n");
			
		}
		else if (uart_compare_with_rdbuff("add new password")) {
			if (false == uart_check_admin_pass(key_arr))
				continue;
			
			uart_print_str("Enter new user's password: \n");
			if (false == uart_read_pass(key_arr)) {
				uart_print_str("Invalid password format, you entered: \n");
				uart_print_str(rdbuff);
				rxcflag = false;
				continue;
			}
			
			eeprom_write_user_key(&(lock->num_keys), key_arr);
			uart_print_str("New user's password was succesfully added: \n");
			uart_print_str(rdbuff);
			uart_print_str("\n\n");
		} 
		else if (uart_compare_with_rdbuff("add new 1-Wire key")) {
			//TODO
		}
		else if (uart_compare_with_rdbuff("add new RFID key")) {
			//TODO
		}
		else if (uart_compare_with_rdbuff("delete user key")) {
			if (false == uart_check_admin_pass(key_arr))
				continue;

			uart_print_str("Here you can see all avaiable keys. ");
			uart_print_str("Enter the number of key, which should be deleted: \n");
			
			for (uint8_t i = 1; i < lock->num_keys + 1; i++) {
				uart_print_uint8_dec(i);
				uart_print_str(" key =    ");
				eeprom_read_key(i, key_arr);
				uart_print_uint8_key_hex(key_arr);
			}
			
			rxcflag = false;
			while (!rxcflag);
			/* read a uint8_t number from UART */
			uint8_t key_to_delete = 0;
			if ('\0' == rdbuff[1]) {
				key_to_delete = (rdbuff[0] - 48); /* converts from ASCII to decimal number */
			} else if('\0' == rdbuff[2]) {
				key_to_delete += (rdbuff[1] - 48);
				key_to_delete += (rdbuff[0] - 48) * 10;
			} else if('\0' == rdbuff[3]) {
				key_to_delete += (rdbuff[2] - 48);
				key_to_delete += (rdbuff[1] - 48) * 10;
				key_to_delete += (rdbuff[0] - 48) * 100;
			} else {
				uart_print_str("\nInvalid key number format, you entered:    ");
				uart_print_str(rdbuff);
				rxcflag = false;
				continue;
			}
			
			eeprom_read_key(key_to_delete, key_arr);
			eeprom_delete_user_key_by_num(key_to_delete, &(lock->num_keys));
			uart_print_str("\nKey number ");
			uart_print_uint8_dec(key_to_delete);
			uart_print_str(":  ");
			uart_print_uint8_key_hex(key_arr);
			uart_print_str("was succesfully deleted\n");
		}
		else if (uart_compare_with_rdbuff("unlock")) {
		//TODO
		}
		else if (uart_compare_with_rdbuff("commands list")) {
			uart_print_commands_list();
		}
		else if (rdbuff[0] != '\0') {
			uart_print_str("\nUnknown command:      ");
			uart_print_str(rdbuff);
			uart_print_str("\nEnter \"commands list\" to watch avaiable commands\n");
		}
		rxcflag = false;
	}
}












