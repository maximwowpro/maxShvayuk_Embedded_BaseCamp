/* 
 * lib for work with UART protocol at ATMEGA 328p
 */

#ifndef PRINT_UART_H
#define PRINT_UART_H

#define F_CPU 16000000UL
/* bytes in read and write buffers */
/* !!! BUFFER_LEN is a max lenght of string, which is an argument of uart_put() */
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
extern uint8_t	rdbuff[];
extern uint8_t	wrbuff[];
static uint8_t rdind = 0, wrind = 0;	/* Indices */
/* Indicates transfer & reception completion */
extern volatile bool txcflag;/* = true;*/
extern volatile bool rxcflag;


void uart_init(void);

void uart_put(char *str);

bool atomic_str_eq(char *str1, char *str2);

/* uart_compare_with_rdbuff: compare @str with rdbuff(watch print_uart.h).
 * This is front-end to atomic_str_eq() function.
 * 
 * Return:
 * true  - str == rdbuff
 * false - str != rdbuff
 */
bool uart_compare_with_rdbuff(char *str);


/*
 * Next 3 functions converts separate number  to char* string (in dec or hex).
 */
char* to_string_uint8_dec(uint8_t arg, char* str);

char* to_string_uint8_hex(uint8_t arg, char* str);

char* to_string_uint16_dec(uint16_t arg, char* str);


/*
 * Next 4 functions are convenient front-end to uart_put()
 * and previously to_string functions.
 */
void uart_print_str(char *str);

inline void uart_print_uint8_dec(uint8_t arg)
{
	char *str = NULL;
	uart_put(to_string_uint8_dec(arg, str));
}

inline void uart_print_uint8_hex(uint8_t arg)
{
	char *str = NULL;
	uart_put(to_string_uint8_hex(arg, str));
}

inline void uart_print_uint16_dec(uint16_t arg)
{
	char *str = NULL;
	uart_put(to_string_uint16_dec(arg, str));
}


/* Next 2 functions prints unique 1-Wire id and CRC (in dec and hex) */
void uart_print_1wire_id_dec(uint8_t *id);

void uart_print_1wire_id_hex(uint8_t *id);

#endif
