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
 * Value of this flag changes in ISR(...) when we push the button at ...
 */
static volatile bool key_add_flag = false/*true*/;


void lock_init(lock_st *lock, void(*lock_func)(void*),
	       void(*wait_func)(void*), void(*unlock_func)(void*), 
	       volatile uint8_t *DDR, volatile uint8_t *PORT, 
	       volatile uint8_t *PIN)
{	
	lock->lock_func = lock_func;
	lock->wait_func = wait_func;
	lock->unlock_func = unlock_func;
	
	lock->DDR = DDR;
	lock->PORT = PORT;
	lock->PIN = PIN;
	
	/*
	 * Read the current number of keys from EEPROM. 
	 * It is stored in EEPROM 0x00 adress 
	 */
	lock->num_keys = eeprom_read_byte(0x00);
	//lock->keys = malloc( sizeof(*(lock->keys)) * 10 ); /* 10 - max number of keys */
	//lock->key = NULL;
}

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
		uint8_t error_code = 0;
		uint8_t new_key[8];
		uint8_t crc;
		error_code = ow_cmd_readrom
			(&(lock->data_pin), new_key, &crc, true, false);
		if(OW_EOK == error_code) {
			new_key[7] = crc; /* add CRC to the 8th position of key */
			lock_eeprom_write_key(lock, new_key); /* here */
			uart_print_str("\nYou added new key: ");
			uart_print_1wire_id_hex(new_key);
			key_add_flag = false;
			/* make some pause to indicate that new key was added */
			lock->lock_func(led);
			sleep_ms(1000);
		}
	}
}

// uint8_t lock_add_key(lock_st *lock, uint8_t *new_key)
// {
// 	lock->key = new_key;
// 	
// 	if(lock->num_keys >= 10)
// 		return 1;
// 	
// 	/* allocate memory for new key */
// 	(lock->keys)[lock->num_keys] = malloc( sizeof( uint8_t/**(*(lock->keys))*/ ) * 8);
// 	if(NULL == (lock->keys)[lock->num_keys])
// 		return 2;
// 	/* copy data */
// 	for(uint8_t i = 0; i < 8; i++)
// 		((lock->keys)[lock->num_keys])[i] = new_key[i];
// 	
// 	(lock->num_keys)++;
// 	return 0;
// }


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

void lock_eeprom_write_key(lock_st *lock, uint8_t *new_key)
{
	uint16_t adr_begin = (lock->num_keys) * 8 + 1;
	uint16_t adr_end = adr_begin + 7;
	uint8_t pos = 0;
	
	for(uint16_t i = adr_begin; i <= adr_end; i++, pos++)
		lock_eeprom_write_byte(i, new_key[pos]);
	
	(lock->num_keys)++; /* update number of keys */
	eeprom_write_byte(0x00, lock->num_keys); /* update number of keys in EEPROM */
}


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
 * key_number = 1 2 3 4 ...
 * key - array to where value from EEPROM will copying
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
	
	uint16_t adr_begin = (key_number - 1) * 8 + 1;
	uint16_t adr_end = adr_begin + 7;
	uint8_t pos = 0;
	
	for(uint16_t i = adr_begin; i <= adr_end; i++, pos++)
		key[pos] = lock_eeprom_read_byte(i);
	
	return key;
}


/* lock_search_key - search *key* in *lock->keys* 
 * Return:
 * true  - if found *key*
 * false - if not found *key*
 */
bool lock_search_key(lock_st *lock, uint8_t *key, uint8_t crc)
{
	uint8_t pos = 0;
	
	for(uint8_t i = 0; i < lock->num_keys; i++) {
		uint16_t adr_begin = 8 * i + 1;
		uint16_t adr_end = adr_begin + 7;
		
		for(; pos < 7; pos++) {
			if( key[pos] != lock_eeprom_read_byte(adr_begin + pos) ) {
				pos = 0;
				break;
			}
		}
		if( pos >= 6 /*<-refact */ && lock_eeprom_read_byte(adr_begin + 7) == crc )
			return true;
	}
	
	return false;
// /*	
// 	for(uint8_t i=0; i < lock->num_keys; i++) {
// 		for(; k < 7; k++) {
// 			if( (lock->keys)[i][k] != key[k] ) {
// 				k = 0;
// 				break;
// 			}
// 		}
// 		if( 7 == k && (lock->keys)[i][7] == crc )
// 			return true;
// 	}
// 	return false;*/
}

void lock_try_unlock_LED(lock_st *lock, led_RGB *led, uint8_t *id_compare, 
			 uint8_t *crc, bool resetfirst, bool fastfail)
{
	lock->wait_func(led);
	
	uint8_t error_code = 0;
	error_code = ow_cmd_readrom
		(&(lock->data_pin), id_compare, crc, resetfirst, fastfail);

	if(OW_EOK == error_code) {
		char* str = NULL;
		uart_put("\nlock_try_unlock_LED:  ");
		uart_print_1wire_id_hex(id_compare);
		uart_put("\nCRC = ");
		uart_print_uint8_hex(*crc, str);
		
		if( true == lock_search_key(lock, id_compare, *crc) ) {
			lock->unlock_func(led);
			uart_put("\nUnlocking success!\n");
			sleep_ms(2000);
			/* fill id_compare by zeros */
			for(uint8_t i = 0; i < 8; i++)
				id_compare[i] = 0x00;
			
			lock->wait_func(led);
		} else {
			lock->lock_func(led);
			uart_put("\nUnlocking failed! Your devise isn't suitable key\n");
			sleep_ms(1000);
			lock->wait_func(led);
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
	set_sleep_mode(SLEEP_MODE_IDLE); /* idle - because we need to use
					    UART in sleep mode */
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

extern void soft_delay(volatile uint16_t N);

/* interruption handler for button at pin PD2, which allow us to add new keys to the lock */
ISR(INT0_vect, ISR_BLOCK)
{
	if( PIND & (1 << 2) ) {
		soft_delay(30);
		if( PIND & (1 << 2) ) {
			key_add_flag = true;//!key_add_flag;
			uart_print_str("\nPlease, add new key:\n");
		}
	}
	
}

void lock_interrupt_INT0_init()
{
	/* configure INT0 pin as "INPUT without PULLUP */
	DDRD  &= ~(1 << 2);
	PORTD &= ~(1 << 2);
	
	/* interrupt INT0 will be triggered by rising signal (GND -> VCC) */
	EICRA &= ~(1 << ISC01);
	EICRA |=  (1 << ISC00);
	
	EIMSK |=  (1 << INT0); /* allow INT0 interrupt */
	
	sei();
}











