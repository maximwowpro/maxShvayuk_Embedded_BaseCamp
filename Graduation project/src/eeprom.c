#include "eeprom.h"

#include <avr/eeprom.h>
#include <util/atomic.h>

#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

//#define KEY_LENGHT (9)


void _eeprom_write_byte (uint16_t adr_eeprom, uint8_t data_eeprom)
{
	ATOMIC_BLOCK(ATOMIC_RESTORESTATE) {
		/* Wait for completion of previous write */
		while(EECR & (1<<EEPE));
		/* Set up address and Data Registers */
		EEAR = adr_eeprom;
		EEDR = data_eeprom;
		/* Write logical one to EEMPE */
		EECR |= (1<<EEMPE);
		/* Start eeprom write by setting EEPE */
		EECR |= (1<<EEPE);
	}
}


uint8_t _eeprom_read_byte (uint16_t adr_eeprom)
{
	/* Wait for completion of previous write */
	while(EECR & (1<<EEPE));
	/* Set up address register */
	EEAR = adr_eeprom;
	/* Start eeprom read by writing EERE */
	EECR |= (1<<EERE);
	/* Return data from Data Register */
	return EEDR;
}


void eeprom_write_user_key (uint8_t *curr_num_keys, uint8_t *key_arr)
{
	if (NULL == key_arr)
		return;
	
	uint16_t start_pos = (*curr_num_keys + 1) * KEY_LENGHT + 1;
	for (uint8_t i = 0; i < KEY_LENGHT; i++)
		_eeprom_write_byte (start_pos + i, key_arr[i]);
	
	(*curr_num_keys)++;
	_eeprom_write_byte(0x00, *curr_num_keys);
	
	return;
}


void eeprom_read_key (uint8_t key_num, uint8_t *key_arr)
{
	if (NULL == key_arr) {
		key_arr = malloc (sizeof(*key_arr) * KEY_LENGHT);
		if (NULL == key_arr)
			return;
	}
	
	uint16_t start_pos = key_num * KEY_LENGHT + 1;
	for (uint8_t i = 0; i < KEY_LENGHT; i++)
		key_arr[i] = _eeprom_read_byte (start_pos + i);
	
	return;
}


void eeprom_delete_user_key_by_num (uint8_t del_key_num, uint8_t *num_keys)
{
	if (del_key_num > *num_keys)
		return;
	
	uint16_t start_pos = del_key_num * KEY_LENGHT + 1;
	if (del_key_num == (*num_keys)) {
		for (uint8_t i = 0; i < KEY_LENGHT; i++)
			_eeprom_write_byte(start_pos + i, 0x00);
		(*num_keys)--;
		_eeprom_write_byte(0x00, *num_keys);
		return;
	}

	for (uint8_t i = 0; i < ((*num_keys) - 1 - del_key_num); i++) {
		for (uint16_t m = 0; m < KEY_LENGHT; m++)
			_eeprom_write_byte(start_pos + m + i * KEY_LENGHT, 
					  _eeprom_read_byte(start_pos + m + (i + 1) * KEY_LENGHT) );
	}
	
	(*num_keys)--;
	_eeprom_write_byte(0x00, *num_keys);
	
	return;
}


bool is_user_key_valid(uint8_t num_keys, uint8_t *key)
{
	volatile bool is_valid = false;
	volatile uint8_t coincidence_counter = 0;
	
	/* starts from 1 because the first password is a root password */
	for (uint8_t i = 1; i <= num_keys; i++) {
		coincidence_counter = 0;
		/* + 1 - because 0x00 memory cell is number of keys; + 1 because first byte in every key is information about key type */
		uint16_t start_pos = i * KEY_LENGHT + 1 + 1; 
		for (uint16_t m = 0; m < (KEY_LENGHT - 1); m++) {
			if (_eeprom_read_byte(start_pos + m) == key[m+1] )
				coincidence_counter++;
			else
				coincidence_counter = coincidence_counter;
		}
		
		if (8 == coincidence_counter)
			is_valid = true;
 		else 
 			is_valid = is_valid;
	}
		
	return is_valid;
}


void eeprom_update_admin_key (uint8_t *key_arr)
{
	if (NULL == key_arr)
		return;
	
	for (uint8_t i = 2; i <= KEY_LENGHT; i++) 
		_eeprom_write_byte (i, key_arr[i-1]);
	
	return;
}


bool is_admin_key_valid(uint8_t *key)
{
	volatile bool is_valid = true;
	
	for (uint8_t i = 2; i <= KEY_LENGHT; i++) {
		if (_eeprom_read_byte(i) != key[i-1])
			is_valid = false;
		else
			is_valid = is_valid;
	}
	
	return is_valid;
}











