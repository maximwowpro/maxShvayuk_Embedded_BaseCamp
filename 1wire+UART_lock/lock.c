#ifndef F_CPU
#define F_CPU   16000000UL
#endif

#include "lock.h"
#include "led_rgb.h"
#include "onewire.h"
#include "print_uart.h"

#include <util/delay.h>
#include <avr/io.h>
#include <avr/sleep.h>
#include <avr/interrupt.h>
#include <avr/eeprom.h>
#include <util/atomic.h>

#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

/* 
 * If key_add_flag == 1 - we will add a new key to lock 
 * in function lock_add_key().
 * Value of this flag changes in ISR(INT0_vect) when we push the button at INT0 pin
 */
static volatile bool key_add_flag = false;


void lock_init(lock_st *lock, void(*lock_func)(void*),
	       void(*wait_func)(void*), void(*unlock_func)(void*), 
	       volatile uint8_t *DDR, volatile uint8_t *PORT, 
	       volatile uint8_t *PIN)
{	
	lock->lock_func   = lock_func;
	lock->wait_func   = wait_func;
	lock->unlock_func = unlock_func;
	
	lock->DDR  = DDR;
	lock->PORT = PORT;
	lock->PIN  = PIN;
	
	/*
	 * Read the current number of keys from EEPROM. 
	 * It is stored in EEPROM 0x00 adress 
	 */
	lock->num_keys = lock_eeprom_read_byte(0x00);
}


/* The following 3 functions determine what will happen in
 * lock(closed), wait and unlock(open) states.
 * This 3 functions are working with LED.
 * And their arg type should be led_RGB * .
 */
void lock_lock_func_LED(void* arg)
{
	led_RGB *led = (led_RGB*)arg;
	led_RGB_red(led);
}

void lock_wait_func_LED(void* arg)
{
	led_RGB *led = (led_RGB*)arg;
	led_RGB_blue(led);
}

void lock_unlock_func_LED(void* arg)
{
	led_RGB *led = (led_RGB*)arg;
	led_RGB_green(led);
}


void lock_add_key_by_button(lock_st *lock, led_RGB *led)
{
	if( true == key_add_flag ) {
		if( NULL == lock || NULL == led)
			return;
		
		uint8_t error_code = 0;
		uint8_t new_key[8];
		uint8_t crc;
		/* read 1-Wire id+CRC using READ ROM (0x33) command */
		error_code = ow_cmd_readrom
			(&(lock->data_pin), new_key, &crc, true, false);
			
		if(OW_EOK == error_code) {
			new_key[7] = crc; /* add CRC to the 8th position of key */
			lock_eeprom_write_key(lock, new_key); /* write new key to EEPROM */
			uart_print_str("\nYou added new key: ");
			uart_print_1wire_id_hex(new_key);
			key_add_flag = false;
			
			/* make some pause to indicate that new key was added */
			lock->lock_func(led);
			sleep_ms(1000);
		}
	}
}


/* lock_search_key - search *key* in EEPROM memory 
 * Return:
 * true  - if found *key*
 * false - if not found *key*
 */
bool lock_search_key(lock_st *lock, uint8_t *key)
{
	uint8_t pos = 0;
	
	for(uint8_t i = 0; i < lock->num_keys; i++) {
		/* begin and end of EEPROM addresses of each key */
		uint16_t adr_begin = 8 * i + 1;
		
		for(; pos < 7; pos++) {
			/* if we have at least 1 discrepancy - stop checking this key */
			if( key[pos] != lock_eeprom_read_byte(adr_begin + pos) ) {
				pos = 0;
				break;
			}
		}
		/* check CRC */
		/* if familyID and uniqueID coincides, pos == 7 */
		if( pos == 7  && lock_eeprom_read_byte(adr_begin + 7) == key[7] )
			return true;
	}
	
	return false;
}


