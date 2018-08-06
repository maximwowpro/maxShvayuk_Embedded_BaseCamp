#ifndef PRINT_UART_H
#define PRINT_UART_H

#define F_CPU 16000000UL
/* bytes in read and write buffers */
#define BUFFER_LEN (64)

#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/sleep.h>
#include <util/atomic.h>

#include <stdbool.h>
#include <stdlib.h>

static const uint32_t uart_baudrate = 19200;	/* Baud rate (Baud / second) */

/* Value to be placed in UBRR register. See datasheet for more */
static const uint16_t ubrr_val = (F_CPU / (16 * uart_baudrate)) - 1;
/* Read and write buffers */
static uint8_t	rdbuff[BUFFER_LEN] = {'\0'},
		wrbuff[BUFFER_LEN] = {'\0'};
static uint8_t rdind = 0, wrind = 0;	/* Indices */
/* Indicates transfer & reception completion */
static volatile bool txcflag = true;
static volatile bool rxcflag = false;


void uart_init(void);

void uart_put(char *str);

bool atomic_str_eq(char *str1, char *str2);

char* to_string_uint8_dec(uint8_t arg, char* str);

char* to_string_uint16_dec(uint16_t arg, char* str);

char* to_string_uint8_hex(uint8_t arg, char* str);

char* to_string_uint16_hex(uint16_t arg, char* str);


inline void uart_print_str(char *str) 
{
	uart_put(str);
}

inline void uart_print_uint8_dec(uint8_t arg, char* str)
{
	uart_put(to_string_uint8_dec(arg, str));
}

inline void uart_print_uint16_dec(uint16_t arg, char* str)
{
	uart_put(to_string_uint16_dec(arg, str));
}


void uart_print_1wire_id_dec(uint8_t *id);

void uart_print_1wire_id_hex(uint8_t *id);


inline void uart_print_uint8_hex(uint8_t arg, char* str)
{
	uart_put(to_string_uint8_hex(arg, str));
}

inline void uart_print_uint16_hex(uint16_t arg, char* str)
{
	uart_put(to_string_uint16_hex(arg, str));
}


#endif
