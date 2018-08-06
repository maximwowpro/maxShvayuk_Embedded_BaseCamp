#ifndef F_CPU
#define F_CPU   16000000UL
#endif

#include <avr/io.h>
#include <avr/sleep.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include <stdint.h>

/* this variable changes the speed of LED`s flashing */
const uint16_t delay_ms = 20;

void sleep_ms(uint16_t ms_val)
{
	/* Set Power-Save sleep mode */
	set_sleep_mode(SLEEP_MODE_PWR_SAVE);
	cli();		/* Disable interrupts -- as memory barrier */
	sleep_enable();	/* Set SE (sleep enable bit) */
	sei();  	/* Enable interrupts.*/
	TIMSK2 |= (1 << TOIE2); /* Enable Timer2 Overflow interrupt by mask */
	while (ms_val--) {
		/* Count 1 ms from TCNT2 to 0xFF (up direction) */
		TCNT2 = (uint8_t)(0xFF - (F_CPU / 128) / 1000);

		/* Enable Timer2 */
		TCCR2B =  (1 << CS22) | (1 << CS20); /* f = Fclk_io / 128, start timer */

		sleep_cpu();	/* Put MCU to sleep */
	}
	sleep_disable();	/* Disable sleeps for safety */		
}

static void soft_delay(volatile uint16_t N)
{
	/* If volatile is not used, AVR-GCC will optimize this stuff out     */
        /* making our function completely empty                              */
	volatile uint8_t inner = 0xFF;
	while (N--) {
		while (inner--);
	}
	return;
}

void pwm_timer(volatile uint8_t brightness) /* brihtness is from 0 to 255 */
{
	OCR0A = brightness;
	//sleep_ms(delay_ms);
	
	soft_delay(700);
	
	return;
}

uint16_t generator()
{
	static uint16_t val = 7;
	val = ((171 * val + 11213) % 53125);
	return val;
}

void candle()
{
	uint16_t gen = generator();
	if(gen > 40906)
		pwm_timer(255);
	else if(gen > 32406)
		pwm_timer(232);
	else if(gen > 27625)
		pwm_timer(217);
	else if(gen > 24969)
		pwm_timer(200);
	else if(gen > 22313)
		pwm_timer(182);
	else if(gen > 19656)
		pwm_timer(167);
	else if(gen > 17000)
		pwm_timer(150);

	
	return;
}
int main(void)
{
	DDRD |= 1 << 6; /* arduino pin 6 */
	
	TCCR0A|=(1<<COM0B1)|(0<<COM0B0)|(1<<WGM00)|(1<<WGM01)|(1<<COM0A1)|(0<<COM0A0);
	TCCR0B|=(0<<WGM02)|(1<<CS00);
	
	while(1) 
		candle();
	
	return 0;
} 
