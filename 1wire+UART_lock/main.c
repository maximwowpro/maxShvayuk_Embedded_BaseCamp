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

/* USART RX Complete interrupt handler */
ISR(USART_RX_vect, ISR_BLOCK)
{	
	/* Buffer will contain the last N = <buffer_len> chars read */
	rdbuff[rdind] = UDR0;

	if ('\n' == rdbuff[rdind]) {
		rdbuff[rdind] = '\0';
		rxcflag = true;
		rdind = 0;
	} else {
		rxcflag = false;
		rdind++;
	}

	if (rdind >= BUFFER_LEN)
		rdind = 0;
}

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

bool line_read(void)
{
	uint8_t val = PINB & 0x01;
	return val;
}

void put(uint8_t byte)
{
	PORTB |= 1 << 3;
	soft_delay_us(20);
	PORTB &= ~(1 << 3);
	for (int i=0; i<8; i++) {
		if (byte & (1 << i))
			PORTB |= 1 << 3;
		else
			PORTB &= ~(1 << 3);
		soft_delay_us(20);
	}
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
	char* str = NULL; /* we need this stuff to print a numbers using UART*/
	
	uart_put("\n\nHello from avr_lock\n\n");
	
	ow_err err;

	uint8_t ibutton_id_compare[8];
	uint8_t crc;

	/* 01-serial number, 9A - CRC */
	uint8_t true_key[8] = {0x01, 0x31, 0x78, 0x83, 0x15, 0x00, 0x00, 0x9A};
	//if( 1 == lock_add_key(&lock, true_key) )
	//	uart_put("\n\nERROR!\n\n");
	
	
	uart_put("\n\nclear EEPROM:\n");
	for(uint16_t i = 0; i < 24; i++) {
		lock_eeprom_write_byte(i, 0xFF);		
	}
		
	uart_put("\n\nparse EEPROM0:\n");
	for(uint16_t i = 0; i < 24; i++) {
		uart_print_uint8_hex(lock_eeprom_read_byte(i), str);
		uart_put(" ");
	}
	
	
	lock.num_keys = 0;
	
	uint8_t *ibutton_id_EEPROM_test = malloc(8 * sizeof(*ibutton_id_EEPROM_test));
	uint8_t key_eeprom_test[8] = {0x01, 0x02, 0x03, 0x04, 0x05/*0x15*/, 0x06, 0x07, 0x08};
	
	lock_eeprom_write_key(&lock, key_eeprom_test);
	ibutton_id_EEPROM_test = lock_eeprom_read_key(&lock, 1, ibutton_id_EEPROM_test);
	
	uart_put("\ntest EEPROM1 = ");
	uart_print_1wire_id_hex(ibutton_id_EEPROM_test);
 	uart_put("\nnum keys1 = ");
 	uart_print_uint8_dec(lock.num_keys, str);
	
	
	uart_put("\n\nparse EEPROM1:\n");
	for(uint16_t i = 0; i < 24; i++) {
		uart_print_uint8_hex(lock_eeprom_read_byte(i), str);
		uart_put(" ");
	}
	
	
	
// 	lock_eeprom_write_key(&lock, true_key);
// 	ibutton_id_EEPROM_test = lock_eeprom_read_key(&lock, 2, ibutton_id_EEPROM_test);
// 		
// 	uart_put("\ntest EEPROM2 = ");
// 	uart_print_1wire_id_hex(ibutton_id_EEPROM_test);
//  	uart_put("\nnum keys2 = ");
//  	uart_print_uint8_dec(lock.num_keys, str);
// 	
	
	uart_put("\n\nparse EEPROM2:\n");
	for(uint16_t i = 0; i < 24; i++) {
		uart_print_uint8_hex(lock_eeprom_read_byte(i), str);
		uart_put(" ");
	}
	
	
	
	
	while (1) {
		lock_add_key_by_button(&lock, &led);
		lock_try_unlock_LED(&lock, &led, ibutton_id_compare, 
				    &crc, true, false);
	}
	
}
 