void lock_try_unlock_LED(lock_st *lock, led_RGB *led, uint8_t *id_compare, 
			 bool resetfirst, bool fastfail)
{
	lock->wait_func(led);
	
	/* 
	 * We need if( false == key_add_flag )  condition because 
	 * lock_try_unlock_LED() and lock_add_key_by_button()
	 * will compete in main loop and when you want add new key using 
	 * lock_add_key_by_button() lock_try_unlock_LED() might read your 
	 * 1-Wire device and show you "Unlocking failed!" message. 
	 * To avoid this situation, I use this condition.
	 */
	if( false == key_add_flag ) {
		uint8_t error_code = 0;
		error_code = ow_cmd_readrom
			(&(lock->data_pin), id_compare, &(id_compare[7]), resetfirst, fastfail);

		if(OW_EOK == error_code) {
			uart_put("\nlock_try_unlock_LED:  ");
			uart_print_1wire_id_hex(id_compare);
			
			if( true == lock_search_key(lock, id_compare) ) {
				lock->unlock_func(led);
				uart_put("\nUnlocking success!\n");
				sleep_ms(2000);
				/* fill id_compare by zeros */
				for(uint8_t i = 0; i < 8; i++)
					id_compare[i] = 0x00;
				/* continue waiting */
				lock->wait_func(led);
			} else {
				lock->lock_func(led);
				uart_put("\nUnlocking failed! Your devise isn't suitable key\n");
				sleep_ms(1000);
				/* continue waiting */
				lock->wait_func(led);
			}
		}
	}
}


/* interrupion handler for sleep_ms() function */
ISR(TIMER2_OVF_vect, ISR_BLOCK)
{
	TCCR2B &= ~((1 << CS22) | (1 << CS21) | (1 << CS20)); /* stop timer */
}

void sleep_ms(uint16_t ms_val)
{
	/* IDLE - because we need to use UART in sleep mode */
	set_sleep_mode(SLEEP_MODE_IDLE); 
	cli();		/* Disable interrupts */
	sleep_enable();	
	sei();  	/* Enable interrupts */
	TIMSK2 |= (1 << TOIE2); /* Enable Timer2 Overflow interrupt by mask */
	while (ms_val--) {
		/* Count 1 ms from TCNT2 to 0xFF (up direction) */
		TCNT2 = (uint8_t)(0xFF - (F_CPU / 128) / 1000);

		/* Enable Timer2 */
		TCCR2B =  (1 << CS22) | (1 << CS20); /* f = Fclk_io / 128, start timer */

		sleep_cpu();
	}
	sleep_disable();	/* Disable sleeps for safety */		
}


/*
 * soft_delay: simple software delay. 
 * We need it for ISR(INT0_vect, ISR_BLOCK) in lock.c
 * as pause for debouncing.
 */
extern void soft_delay(volatile uint16_t N);

/* interruption handler for button at pin PD2, which allow us to add new keys to the lock */
ISR(INT0_vect, ISR_BLOCK)
{
	/* debouncing */
	if( PIND & (1 << 2) ) {
		soft_delay(30);
		if( PIND & (1 << 2) ) {
			key_add_flag = true;
			uart_print_str("\nPlease, add new key:\n");
		}
	}	
}


/* lock_interrupt_INT0_init: configuring INT0 interrupt */
void lock_interrupt_INT0_init()
{
	/* configure INT0 pin as "INPUT without PULLUP */
	DDRD  &= ~(1 << 2);
	PORTD &= ~(1 << 2);
	
	/* interrupt INT0 will be triggered by rising signal (GND => VCC) */
	EICRA &= ~(1 << ISC01);
	EICRA |=  (1 << ISC00);
	
	EIMSK |=  (1 << INT0); /* allow INT0 interrupt */
	
	sei();
}


/* Next 4 functions allow us to work with EEPROM memory */
/* How keys are stored in EEPROM:
 *                       0 - number of keys
 *  1  2  3  4  5  6  7  8 - first  key
 *  9 10 11 12 13 14 15 16 - second key
 * 17 18 19 20 21 22 23 24 - third  key
 * ...
 */

/*
 * lock_eeprom_write_byte: write a byte with data_eeprom value to 
 * EEPROM adress with number adr_eeprom
 */
