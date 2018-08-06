/* In contrast to our previous examples, this one is not library.
 * UART lib is worthless if its string output does not rely on a
 * triple-buffered streams with proper synchronization mechanisms.
 * 
 * The main point of this code is to *illustrate* the core concepts.
 *
 * Thus the code below *should not* be reused in any way.
 * Your specific task being solved deserves own specific code.
 */

#include "print_uart.h"

#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/sleep.h>
#include <avr/power.h>
#include <util/atomic.h>

#include <stdbool.h>
#include <stdlib.h>

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


int main()
{
	DDRB |= (1 << 0) | (1 << 1);
	PORTB |= (1 << 0);

	uart_init();

	set_sleep_mode(SLEEP_MODE_IDLE);
	sleep_enable();
	sei();

	uart_put("\n\nHello from avr\n\n");

	char *led[] = {"LED is OFF\n", "LED is ON\n"};
	
	char* str = NULL;
	uart_put(to_string_uint16(ubrr_val, str)); uart_put("\n");
	
	while(1) {
  		while (!rxcflag)
  			sleep_cpu();
  		rxcflag = false;
		
		if (atomic_str_eq(rdbuff, "led on")) {
			PORTB |= (1 << 0);
			uart_put(led[1]);
		} else if (atomic_str_eq(rdbuff, "led off")) {
			PORTB &= ~(1 << 0);
			uart_put(led[0]);
		} else if (atomic_str_eq(rdbuff, "led state")) {
			uart_put("State: ");
			uart_put(led[PORTB & 0x01]);
		} else if (atomic_str_eq(rdbuff, "var val")) {
			uart_put("\nstr ==");
			uart_put(to_string_uint16(0, str)); uart_put("\n");
			uart_put(to_string_uint16(1, str)); uart_put("\n");
			uart_put(to_string_uint16(11, str)); uart_put("\n");
			uart_put(to_string_uint16(111, str)); uart_put("\n");
			uart_put(to_string_uint16(256, str)); uart_put("\n");
			uart_put(to_string_uint16(1111, str)); uart_put("\n");
			uart_put(to_string_uint16(11111, str)); uart_put("\n");
			uart_put(to_string_uint16(65535, str)); uart_put("\n");
			uart_put(to_string_uint16(65536, str)); uart_put("\n");
			uart_put("\n");
		} else {
			uart_put("Unknown command\n");
			uart_put(rdbuff);
		}
		
	}
}
