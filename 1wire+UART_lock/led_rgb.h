#ifndef LED_RGB_H
#define LED_RGB_H

#include <avr/io.h>

typedef struct __led_RGB {
	uint8_t red;
	uint8_t green;
	uint8_t blue;
	
	uint8_t pin_red;
	uint8_t pin_green;
	uint8_t pin_blue;
	
	volatile uint8_t *PORT;
	volatile uint8_t *DDR;
	
	void (*delay_func)(uint8_t);
	
} led_RGB;

void led_RGB_init(led_RGB *led, volatile uint8_t *PORT, volatile uint8_t *DDR,
		  uint8_t pin_red, uint8_t pin_green, uint8_t pin_blue,
		 void (*delay_func)(uint8_t) );

void led_RGB_set(led_RGB *led, uint8_t red, uint8_t green, uint8_t blue);

void led_RGB_red(led_RGB *led);

void led_RGB_green(led_RGB *led);

void led_RGB_blue(led_RGB *led);

// /*
//  * delay using timer 0
//  */
// //void pwm_timer0_A(uint8_t delay);


#endif