void lock_eeprom_write_byte(uint16_t adr_eeprom, uint8_t data_eeprom)
{
	ATOMIC_BLOCK(ATOMIC_RESTORESTATE) {
		/* Wait for completion of previous write */
		while(EECR & (1<<EEPE))
		;
		/* Set up address and Data Registers */
		EEAR = adr_eeprom;
		EEDR = data_eeprom;
		/* Write logical one to EEMPE */
		EECR |= (1<<EEMPE);
		/* Start eeprom write by setting EEPE */
		EECR |= (1<<EEPE);
	}
}


/*
 * lock_eeprom_write_key: write a 1-Wire id(8 bytes) with value *new_key to EEPROM.
 */
void lock_eeprom_write_key(lock_st *lock, uint8_t *new_key)
{
	/* "+ 1" because 0x00 memory cell is busy by number of keys */
	uint16_t adr_begin = (lock->num_keys) * 8 + 1;
	uint16_t adr_end = adr_begin + 7;
	uint8_t pos = 0;
	
	for(uint16_t i = adr_begin; i <= adr_end; i++, pos++)
		lock_eeprom_write_byte(i, new_key[pos]);
	
	(lock->num_keys)++;			 /* update number of keys	    */
	eeprom_write_byte(0x00, lock->num_keys); /* update number of keys in EEPROM */
}


/*
 * lock_eeprom_read_byte: read a byte from EEPROM adress 
 * with number adr_eeprom and returns it.
 */
uint8_t lock_eeprom_read_byte(uint16_t adr_eeprom)
{
	/* Wait for completion of previous write */
	while(EECR & (1<<EEPE))
	;
	/* Set up address register */
	EEAR = adr_eeprom;
	/* Start eeprom read by writing EERE */
	EECR |= (1<<EERE);
	/* Return data from Data Register */
	return EEDR;
}


/*
 * lock_eeprom_read_key: read key with number key_number 
 * and copy its value to key.
 * 
 * @key_number = 1 2 3 4 ... - key number
 * @key - array to where value from EEPROM will copying
 */
uint8_t * lock_eeprom_read_key(lock_st *lock, uint8_t key_number, uint8_t *key)
{
	if(key_number == 0 || key_number > lock->num_keys)
		return NULL;
	
	if(NULL == key) {
		key = malloc(8 * sizeof(*key));
		if(NULL == key)
			return NULL;
	}
	
	/* "+ 1" because 0x00 memory cell is busy by number of keys */
	uint16_t adr_begin = (key_number - 1) * 8 + 1;
	uint16_t adr_end = adr_begin + 7;
	uint8_t pos = 0;
	
	for(uint16_t i = adr_begin; i <= adr_end; i++, pos++)
		key[pos] = lock_eeprom_read_byte(i);
	
	return key;
}


