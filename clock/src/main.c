#include "segm.h"
#include "clock.h"

#include <avr/io.h>
#include <avr/sleep.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include <stdint.h>
#include <stdbool.h>

struct time time_data;

/*
 * define interruptions handlers
 */
ISR(TIMER1_COMPA_vect, ISR_BLOCK)
{
	time_data.seconds++;
	if(1 == time_data.stopwatch_status)
		time_data.stopwatch_seconds++;
	
	/* here alarm is implemented */
	if(time_data.minutes == time_data.alarm_minutes && 
		time_data.hours == time_data.alarm_hours)
		alarm_action(&PORTC, 5);
}

/* if we use PCINT interrupts - interrupt occurs when the logic level of a pin
 * changes. I.e. interuption occurs when we click on the button and when we 
 * release the button. To handle ONLY interrupt when we click on the button, 
 * I use variable mod and if-else operator inside ISR.
 * Jther words, we use this variable to allow PCINT trigger not when we 
 * turn on and turn off button, but just when we push button down.
 */
volatile bool mod = true; 

ISR(PCINT2_vect, ISR_BLOCK)
{
	if(true == mod) {
		mod = !mod;
	
		if ( pool_button_low(&PIND, 2) ) {     /* change display    */
			time_change_display(&time_data);
			return;
		}
		else if ( pool_button_low(&PIND, 3) ) {/*set current minutes*/
			time_data.minutes++;
			return;
		}
		else if ( pool_button_low(&PIND, 4) ) {/* set current hours */
			time_data.hours++;
			return;
		}
		else if ( pool_button_low(&PIND, 5) ) {/* set alarm minutes */
			time_data.alarm_minutes++;
			return;
		}
		else if ( pool_button_low(&PIND, 6) ) {/* set alarm hours   */
			time_data.alarm_hours++;
			return;
		}
		else if ( pool_button_low(&PIND, 7) ) {/* controls stopwatch*/
			time_change_stopwatch(&time_data);
		}
		else {
			/* I had a big problems with quality of interruptions
			 * handling. I think that the reason of it is 
			 * Metastability of microchips in 7-segment displays.
			 * Read more about it:
		* https://en.wikipedia.org/wiki/Metastability_(electronics)
			 * This else - statement solves this problem.
			 * Try to comment it and click the buttons very fast -
			 * you will see the problem.
			 */
			mod = !mod;
		}
	}
	else
		mod = !mod;
} 


static struct segm_Port PB = {
	.DDR = &DDRB,
	.PIN = &PINB,
	.PORT = &PORTB,
};

static struct segm_Display display_main = {
	.SHCP = {.port = &PB, .pin = 0}, /* SCLK */
	.STCP = {.port = &PB, .pin = 1}, /* RCLK */
	.DS   = {.port = &PB, .pin = 2}, /* DIO  */
	.delay_func = &_delay_loop_1,	 /* 3 cycles / loop, busy wait     */
	.sleep_ms_func = &soft_delay,	
	.is_comm_anode = true		 /* We have common cathode display */
};

static struct segm_Display display_additional = {
	.SHCP = {.port = &PB, .pin = 0}, /* SCLK */
	.STCP = {.port = &PB, .pin = 1}, /* RCLK */
	.DS   = {.port = &PB, .pin = 3}, /* DIO  */
	.delay_func = &_delay_loop_1,	 /* 3 cycles / loop, busy wait     */
	.sleep_ms_func = &soft_delay,
	.is_comm_anode = true	    	 /* We have common cathode display */
};

int main(void)
{
	segm_init(&display_main);
	segm_init(&display_additional);

	config_timer_1();
	config_interrupts_PCINT();
	config_alarm_notification(&PINC, &PORTC, 5); /* alarm's LED on PC5 */
	
	time_init(&time_data, 00, 10, 17);
	time_set_alarm(&time_data, 15, 17);
	
	sei(); /* allow interrupts */
	
	while(1) {
		print_time(&display_main, &display_additional, &time_data);
	}
}

