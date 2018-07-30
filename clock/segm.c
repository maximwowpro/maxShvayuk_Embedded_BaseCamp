#include "segm.h"
#include <stdint.h>
#include <stdbool.h>

static const uint8_t stddelay = 1;
static const uint16_t sym_delay = 1;	/* 500 / Hz */

const uint8_t segm_sym_table[] = {
	/* Common cathode here */
	[0] = ~0x3F,
	[1] = ~0x06,
	[2] = ~0x5B,
	[3] = ~0x4F,
	[4] = ~0x66,
	[5] = ~0x6D,
	[6] = ~0x7D,
	[7] = ~0x07,
	[8] = ~0x7F,
	[9] = ~0x6F
};


void segm_bcd(uint16_t number, uint8_t *res)
{
	do {
		*res++ = number % 10;
		number /= 10;
	} while (number);
}


void segm_init(struct segm_Display *display)//
{
	struct segm_Pin *ptrarr[] = {
		&display->SHCP,
		&display->STCP,
		&display->DS,
	};

	//настраиваем нужные пины как OUTPUT и подаем на их выход 0
	for (uint8_t i = 0; i < (uint8_t)(sizeof ptrarr / sizeof *ptrarr); i++) {
		*(ptrarr[i]->port->PORT) &= ~(1 << ptrarr[i]->pin);
		*(ptrarr[i]->port->DDR) |= 1 << ptrarr[i]->pin;
	} 
}


void segm_shiftbyte(struct segm_Display *display, uint8_t byte)
{
	bool bit;
	for (int i = 0; i < 8; i++) {
		bit = byte >> 7;
		byte = byte << 1;
		/* Set DS pin to bit	*/
		if (bit)//если бит == 1
			*(display->DS.port->PORT) |= 1 << display->DS.pin;
		//зажигаем соответствующий пин
		else
			*(display->DS.port->PORT) &= ~(1 << display->DS.pin);
		//тушим соответствующий пин
		
		/* Drive low-to-high posedge on SHCP pin, делаем сдвиг */
		*(display->SHCP.port->PORT) &= ~(1 << display->SHCP.pin);//установили пин в 0
		(*display->delay_func)(stddelay);  /* Call delay with 1 step */
		*(display->SHCP.port->PORT) |= 1 << display->SHCP.pin;
		(*display->delay_func)(stddelay);
	}
}


void segm_latch(struct segm_Display *display)
{
	/* Drive low-to-high posedge on STCP pin */
	*(display->STCP.port->PORT) &= ~(1 << display->STCP.pin);//сброс бита-защелки
	(*display->delay_func)(stddelay);  /* Call delay with 1 step */
	*(display->STCP.port->PORT) |= 1 << display->STCP.pin;//установка бита-защелки
	(*display->delay_func)(stddelay);

}


void segm_indicate4(struct segm_Display *display, uint8_t *arr4)
{
	uint8_t sym;
	uint8_t digit = 0x01;  /* [_ _ _ _ 4 3 2 1] -> 7SEGM:[4] [3] [2] [1] */
	for (int i = 3; i >= 0; i--) {
		sym = arr4[i];
		if (!display->is_comm_anode)
			sym = ~sym;
		segm_shiftbyte(display, sym);
		segm_shiftbyte(display, digit);
		digit = digit << 1;
		segm_latch(display);
		(*display->sleep_ms_func)(sym_delay);
	}
}



