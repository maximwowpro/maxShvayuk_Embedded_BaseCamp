#include "print_uart.h"

#include <avr/power.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/sleep.h>
#include <util/atomic.h>

#include <stdbool.h>
#include <stdlib.h>


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
		wrind = 0;
		txcflag = false; /* programmatic transfer complete flag */
		/* Enable transmitter interrupts */
		UCSR0B |= (1 << TXCIE0) | (1 << UDRIE0);
	}
}


bool atomic_str_eq(char *str1, char *str2)
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

char* to_string_uint8_dec(uint8_t arg, char* str)
{
	str = malloc(3 * sizeof(char) + 1); /* 3 numbers + \0 sumbol */
	
	uint8_t tmp = arg;
	uint8_t pos = 0; /* number of symbols in str */
	if( arg >= 100 ) {
		tmp /= 100;
		str[pos] = tmp + '0'; /* watch ASCII table */
		arg %= 100;
		pos++;
	}
	else {
		str[pos] = ' ';
		pos++;
	}
	
	tmp = arg;
	if( arg >= 10 ) {
		tmp /= 10;
		str[pos] = tmp + '0'; /* watch ASCII table */
		arg %= 10;
		pos++;
	}
	else {
		str[pos] = ' ';
		pos++;
	}

	str[pos] = arg + '0'; /* watch ASCII table */
	pos++;
	
	str[pos] = '\0';
	return str;
}


char* to_string_uint16_dec(uint16_t arg, char* str)
{
	str = malloc(5 * sizeof(char) + 10); /* 5 numbers + \0 sumbol */
	
	uint16_t tmp = arg;
	uint8_t pos = 0; /* number of symbols in str */
	if( arg >= 10000 ) {
		tmp /= 10000;
		str[pos] = tmp + '0'; /* watch ASCII table */
		arg %= 10000;
		pos++;
	}
	else {
		str[pos] = ' ';
		pos++;
	}
	
	tmp = arg;
	if( arg >= 1000 ) {
		tmp /= 1000;
		str[pos] = tmp + '0'; /* watch ASCII table */
		arg %= 1000;
		pos++;
	}
	else {
		str[pos] = ' ';
		pos++;
	}
	
	tmp = arg;
	if( arg >= 100 ) {
		tmp /= 100;
		str[pos] = tmp + '0'; /* watch ASCII table */
		arg %= 100;
		pos++;
	}
	else {
		str[pos] = ' ';
		pos++;
	}
	
	tmp = arg;
	if( arg >= 10 ) {
		tmp /= 10;
		str[pos] = tmp + '0'; /* watch ASCII table */
		arg %= 10;
		pos++;
	}
	else {
		str[pos] = ' ';
		pos++;
	}

	str[pos] = arg + '0'; /* watch ASCII table */
	pos++;
	
	str[pos] = '\0';
	return str;
}



char* to_string_uint8_hex(uint8_t arg, char* str)
{
	str = malloc(2 * sizeof(char) + 1); /* 2 numbers + \0 sumbol */
	
	char numbers[] = {'0', '1', '2', '3', '4', '5', '6', '7',
			       '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
	uint8_t tmp = arg;
	uint8_t pos = 0; /* number of symbols in str */
	if( arg >= 16 ) {
		tmp /= 16;
		str[pos] = numbers[tmp];
		arg %= 16;
		pos++;
	}
	else {
		str[pos] = '0';
		pos++;
	}

	str[pos] = numbers[arg];
	pos++;
	
	str[pos] = '\0';
	return str;
}

char* to_string_uint16_hex(uint16_t arg, char* str)
{
	
}


extern void uart_print_str(char *str);

extern void uart_print_uint8_dec(uint8_t arg, char* str);

extern void uart_print_uint16_dec(uint16_t arg, char* str);

void uart_print_1wire_id_dec(uint8_t *id)
{
	char *str = NULL;
	uart_print_str("\nFamily = ");
	uart_print_uint8_dec(id[0], str);
	
	uart_print_str("  id = ");
	for(uint8_t i = 1; i < 7; i++)
		uart_print_uint8_dec(id[i], str);
	
	uart_print_str("  CRC = ");
	uart_print_uint8_dec(id[7], str);
}

extern void uart_print_uint8_hex(uint8_t arg, char* str);

extern void uart_print_uint16_hex(uint16_t arg, char* str);

void uart_print_1wire_id_hex(uint8_t *id)
{
	char *str = NULL;
	uart_print_str("Family = ");
	uart_print_uint8_hex(id[0], str);
	
	uart_print_str("  id = ");
	for(uint8_t i = 1; i < 7; i++)
		uart_print_uint8_hex(id[i], str);
	
	uart_print_str("  CRC = ");
	uart_print_uint8_hex(id[7], str);
}











