#include "eeprom.h"
#include "uart.h"
#include "lock.h"

#include <avr/io.h>
#include <avr/sleep.h>
#include <avr/interrupt.h>

#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>


int main (void)
{
	uart_init();
	uart_print_str("\nHello from avr lock!\n");
	uart_print_str(" ");
	
	uint8_t num_keys = 0;
	uint8_t key[9] = {0};
	

	uint8_t key1[] = {0, 1, 2, 3, 4, 5, 6, 7, 8};
	uint8_t key2[] = {1, 2, 4, 6, 8, 10, 12, 14, 16};
	uint8_t key3[] = {2, 3, 6, 9, 12, 15, 18, 21, 24};
	uint8_t key4[] = {3, 5, 10, 15, 20, 25, 30, 35, 40};
	uint8_t key5[] = {1, 5, 10, 15, 20, 2, 30, 35, 40};
	uint8_t key6[] = {2, 6, 12, 18, 24, 26, 32, 38, 44};
	uint8_t key228[] = {2, 23, 50, 35, 20, 2, 31, 33, 42};
	uart_print_str("\n__________________________________________\n ");uart_print_str(" ");
	
	eeprom_write_user_key(&num_keys, key1);
	eeprom_write_user_key(&num_keys, key2);
	eeprom_write_user_key(&num_keys, key3);
	eeprom_write_user_key(&num_keys, key4);
	eeprom_write_user_key(&num_keys, key5);
	eeprom_write_user_key(&num_keys, key6);
	eeprom_write_user_key(&num_keys, key228);
	
	uint8_t key_admin[] = {0, 1, 2, 3, 4, 5, 6, 7, 8};
	eeprom_update_admin_key(key_admin);
	
	
	for (uint8_t i = 0; i < num_keys + 1; i++) {
		uart_print_uint8_dec(i);
		uart_print_str("key =    ");
		eeprom_read_key(i, key);
		uart_print_uint8_key_hex(key);
	}
	
	uart_print_str("end");
	
	struct lock_st lock;
	lock.num_keys = num_keys;
	while (1)
	{
		uart_read_command(&lock);
	}
}









