#ifndef F_CPU
#define F_CPU   16000000UL
#endif

#ifndef CLOCK_H
#define CLOCK_H

#include "segm.h"

#include <avr/io.h>
#include <avr/sleep.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include <stdint.h>
#include <stdbool.h>


struct time {
	/* current time */
	uint8_t seconds;
	uint8_t minutes;
	uint8_t hours;
	
	/* alarm time */
	uint8_t alarm_minutes;
	uint8_t alarm_hours;
	
	/* stopwatch time:
	 * max stopwatch time is 255 hours, 59 minutes, 59 seconds;
	 * stopwatch_status: stopwatch can work in 3 modes:
	 * - all zeroes (not working)  	        (stopwatch_status == 0)
	 * - considers time and shows time      (stopwatch_status == 1)
	 * - NOT considers time, but shows time (stopwatch_status == 2)
	 */
	uint8_t stopwatch_status;
	uint8_t stopwatch_seconds;
	uint8_t stopwatch_minutes;
	uint8_t stopwatch_hours;
	
	/*
	* displayed_unit: clock can shows:
	* - current time (displayed_unit == 0)
	* - alarm time   (displayed_unit == 1)
	* - stopwatch    (displayed_unit == 2)
	*/
	uint8_t displayed_unit;
};


inline void time_init(struct time *time_init, uint8_t start_seconds, 
		       uint8_t start_minutes, uint8_t start_hours)
{
	/* init current time 			  */
 	time_init->seconds = start_seconds;
 	time_init->minutes = start_minutes;
 	time_init->hours = start_hours;
	
	/* init alarm and stopwatch by zeroes     */
	time_init->alarm_minutes = 0;
	time_init->alarm_hours   = 0;
	
	time_init->stopwatch_status  = 0;
	time_init->stopwatch_seconds = 0;
	time_init->stopwatch_minutes = 0;
	time_init->stopwatch_hours   = 0;
	
	/* default displayed unit is current time */
	time_init->displayed_unit = 0;
}


inline void time_set_alarm(struct time *time_init, 
			   uint8_t alarm_minutes_init, 
			   uint8_t alarm_hours_init)
{
	time_init->alarm_minutes = alarm_minutes_init;
	time_init->alarm_hours = alarm_hours_init;
}


inline void time_update_clock(struct time *time_update)
{
	/* update current time 				*/
	if(time_update->seconds >= 60) {
		time_update->minutes++;
		time_update->seconds = 0;
	}
	if(time_update->minutes >= 60) {
		time_update->hours++;
		time_update->minutes= 0;
	}
	if(time_update->hours > 23)
		time_update->hours = 0;
	
	
	/* update alarm time 				*/
	if(time_update->alarm_minutes > 59) {
		time_update->alarm_minutes= 0;
	}
	if(time_update->alarm_hours > 23)
		time_update->alarm_hours = 0;
	
	
	/* update stopwatch time 			*/
	if(1 == time_update->stopwatch_status) {
		if(time_update->stopwatch_seconds >= 60) {
			time_update->stopwatch_minutes++;
			time_update->stopwatch_seconds = 0;
		}
		if(time_update->stopwatch_minutes >= 60) {
			time_update->stopwatch_hours++;
			time_update->stopwatch_minutes = 0;
		}
	}
	if(0 == time_update->stopwatch_status) {
		time_update->stopwatch_seconds = 0;
		time_update->stopwatch_minutes = 0;
		time_update->stopwatch_hours   = 0;
	}
}


/*
 * time_change_display: clock can shows:
 * - current time (displayed_unit == 0)
 * - alarm time   (displayed_unit == 1)
 * - stopwatch    (displayed_unit == 2)
 */
inline void time_change_display(struct time *time_update)
{
	if(time_update->displayed_unit >= 2)
		time_update->displayed_unit  = 0;
	else
		(time_update->displayed_unit)++;
}


/* time_change_stopwatch: stopwatch can work in 3 modes:
 * - all zeroes (not working)  	 		       (stopwatch_status == 0)
 * - considers time and shows time (like common clock) (stopwatch_status == 1)
 * - NOT considers time, but shows time 	       (stopwatch_status == 2)
 */
inline void time_change_stopwatch(struct time *time_update)
{
	if(time_update->stopwatch_status >= 2)
		time_update->stopwatch_status  = 0;
	else
		(time_update->stopwatch_status)++;
}


inline void config_timer_1(void)
{
	OCR1A = 15625;/*F_CPU / 1024 = 15625; OCR1A - comparing register  */
	
	TCCR1B |= (1 << WGM12); 	     /* set working mode          */
	TCCR1B |= (1 << CS12) | (1 << CS10); /* set prescaler = 1024      */
	
	TIMSK1 |= (1 << OCIE1A); /* allow interrupts (TIMER1 COMP A mode) */
}


inline void config_interrupts_PCINT(void)
{
	DDRD  = 0; 		/* set pins like "input" 		  */
	PCICR |= (1 << PCIE2);  /* allow interrupts for group 2 	  */
	PCMSK2 = 0b11111110;    /* allow interrupts on PCINT17 - PCINT 23 */
}

/* config_alarm_notification: set pin, where alarm is situated
 * alarm is the common LED, which flashes with period of 1 second
 */
inline void config_alarm_notification(volatile uint8_t *PIN,
				      volatile uint8_t *PORT, uint8_t pin)
{
	*PIN  |=  (1 << pin); /* set as output 		    */
	*PORT &= ~(1 << pin); /* set low logic level at pin */
}


inline void alarm_action(volatile uint8_t *PORT, uint8_t pin)
{
	*PORT ^= (1 << pin);
}

/*
 * display_main       - display for minutes and seconds
 * display_additional - display for hours and work mode
 */
void print_time(struct segm_Display *display_main, 
		struct segm_Display *display_additional,  
		struct time *time_print);


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

/*
 * this function fights with contact bounce
 */
bool pool_button_low(volatile uint8_t *PIN, uint8_t pin);

#endif
