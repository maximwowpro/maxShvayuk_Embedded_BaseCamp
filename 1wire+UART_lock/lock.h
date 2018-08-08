#ifndef LOCK_H
#define LOCK_H

#include "led_rgb.h"
#include "onewire.h"

#include <avr/io.h>
#include <avr/eeprom.h>

#include <stdbool.h>

// static const uint8_t MAX_KEYS = 0xFF;


typedef struct __lock_st {
	ow_Pin data_pin;
	
	void(*lock_func)(void*);
	void(*wait_func)(void*);
	void(*unlock_func)(void*);
	
	volatile uint8_t *DDR;
	volatile uint8_t *PORT;
	volatile uint8_t *PIN;
	
	uint8_t num_keys;
} lock_st;

void lock_init(lock_st *lock, void(*lock_func)(void*),
	       void(*wait_func)(void*), void(*unlock_func)(void*),
	       volatile uint8_t *DDR, volatile uint8_t *PORT, 
	       volatile uint8_t *PIN);

/* The following 3 functions determine what will happen in
 * lock(closed), wait and unlock(open) states.
 * This 3 functions are working with LED.
 * And their arg type should be led_RGB * .
 */
void lock_lock_func_LED(void* arg);

void lock_wait_func_LED(void* arg);

void lock_unlock_func_LED(void* arg);


/* lock_add_key_by_button add a new 1-Wire key
 * 
 * This function uses key_add_flag variable (look lock.c file).
 * This function will read and add new key if key_add_flag == true.
 * To set key_add_flag = true you should push down button at pin INT0.
 * Watch ISR(INT0_vect, ISR_BLOCK) interrupts handler in lock.c .
 * 
 * How it works:
 * if you pushed down the button at pin INT0, the interrupt INT0_vect will 
 * occur, the interrupt handler ISR(INT0_vect, ISR_BLOCK) will change the 
 * value key_add_flag to true and the next 1-Wire device which you
 * will read will be considered the key and will be recorded in EEPROM memory 
 * by lock_add_key_by_button() function.
 */
void lock_add_key_by_button(lock_st *lock, led_RGB *led);


/* lock_search_key - search *key* in EEPROM memory 
 * Return:
 * true  - if found *key*
 * false - if not found *key*
 */
bool lock_search_key(lock_st *lock, uint8_t *key);


/* lock_try_unlock_LED - function for main loop
 * 
 * @id_compare: here we will write the id of 1-Wire device. 
 * 		You should allocate memory ( 8 * sizeof(*id_compare) ) 
 * 		for @id_compare before using 
 * 		lock_try_unlock_LED() function.
 * @crc: here we will write the CRC of 1-Wire device.
 * 	 You should allocate memory for @crc before using lock_try_unlock_LED()
 * @resetfirst: flag for ow_cmd_readrom()
 * @fastfail: flag for ow_cmd_readrom()
 * 
 * Here we read 1-Wire id. If id of device which was read is in EEPROM - 
 * unlock the lock (light green LED).
 * If id of device isn't in EEPROM - signals this (light red LED).
 */
void lock_try_unlock_LED(lock_st *lock, led_RGB *led, uint8_t *id_compare, 
			 bool resetfirst, bool fastfail);


/* sleep_ms: put MCU to sleep (IDLE mode) */
void sleep_ms(uint16_t ms_val);

/*
 * soft_delay: simple software delay. 
 * We need it for ISR(INT0_vect, ISR_BLOCK) in lock.c
 * as pause for debouncing.
 */
inline void soft_delay(volatile uint16_t N)
{
	volatile uint8_t inner = 0xFF;
	while (N--) {
		while (inner--);
	}
	return;
}

/* lock_interrupt_INT0_init: configuring INT0 interrupt */
void lock_interrupt_INT0_init();


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
void lock_eeprom_write_byte(uint16_t adr_eeprom, uint8_t data_eeprom);


/*
 * lock_eeprom_write_key: write a 1-Wire id(8 bytes) with value *new_key to EEPROM.
 */
void lock_eeprom_write_key(lock_st *lock, uint8_t *new_key);


/*
 * lock_eeprom_read_byte: read a byte from EEPROM adress 
 * with number adr_eeprom and returns it.
 */
uint8_t lock_eeprom_read_byte(uint16_t adr_eeprom);


/*
 * lock_eeprom_read_key: read key with number key_number 
 * and copy its value to key.
 * 
 * @key_number = 1 2 3 4 ... - key number
 * @key - array to where value from EEPROM will copying
 */
uint8_t * lock_eeprom_read_key(lock_st *lock, uint8_t key_number, uint8_t *key);


// /* uart_lock_read: allow lock read and execute commands given by UART */
// //void uart_lock_read(lock_st *lock);

#endif
