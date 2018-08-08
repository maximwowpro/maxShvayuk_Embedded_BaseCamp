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
