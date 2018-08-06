#ifndef F_CPU
#define F_CPU   16000000UL
#endif

#include "led_rgb.h"
#include "onewire.h"

#include <avr/io.h>
#include <avr/interrupt.h>

void led_RGB_init(led_RGB *led, volatile uint8_t *PORT, volatile uint8_t *DDR,
		  uint8_t pin_red, uint8_t pin_green, uint8_t pin_blue,
		  void (*delay_func)(uint8_t) )
{
	led->red   = 0;
	led->green = 0;
	led->blue  = 0;
	
	led->pin_red   = pin_red;
	led->pin_green = pin_green;
	led->pin_blue  = pin_blue;
	
	led->PORT = PORT;
	led->DDR  = DDR;
	
	*(led->DDR ) |=  (1 << pin_red) |  (1 << pin_green) |  (1 << pin_blue);
	*(led->PORT) &= ~(1 << pin_red) | ~(1 << pin_green) | ~(1 << pin_blue);
	
	led->delay_func = delay_func;
}

void led_RGB_red(led_RGB *led)
{
	led->red   = 0xFF;
	led->green = 0x00;
	led->blue  = 0x00;
	
	*(led->PORT) |=  (1 << led->pin_red);
	*(led->PORT) &= ~(1 << led->pin_green) & ~(1 << led->pin_blue);
}

void led_RGB_green(led_RGB *led)
{
	led->red   = 0x00;
	led->green = 0xFF;
	led->blue  = 0x00;
	
	*(led->PORT) |=  (1 << led->pin_green);
	*(led->PORT) &= ~(1 << led->pin_red) & ~(1 << led->pin_blue);
}

void led_RGB_blue(led_RGB *led)
{
	led->red   = 0x00;
	led->green = 0x00;
	led->blue  = 0xFF;
	
	*(led->PORT) |=  (1 << led->pin_blue);
	*(led->PORT) &= ~(1 << led->pin_red) & ~(1 << led->pin_green);
}

// /*
//  * delay using timer 0.
//  * "delay" max value is 16 ms
//  */
// void pwm_timer0_A(uint8_t delay)
// {
// 	if(delay > 16)
// 		delay = 16;
// 	
// 	
// 	DDRD |= (1 << PD6);
// 	
// 	sei(); /* enable interrupts */
// 	/* how we got 15:
// 	 * F_CPU = 16000000 Hz
// 	 * timer's prescaler = 1024
// 	 * timer's compare register OCR0A max value = 255
// 	 * so:  16000000 / 1024 = 15625 ticks of timer0 per second.
// 	 * 1 tick's duration is: 1 / 15625 = 0.000064 s = 0.064 ms
// 	 * 1 / 0.064 = 15.625 ≈ 15
// 	 */
// 	OCR0A = delay * 15;
// 	TCCR0A |= (1 << WGM01) | (1 << WGM00);/* set work mode as PWM	     */
// 	TCCR0A |= (1 << COM0A0);	      
// 	TCCR0B |= (1 << CS02) | (1 << CS00); /* set prescaler as 1024       */
// 	TCCR0B |= (1 << WGM02);
// 	TIMSK0 |= (1 << OCIE0A); 	      /* allow interrupts for timer0 */	
// }*/

