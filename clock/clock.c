#include "clock.h"
#include "segm.h"

#include <avr/io.h>
#include <avr/sleep.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include <stdint.h>
#include <stdbool.h>

void sleep_ms(uint16_t ms_val)
{
	set_sleep_mode(SLEEP_MODE_PWR_SAVE);
	cli();		/* Disable interrupts -- as memory barrier */
	sleep_enable();	
	sei();  	/* Enable interrupts. We want to wake up, don't we? */
	TIMSK2 |= (1 << TOIE2);
	while (ms_val--) {
		/* Count 1 ms from TCNT2 to 0xFF (up direction) */
		TCNT2 = (uint8_t)(0xFF - (F_CPU / 128) / 1000);

		/* Enable Timer2 */
		TCCR2B =  (1 << CS22) | (1 << CS20); /* f = Fclk_io / 128, start timer */

		sleep_cpu();	/* Put MCU to sleep */
	}
	sleep_disable();
}

extern void time_init(struct time *time_init, uint8_t start_seconds, 
		       uint8_t start_minutes, uint8_t start_hours);

extern inline void time_set_alarm(struct time *time_init, 
			   uint8_t alarm_minutes_init, uint8_t alarm_hours_init);

extern void time_update_clock(struct time *time_update);

extern void time_change_display(struct time *time_update);

extern void config_timer_1(void);

extern void config_interrupts_INT(void);

extern void config_interrupts_PCINT(void);

void print_time(struct segm_Display *display_main, 
		struct segm_Display *display_additional,  struct time *time_print)
{
	/* display_main - minutes + seconds; display_additional - hours */
	time_update_clock(time_print);
	
	uint8_t symbols_main[4];
	uint8_t symbols_additional[4];
	/* displays current time */
	if(0 == time_print->displayed_unit) {
		symbols_main[0] = segm_sym_table[ time_print->minutes / 10 ];
		/* we use + 0x80 to light a decimal point */
		symbols_main[1] = segm_sym_table[ time_print->minutes % 10 ] + 0x80;
		symbols_main[2] = segm_sym_table[ time_print->seconds / 10 ];
		symbols_main[3] = segm_sym_table[ time_print->seconds % 10 ];
		
		symbols_additional[0] = ( (display_main->is_comm_anode) ? ~0x39 : 0x39 ); /* letter C */ 
		symbols_additional[1] = ( (display_main->is_comm_anode) ?  0xFF : 0x00 );
		symbols_additional[2] = segm_sym_table[ time_print->hours / 10 ];
		symbols_additional[3] = segm_sym_table[ time_print->hours % 10 ];
	}
	/* displays alarm, no additional display here */
	if(1 == time_print->displayed_unit) {
		symbols_main[0] = segm_sym_table[ time_print->alarm_minutes / 10 ];
		symbols_main[1] = segm_sym_table[ time_print->alarm_minutes % 10 ];
		symbols_main[2] = ( (display_main->is_comm_anode) ? 0xFF : 0x00 );
		symbols_main[3] = ( (display_main->is_comm_anode) ? 0xFF : 0x00 );
		
		symbols_additional[0] = ( (display_main->is_comm_anode) ? ~0x77 : 0x77 ); /* letter A */
		symbols_additional[1] = ( (display_main->is_comm_anode) ?  0xFF : 0x00 );
		symbols_additional[2] = segm_sym_table[ time_print->alarm_hours   / 10 ];
		symbols_additional[3] = segm_sym_table[ time_print->alarm_hours   % 10 ];
	}
	/* displays stopwatch time */
	if(2 == time_print->displayed_unit) {
		symbols_main[0] = segm_sym_table[ time_print->stopwatch_minutes / 10 ];
		symbols_main[1] = segm_sym_table[ time_print->stopwatch_minutes % 10 ] + 0x80;
		symbols_main[2] = segm_sym_table[ time_print->stopwatch_seconds / 10 ];
		symbols_main[3] = segm_sym_table[ time_print->stopwatch_seconds % 10 ];
		
		symbols_additional[0] = ( (display_main->is_comm_anode) ? ~0xB3 : 0xB3 );
		uint8_t tmp = time_print->stopwatch_hours / 100;
		symbols_additional[1] = segm_sym_table[tmp];
		tmp = (time_print->stopwatch_hours - 100 * tmp) / 10;
		symbols_additional[2] = segm_sym_table[tmp];
		symbols_additional[3] = segm_sym_table[ (time_print->stopwatch_hours - 10 * tmp) % 100];
	}
	
	segm_indicate4(display_main, symbols_main);
	segm_indicate4(display_additional, symbols_additional);
}


void time_change_system(struct time *change_time)
{
	/* convert from 24-hours to AM/PM system */
	if( true == change_time->time_system ) {
		change_time->time_system = false;
		
		if( change_time->hours > 12 ) {
			change_time->hours -= 12;
			change_time->is_hours_PM = true;
		}
		if( change_time->alarm_hours > 12 ) {
			change_time->alarm_hours -= 12;
			change_time->is_alarm_PM = true;
		}
	}
	
	/* convert from AM/PM system to 24 hours */
	if( false == change_time->time_system ) {
		change_time->time_system = true;
		
		if( true == change_time->is_hours_PM ) {
			change_time->hours += 12;
			change_time->is_hours_PM = false;
		}
		if( true == change_time->is_alarm_PM ) {
			change_time->alarm_hours += 12;
			change_time->is_alarm_PM = false;
		}
	}
	
}


extern void soft_delay(volatile uint16_t N);


extern void config_alarm_notification(volatile uint8_t *PIN,
				      volatile uint8_t *PORT,uint8_t pin);

extern void alarm_action();


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

// bool pool_button_high(volatile uint8_t *PIN, uint8_t pin)
// {
// 	/* triggered when button was picked up */
// 	/* button should be pulled - up to GND */
// 	/* we check contact's bounce in was_pushed variable and for() loop */
// 	bool was_pushed = false;
// 	for(uint8_t i=0; i < 255; i++) {
// 		if( ((*PIN) & (1 << pin)) )
// 			was_pushed = true;
// 	}
// 	if( !((*PIN) & (1 << pin)) && was_pushed ) {
// 		soft_delay(200);
// 		if( !((*PIN) & (1 << pin)) ) {
// 			return true;
// 		}
// 	}
// 	return false;	
// }