/* uart_lock_read: allow lock read and execute commands given by UART */
void uart_lock_read(lock_st *lock, led_RGB *led)
{
	while (rxcflag) {
		if (uart_compare_with_rdbuff("open")) {
			uart_print_str("\nopen - OK\n");
			lock->unlock_func(led);
			sleep_ms(2000);
			lock->wait_func(led);
		} else if (uart_compare_with_rdbuff("close")) {
			uart_print_str("\nclose - OK\n");
			lock->lock_func(led);
			sleep_ms(1000);
			lock->wait_func(led);
		} else if (uart_compare_with_rdbuff("watch all keys")) {
			uart_print_str("\nYour keys are:\n");
			for(uint8_t i = 0; i < lock->num_keys; i++) {
				uart_print_str("\n");
				uart_print_uint8_dec(i + 1);
				uart_print_str(" key =   ");
				for(uint16_t k = i * 8 + 1; k <= i * 8 + 1 + 7; k++) {
					uart_print_uint8_hex(lock_eeprom_read_byte(k));
					uart_print_str(" ");
				}
			}
		} else if(uart_compare_with_rdbuff("add new key")) {
			uart_print_str("\nWrite new key in next format:\n");
			uart_print_str("1-byte familyID\t6-bytes uniqueID\t1-byte CRC\n");
			uart_print_str("in hexadecimal notation, without spaces\n");
			uart_print_str("for example: 01A2B3C4D5E6F70D \n");

			parse_key: /* goto label */
			rxcflag = false;
			while (!rxcflag); /* wait for a new command from user: enter 1-Wire ID or "break" to exit */
			
			/* leave "add new key" mode and skip this iteration of main loop in function "while(rxcflag)" */
			if(uart_compare_with_rdbuff("break")) {
				rxcflag = false;
				uart_print_str("\nwaiting for a new command...\n");
				continue;
			}
			
			/* Now parse an input (rdbuff) to check that input 1-Wire ID is correct */
			/* if user wrote invalid format of key - try again using goto */
			if(rdbuff[16] != '\0') {
				uart_print_str("\nYou wrote 1-Wire ID with invalid lenght, try again please, ");
				uart_print_str("or enter \"break\" to exit from add-key mode\n");
				goto parse_key;
			}
			
			/* parse numbers from string and write this values to  tmp_key[8] */
			/* if user entered "F5" number(in hex) - num_str1 = 'F', num_str2 = '5' */
			char num_str1, num_str2;
			uint8_t tmp_key[8] = {0};
			uint8_t tmp_key_counter = 0;
			
			for(uint8_t i = 0; i <= 14; i += 2) {
				num_str1 = rdbuff[i];
				num_str2 = rdbuff[i+1];
				
				/* check that all numbers and letters of 1-Wire id are correctly, using ASCII
				 * (0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F) */
				if(num_str1 < 48 || (num_str1 > 57 && num_str1 < 65) || num_str1 > 70) {
					uart_put("\nYou wrote invalid number in key, try again please, ");
					uart_put("or write \"break\" to exit from add-key mode\n");
					goto parse_key;
				}
				if(num_str2 < 48 || (num_str2 > 57 && num_str2 < 65) || num_str2 > 70) {
					uart_put("\nYou wrote invalid number in key, try again please, ");
					uart_put("or write \"break\" to exit from add-key mode\n");
					goto parse_key;
				}
				
				/* convert numbers, entered by user from hex to dec system, using ASCII */
				if(num_str1 < 64) /*if num_str1 == 0,1,2,3,4,5,6,7,8,9 */ 
					tmp_key[tmp_key_counter] += 16 * (num_str1 - 48);
				else	  /*if num_str1 == A,B,C,D,E,F	       */ 
					tmp_key[tmp_key_counter] += 16 * (num_str1 - 55);
				
				if(num_str2 < 64) 
					tmp_key[tmp_key_counter] += (num_str2 - 48);
				else 
					tmp_key[tmp_key_counter] += (num_str2 - 55);
				
				tmp_key_counter++;
			}
			
			/* write 1-Wire ID from tmp_key[8] to EEPROM memory */
			lock_eeprom_write_key(lock, tmp_key);
			
			uart_print_str("\nYour new key =  ");
			uart_print_1wire_id_hex(tmp_key);
		} else if(uart_compare_with_rdbuff("DELETE_ALL_KEYS_FROM_EEPROM")) {
			uart_print_str("\nCAUTION!!! This action will delete ALL information about avaiable 1-Wire KEYS ");
			uart_print_str("in EEPROM, do you really want to do this (enter \"YES\" or \"no\" )\n");
			rxcflag = false;
			while (!rxcflag); /* wait for a new command from user: "YES" or "no" */
			
			if( uart_compare_with_rdbuff("YES") ) {
				rxcflag = false;
				uart_print_str("\ndeleting all keys from EEPROM...\n");
				for(uint16_t i = 0; i < 8 * lock->num_keys + 1; i++)
					lock_eeprom_write_byte(i, 0x00);
				lock->num_keys = 0;
				uart_print_str("\nEEPROM was cleaned, waiting for a new command\n");
				continue;
			} else if( uart_compare_with_rdbuff("no") ) {
				rxcflag = false;
				uart_print_str("\nYou entered \"no\", so waiting for a new command...\n");
				continue;
			} else if(rdbuff[0] != '\0') {
				rxcflag = false;
				uart_print_str("\nYou entered \"");
				uart_print_str(rdbuff);
				uart_print_str("\"   I think this means \"no\", so waiting for a new command...\n");
				continue;
			}
		} else if(rdbuff[0] != '\0') {
			uart_print_str("\nUnknown command\n");
			uart_print_str(rdbuff);
		}
		rxcflag = false;
	}
}



