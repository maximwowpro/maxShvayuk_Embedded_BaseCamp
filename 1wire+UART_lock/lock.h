#ifndef LOCK_H
#define LOCK_H

#include "led_rgb.h"
#include "onewire.h"

#include <avr/io.h>
#include <avr/eeprom.h>
// #include <avr/interrupt.h>

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
	
	//uint8_t **keys;
	//uint8_t  *key;
	//uint8_t EEMEM *keys_eeprom[MAX_KEYS];
	uint8_t num_keys;
} lock_st;

void lock_init(lock_st *lock, void(*lock_func)(void*),
	       void(*wait_func)(void*), void(*unlock_func)(void*),
	       volatile uint8_t *DDR, volatile uint8_t *PORT, 
	       volatile uint8_t *PIN);

void lock_lock_func_LED(void* arg);

void lock_wait_func_LED(void* arg);

void lock_unlock_func_LED(void* arg);

void lock_add_key_by_button(lock_st *lock, led_RGB *led);

//uint8_t lock_add_key(lock_st *lock, uint8_t *new_key);

bool lock_search_key(lock_st *lock, uint8_t *key, uint8_t crc);

void lock_try_unlock_LED(lock_st *lock, led_RGB *led, uint8_t *id_compare, 
			 uint8_t *crc, bool resetfirst, bool fastfail);

void sleep_ms(uint16_t ms_val);

/*
 * simple software delay
 */
inline void soft_delay(volatile uint16_t N)
{
	volatile uint8_t inner = 0xFF;
	while (N--) {
		while (inner--);
	}
	return;
}

void lock_interrupt_INT0_init();

void lock_eeprom_write_byte(uint16_t adr_eeprom, uint8_t data_eeprom);

void lock_eeprom_write_key(lock_st *lock, uint8_t *new_key);

uint8_t lock_eeprom_read_byte(uint16_t adr_eeprom);

uint8_t * lock_eeprom_read_key(lock_st *lock, uint8_t key_number, uint8_t *key);


#endif
