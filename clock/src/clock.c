#include "clock.h"
#include "segm.h"

#include <avr/io.h>
#include <avr/sleep.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include <stdint.h>
#include <stdbool.h>


extern void time_init(struct time *time_init, uint8_t start_seconds,
		      uint8_t start_minutes, uint8_t start_hours  );

extern inline void time_set_alarm(struct time *time_init, 
				  uint8_t alarm_minutes_init, 
				  uint8_t alarm_hours_init);

extern void time_update_clock(struct time *time_update);

extern void time_change_display(struct time *time_update);

extern void time_change_stopwatch(struct time *time_update);

extern void config_timer_1(void);

extern void config_interrupts_PCINT(void);

extern void config_alarm_notification(volatile uint8_t *PIN,
				      volatile uint8_t *PORT, uint8_t pin);

extern void alarm_action(volatile uint8_t *PORT, uint8_t pin);


/*
 * display_main       - display for minutes and seconds
 * display_additional - display for hours and work mode
 */
void print_time(struct segm_Display *display_main, 
		struct segm_Display *display_additional,  
		struct time *time_print)
{
	time_update_clock(time_print);
	
	/* arrays for numbers which should de displayed */
	uint8_t symbols_main[4];
	uint8_t symbols_additional[4];
	
	/* displays current time */
	if(0 == time_print->displayed_unit) {
		/* minutes */
		symbols_main[0] = segm_sym_table[ time_print->minutes / 10 ];
		/* we use + 0x80 to light a decimal point */
		symbols_main[1] = segm_sym_table[ time_print->minutes % 10 ] 
				+ 0x80;
		/* seconds */
		symbols_main[2] = segm_sym_table[ time_print->seconds / 10 ];
		symbols_main[3] = segm_sym_table[ time_print->seconds % 10 ];
		/* letter C - "Current time" */
		symbols_additional[0] = 
			( (display_main->is_comm_anode) ? ~0x39 : 0x39 );
		/* decimal point */
		symbols_additional[1] = ( (display_main->is_comm_anode) ?  0xFF : 0x00 );
		/* hours */
		symbols_additional[2] = segm_sym_table[ time_print->hours / 10 ];
		symbols_additional[3] = segm_sym_table[ time_print->hours % 10 ];
	}
	
	/* displays alarm, no seconds here */
	if(1 == time_print->displayed_unit) {
		/* minutes */
		symbols_main[0] = segm_sym_table[ time_print->alarm_minutes / 10 ];
		symbols_main[1] = segm_sym_table[ time_print->alarm_minutes % 10 ];
		/* displays nothing */
		symbols_main[2] = ( (display_main->is_comm_anode) ? 0xFF : 0x00 );
		symbols_main[3] = ( (display_main->is_comm_anode) ? 0xFF : 0x00 );
		/* letter A - "Alarm" */
		symbols_additional[0] = ( (display_main->is_comm_anode) ? ~0x77 : 0x77 );
		/* displays nothing   */
		symbols_additional[1] = ( (display_main->is_comm_anode) ?  0xFF : 0x00 );
		/* hours */
		symbols_additional[2] = segm_sym_table[ time_print->alarm_hours   / 10 ];
		symbols_additional[3] = segm_sym_table[ time_print->alarm_hours   % 10 ];
	}
	
	/* displays stopwatch time */
	if(2 == time_print->displayed_unit) {
		/* minutes */
		symbols_main[0] = 
			segm_sym_table[ time_print->stopwatch_minutes / 10 ];
		symbols_main[1] = 
			segm_sym_table[ time_print->stopwatch_minutes % 10 ] + 0x80;
		/* seconds */
		symbols_main[2] = 
			segm_sym_table[ time_print->stopwatch_seconds / 10 ];
		symbols_main[3] = 
			segm_sym_table[ time_print->stopwatch_seconds % 10 ];
		/* 
		 * letter R - "Run" (bacause letter "S" - "Stopwatch" 
		 * isn`t beautiful at 7-segment display
		 */
		symbols_additional[0] = ( (display_main->is_comm_anode) ? ~0xB3 : 0xB3 );
		/* hours */
		uint8_t tmp = time_print->stopwatch_hours / 100;
		symbols_additional[1] = segm_sym_table[tmp];
		tmp = (time_print->stopwatch_hours - 100 * tmp) / 10;
		symbols_additional[2] = segm_sym_table[tmp];
		symbols_additional[3] = segm_sym_table[ (time_print->stopwatch_hours - 10 * tmp) % 100];
	}
	
	segm_indicate4(display_main, symbols_main);
	segm_indicate4(display_additional, symbols_additional);
}



/*
 * simple software delay
 */
extern void soft_delay(volatile uint16_t N);


/*
 * this function fights with contact bounce
 */
bool pool_button_low(volatile uint8_t *PIN, uint8_t pin)
{	
	/* triggered when button was pushed */
	/* button should be pulled - up to GND */
	if( ((*PIN) & (1 << pin)) ) {
		soft_delay(200);
		if( ((*PIN) & (1 << pin)) ) {
			return true;
		}
	}
	return false;
}
