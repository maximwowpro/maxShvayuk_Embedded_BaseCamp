/*
 * This library allow you to work with RGB LED with ATMEGA 328p
 */

#ifndef LED_RGB_H
#define LED_RGB_H

#include <avr/io.h>

/* struct __led_RGB: a struct to manage RGB LED
 * 
 * @red   - intensity of red   LED (0 - 255)
 * @green - intensity of green LED (0 - 255)
 * @blue  - intensity of blue  LED (0 - 255)
 * 
 * @pin_red   - number of pin of PORTx where red   LED is connected
 * @pin_green - number of pin of PORTx where green LED is connected
 * @pin_blue  - number of pin of PORTx where blue  LED is connected
 * 
 * @PORT - pointer to PORTx register, where all LEDs are connected
 * @DDR  - pointer to DDRx  register, where all LEDs are connected
 * 
 * @delay_func - pointer to delay function. Using this function, we can 
 * 		 implement PWM to control the intensity of every LED and
 * 		 get any color
 */
typedef struct __led_RGB {
	uint8_t red;
	uint8_t green;
	uint8_t blue;
	
	uint8_t pin_red;
	uint8_t pin_green;
	uint8_t pin_blue;
	
	volatile uint8_t *PORT;
	volatile uint8_t *DDR;
	
	void (*delay_func)(uint8_t); /* Using this func, we can implement PWM */
	
} led_RGB;

void led_RGB_init(led_RGB *led, volatile uint8_t *PORT, volatile uint8_t *DDR,
		  uint8_t pin_red, uint8_t pin_green, uint8_t pin_blue,
		 void (*delay_func)(uint8_t) );


/*
 * set intencity of every LED - from 0 to 255
 * we need this func to get any color from LED
 */
void led_RGB_set(led_RGB *led, uint8_t red, uint8_t green, uint8_t blue);


/*
 * TODO: implement this delay func using sleep_cpu() function
 */
void led_delay_func(uint8_t ms);


/*
 * TODO: implement this PWM func using hardware timer 
 */
void led_pwm(uint8_t brightness);


/*
 * red   LED - turn on
 * green LED - turn off
 * blue  LED - turn off
 */
void led_RGB_red(led_RGB *led);


/*
 * red LED - turn off
 * red LED - turn on
 * red LED - turn off
 */
void led_RGB_green(led_RGB *led);


/*
 * red   LED - turn off
 * green LED - turn off
 * blue  LED - turn on
 */
void led_RGB_blue(led_RGB *led);


#endif
