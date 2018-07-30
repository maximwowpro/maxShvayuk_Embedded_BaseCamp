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
ISR(TIMER2_OVF_vect, ISR_BLOCK)
{
	TCCR2B &= ~((1 << CS22) | (1 << CS21) | (1 << CS20)); /* stop timer */
	/* It's often required to manually reset interrupt flag */
        /* to avoid infinite processing of it.                  */
        /* not on AVRs (unless OCB bit set)                     */
        /* 	TIFR2 &= ~TOV2;                                 */
}

ISR(TIMER1_COMPA_vect, ISR_BLOCK)
{
	time_data.seconds++;
	if(1 == time_data.stopwatch_status)
		time_data.stopwatch_seconds++;
	
	if(time_data.minutes == time_data.alarm_minutes && 
		time_data.hours == time_data.alarm_hours)
		alarm_action();
}


/* here interrupts triggered when button is pushed down */
bool mod = true; 
/* 
 * we use this variable to allow PCINT trigger not when we 
 * turn on and turn off button, but just when we turn on button
 */

ISR(PCINT2_vect, ISR_BLOCK)
{
	if(true == mod) {
		mod = !mod;
	
		if ( pool_button_low(&PIND, 2) ) { /* change display    */
			time_change_display(&time_data);
			return;
		}
		else if ( pool_button_low(&PIND, 3) ) {	  /* set current minutes */
			time_data.minutes++;
			return;
		}
		else if ( pool_button_low(&PIND, 4) ) {	  /* set current hours   */
			time_data.hours++;
			return;
		}
		else if ( pool_button_low(&PIND, 5) ) {     /* set alarm minutes    */
			time_data.alarm_minutes++;
			return;
		}
		else if ( pool_button_low(&PIND, 6) ) {     /* set alarm hours      */
			time_data.alarm_hours++;
			return;
		}
		else if ( pool_button_low(&PIND, 7) ) {	    /* controls stopwatch   */
			time_change_stopwatch(&time_data);
		}
	}
	else
		mod = !mod;
} 

// /* here interrupts triggered when button is picked up */
// bool mod = false; 
// /* 
// * we use this variable to allow PCINT trigger not when we 
// * turn on and turn off button, but just when we turn on button
// */
// 
// ISR(PCINT2_vect, ISR_BLOCK)
// {
// 	if(true == mod) {
// 		mod = !mod;
// 	
// 		if ( pool_button_high(&PIND, 2) ) { /* change display    */
// 			time_change_display(&time_data);
// 			return;
// 		}
// 		else if ( pool_button_high(&PIND, 3) ) {	  /* set current minutes */
// 			time_data.minutes++;
// 			return;
// 		}
// 		else if ( pool_button_high(&PIND, 4) ) {	  /* set current hours   */
// 			time_data.hours++;
// 			return;
// 		}
// 		else if ( pool_button_high(&PIND, 5) ) {     /* set alarm minutes    */
// 			time_data.alarm_minutes++;
// 			return;
// 		}
// 		else if ( pool_button_high(&PIND, 6) ) {     /* set alarm hours      */
// 			time_data.alarm_hours++;
// 			return;
// 		}
// 		else if ( pool_button_high(&PIND, 7) ) {	    /* controls stopwatch   */
// 			time_change_stopwatch(&time_data);
// 			return;
// 		}
// 	}
// 	else
// 		mod = !mod;
// }

static struct segm_Port PB = {
	.DDR = &DDRB,
	.PIN = &PINB,
	.PORT = &PORTB,
};

static struct segm_Display display_main = {
	.SHCP = {.port = &PB, .pin = 0}, /* SCLK */
	.STCP = {.port = &PB, .pin = 1}, /* RCLK */
	.DS   = {.port = &PB, .pin = 2}, /* DIO  */
	.delay_func = &_delay_loop_1,	/* 3 cycles / loop, busy wait */
	.sleep_ms_func = &sleep_ms,	
	.is_comm_anode = true		/* We have common cathode display */
};

static struct segm_Display display_additional = {
	.SHCP = {.port = &PB, .pin = 3},
	.STCP = {.port = &PB, .pin = 4},
	.DS   = {.port = &PB, .pin = 5},
	.delay_func = &_delay_loop_1,	/* 3 cycles / loop, busy wait */
	.sleep_ms_func = &sleep_ms,	
	.is_comm_anode = true		/* We have common cathode display */
};

int main(void)
{
	segm_init(&display_main);
	segm_init(&display_additional);

	config_timer_1();
	config_interrupts_PCINT();
	config_alarm_notification(&PINC, &PORTC, 5);
		
	//PORTD &= ~(1 << 0);
	
	time_init(&time_data, 15, 25, 13);
	time_set_alarm(&time_data, 26, 13);
	
	while(1) {
		print_time(&display_main, &display_additional, &time_data);
	}
}

