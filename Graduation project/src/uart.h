/* The author of some UART functions is https://github.com/thodnev */

#include "lock.h"

#include <stdbool.h>
#include <stdint.h>

void uart_init(void);

void uart_put(char *str);

bool atomic_str_eq(uint8_t *str1, char *str2);

/* uart_compare_with_rdbuff: compare str with rdbuff(watch uart.c).
 * This is front-end to atomic_str_eq() function.
 * 
 * Return:
 * true  - str == rdbuff
 * false - str != rdbuff
 */
bool uart_compare_with_rdbuff(char *str);


/** uart_print_str - front-end to uart_put() func.
 * 
 * Warning! The max lenght of str should be BUFFER_LEN - 1 (127) symbols.
 */
inline void uart_print_str(char *str)
{	
	uart_put(str);
}


void uart_print_uint8_dec(uint8_t arg);


void uart_print_uint8_hex(uint8_t arg);


/* uart_print_uint8_key_hex - print key consisting of 9 bytes */
void uart_print_uint8_key_hex(uint8_t *key);


/* uart_read_key - read 8 - bytes key from UART
 * 
 * You should write key in hexadecimal notation, dividing the numbers by spaces.
 * Note that numbers should be less than 16 (<16).
 * For example: 1 2 3 4 5 6 7 8
 * 
 * Return:
 * false - something goes wrong
 * true  - reading successful
 */
bool uart_read_pass (uint8_t *key);


/* uart_print_commands_list - prints a list of avaiable UART commands */
void uart_print_commands_list(void);


/* uart_check_admin_pass - read admin's password from UART
 * 
 * Return:
 *  true  - password is valid
 *  false - password is invalid
 */
bool uart_check_admin_pass(uint8_t *key_arr);


/* uart_read_command - check rdbuff is there a new command
 * If command presents - execute it
 */
void uart_read_command(struct lock_st *lock);













