#include "print_uart.h"

#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/sleep.h>
#include <avr/power.h>
#include <util/atomic.h>

#include <stdbool.h>
#include <stdlib.h>

/* USART RX Complete interrupt handler */
ISR(USART_RX_vect, ISR_BLOCK)
{	
	/* Buffer will contain the last N = <buffer_len> chars read */
	rdbuff[rdind] = UDR0;

	if ('\n' == rdbuff[rdind]) {
		rdbuff[rdind] = '\0';
		rxcflag = true;
		rdind = 0;
	} else {
		rxcflag = false;
		rdind++;
	}

	if (rdind >= BUFFER_LEN)
		rdind = 0;
}

void ADC_Init(){
 ADCSRA |= (1 << ADEN) // Включаем АЦП
 |(1 << ADPS1)|(1 << ADPS0);    // устанавливаем предделитель преобразователя на 8
 ADMUX |= (0 << REFS1)|(1 << REFS0) //выставляем опорное напряжение, как внешний ИОН
 |(0 << MUX0)|(0 << MUX1)|(0 << MUX2)|(0 << MUX3); // снимать сигнал будем с  входа PC0 
}

int main()
{
	uint16_t u = 0;
	
	ADC_Init();
 
	DDRB = (1 << 5); //пин 5 порта B как выход
	PORTB = 0x00; //Начальное состояние порта 0

	DDRB |= (1 << 0) | (1 << 1); /* diode */
	PORTB |= (1 << 0);

	uart_init();

	set_sleep_mode(SLEEP_MODE_IDLE);
	sleep_enable();
	sei();

	uart_put("\n\nHello from avr\n\n");

	char* str = NULL;
	while(1) {
//   		while (!rxcflag)
//   			sleep_cpu();
//   		rxcflag = false;
// 		
		do {
			ADCSRA |= (1 << ADSC);    // Начинаем преобразование 
		}
		while ((ADCSRA & (1 << ADIF)) == 0); // пока не будет выставлено флага об окончании преобразования
 
		u = (ADCL|ADCH << 8); // Считываем  полученное значение
 
		//Проверяем считанное значение
		if (u > 1000){
		PORTB |= (1 << 5);
		}
		else {
		PORTB &= ~(1 << 5);
		}
        
		uart_put(to_string_uint16(u, str));
		uart_put("\n");
	}
}
