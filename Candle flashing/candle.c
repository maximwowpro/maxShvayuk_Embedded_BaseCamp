#include <avr/io.h>
#include <stdint.h>

/* this variable changes the speed of LED`s flashing */
const uint16_t speed = 7;

/**
 * soft_delay() - wastes CPU time crunching cycle to achieve delay
 * @N:	number of outer "while" steps.
 */
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

/* brightness in percents 100 - 5V; 50 - 2.5 V; 0 - 0V*/
static void soft_pwm(volatile uint16_t brightness) 
{
	for(uint16_t i = 0; i < speed; i++)
	{
		PORTB |= 1 << 5;
		soft_delay(brightness);
	
		PORTB &= 0 << 5;
		soft_delay(100 - brightness);
	}
	
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
		soft_pwm(100);
	else if(gen > 32406)
		soft_pwm(93);
	else if(gen > 27625)
		soft_pwm(87);
	else if(gen > 24969)
		soft_pwm(80);
	else if(gen > 22313)
		soft_pwm(73);
	else if(gen > 19656)
		soft_pwm(67);
	else if(gen > 17000)
		soft_pwm(60);
	else if(gen > 14344)
		soft_pwm(53);
	else if(gen > 11688)
		soft_pwm(47);
	else if(gen >  9031)
		soft_pwm(40);
	else if(gen >  6375)
		soft_pwm(33);
	else if(gen >  3719)
		soft_pwm(27);
	else if(gen >  1594)
		soft_pwm(20);
	else if(gen >  1063)
		soft_pwm(13);
	else if(gen >   531)
		soft_pwm(7);
	else 
		soft_pwm(1);
	
	return;
}
int main(void)
{
	/* Configure GPIO */
	DDRB |= 1 << 5;			/* set PB5 to output */
	PORTB |= 1 << 5;		/* set output to 1   */

	while(1) 
		candle();
	
	return 0;
} 
