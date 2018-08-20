#ifndef EEPROM_H
#define EEPROM_H

#include <stdint.h>
#include <stdbool.h>

#define KEY_LENGHT (9)

/**
 * eeprom_write_byte: write a byte with data_eeprom value to EEPROM adress with number adr_eeprom.
 */
void _eeprom_write_byte (uint16_t adr_eeprom, uint8_t data_eeprom);


/**
 * eeprom_read_byte: read a byte from EEPROM adress with number adr_eeprom and returns it.
 */
uint8_t _eeprom_read_byte (uint16_t adr_eeprom);

/*
 * Struct of keys in EEPROM:
 * 0x00 - number of keys
 * 
 * 0x01 - 0x08 - root password
 * 
 * 1 key occupies 9 bytes:
 * 1 byte - key's ID and type. Type depends of 2 LSB:
 * 	00 - password for keyboard and UART terminal
 * 	01 - 1-Wire key
 * 	10 - RFID key
 * next 8 bytes - key:
 * 	password   - 8 numbers from 0 to 9
 * 	1-Wire key - 1 byte - device's family code, 6(2-7) bytes - unique ID, 1(8) byte - CRC
 * 	RFID - ...
 */


/**
 * eeprom_write_user_key - writes anew 9-bytes user's key to EEPROM 
 */
void eeprom_write_user_key (uint8_t *curr_num_keys, uint8_t *key_arr);


/**
 * eeprom_read_key - read a 9-bytes key from EEPROM to key_arr
 * 0 key is root key. Keys from 1 to ... are user's keys.
 */
void eeprom_read_key (uint8_t key_number, uint8_t *key_arr);


/**
 * eeprom_delete_key - delete key with key_num number and relocate all others keys.
 */
void eeprom_delete_user_key_by_num (uint8_t del_key_num, uint8_t *num_keys);


/**
 * is_user_key_valid - check is there a user's key in EEPROM
 * 
 * Return:
 * 	true  - key is valid, should unlock
 * 	false - key is invalid
 */
bool is_user_key_valid(uint8_t num_keys, uint8_t *key);


/**
 * is_root_key_valid - check is there an admin key in EEPROM
 * 
 * Return:
 * 	true  - key is valid, should unlock
 * 	false - key is invalid
 */
bool is_root_key_valid(uint8_t num_keys, uint8_t *key);


/* eeprom_write_admin_key - write a new root key instead of old */
void eeprom_update_admin_key (uint8_t *key_arr);


/**
 * is_admin_key_valid - check is argument key the same as root password in EEPROM
 * 
 * Return:
 * 	true  - key is valid, should unlock
 * 	false - key is invalid
 */
bool is_admin_key_valid(uint8_t *key);






#endif
