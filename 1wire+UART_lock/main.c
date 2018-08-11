#include "onewire.h"
#include "led_rgb.h"
#include "lock.h"
#include "print_uart.h"

#include <avr/io.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/sleep.h>
#include <avr/power.h>
#include <util/atomic.h>
#include <util/delay.h>

#include <stdbool.h>
#include <stdlib.h>

#define F_CPU   16000000UL


void soft_delay_us(uint16_t time)
{
	while (time--) {
		_delay_us(1.0);
	}
}

void line_low(void)
{
	PORTB &= ~(1 << 0);
	DDRB |= (1 << 0);
}

void line_release(void)
{
	DDRB &= ~(1 << 0);
	PORTB |= (1 << 0);
}

/* read the state of PB0, where 1-Wire data pin is situated */
bool line_read(void)
{
	uint8_t val = PINB & 0x01;
	return val;
}


int main(void)
{
	led_RGB led;
	led_RGB_init(&led, &PORTB, &DDRB, PB1, PB2, PB3, NULL);
	
	lock_st lock;
	lock_init(&lock, lock_lock_func_LED, lock_wait_func_LED,
		  lock_unlock_func_LED, DDRD, PORTD, PIND);
	
	ow_Pin_init(&(lock.data_pin), &line_low, &line_release, &line_read, 
		    &soft_delay_us, 5, 60, 60, 5);
	
	lock_interrupt_INT0_init();
	
	uart_init();
	set_sleep_mode(SLEEP_MODE_IDLE);
	sleep_enable();
	sei();

	uart_print_str("\n\nHello from avr lock\nYou can write such commands:\n");
	uart_print_str("\t-open -- unlock the lock\n\t-close -- lock the lock\n");
	uart_print_str("\t-watch all keys -- watch all keys, what are storaging at EEPROM\n");
	uart_print_str("\t-add new key -- add new 1-Wire ID as a new key to EEPROM\n");
	uart_print_str("\t-DELETE_ALL_KEYS_FROM_EEPROM -- delete ALL keys from EEPROM\n");
	
	ow_err err;

	uint8_t ibutton_id_compare[8]; /* here we will read 1-Wire id  */

	/* 01-serial number, 9A - CRC */
	uint8_t true_key[8] = {0x01, 0x31, 0x78, 0x83, 0x15, 0x00, 0x00, 0x9A};
	
	
	uart_put("\n\nparse EEPROM0:\n");
	for(uint16_t i = 0; i < 50; i++) {
		uart_print_uint8_hex(lock_eeprom_read_byte(i));
		uart_put(" ");
	}
	
// 	uart_put("\n\nclear EEPROM:\n");
// 	for(uint16_t i = 0; i < 24; i++) {
// 		lock_eeprom_write_byte(i, 0x00);
// 	}
	
	
	lock.num_keys = 0;
	
	
	while (1) {

// 		while (rxcflag) {
// 			if (uart_compare_with_rdbuff("open")) {
// 				uart_put("\nopened OK\n");
// 				lock.unlock_func(&led);
// 				sleep_ms(2000);
// 				lock.wait_func(&led);
// 			} else if (uart_compare_with_rdbuff("close")) {
// 				uart_put("\nclosed OK\n");
// 				lock.lock_func(&led);
// 				sleep_ms(1000);
// 				lock.wait_func(&led);
// 			} else if (uart_compare_with_rdbuff("watch all keys")) {
// 				uart_put("\nYour keys are:\n");
// 				for(uint8_t i = 0; i < lock.num_keys; i++) {
// 					uart_print_str("\n");
// 					uart_print_uint8_dec(i + 1);
// 					uart_print_str(" key =   ");
// 					for(uint16_t k = i * 8 + 1; k <= i * 8 + 1 + 7; k++) {
// 					uart_print_uint8_hex(lock_eeprom_read_byte(k));
// 					uart_put(" ");
// 					}
// 				}
// 			} else if(rdbuff[0] != '\0') {
// 				uart_put("Unknown command\n");
// 				uart_put(rdbuff);
// 			}
// 			rxcflag = false;
// 		}
		
		uart_lock_read(&lock, &led);
		
		lock_add_key_by_button(&lock, &led);
		lock_try_unlock_LED(&lock, &led, ibutton_id_compare, 
				    true, false);
	}
	
}
 
