#include "i2c.h"
#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>
#include "img_128rows.c"

volatile bool busyflag = false;

const static uint32_t frequency = 500000;
const static uint16_t delay = 1000;

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

void empty_callback(void)
{
	busyflag = false;
}

/* 0х80 указывает что дальше пойдет команда */
uint8_t cmd_displayon[] = {0x80, 0xAF}; /* вкл */
uint8_t cmd_setbrightness[] = {0x80, 0x81, 0x80, 0xFF}; /* set max level of brihgtness */
uint8_t cmd_forceon[] = {0x80, 0xA5};
uint8_t cmd_chargepump[] = {0x80, 0x8D, 0x80, 0x14}; /* емкостный умножитель напряжения */
uint8_t cmd_pagemode[] = {0x80, 0x20, 0x80, 0x02}; /* set page adressing mode as Page Addressing Mode */
uint8_t cmd_seqcom[] = {0x80, 0xDA, 0x80, 0x02}; /* Set COM Pins Hardware Configuration */ /* ????? */
uint8_t cmd_selpage[] = {0x80, 0xB0}; /* Set Page Start Address for Page Addressing Mode 0-страница номер 0, дальше мы будем юзать 0xB1, 0xB2 ... 0xB7 */
uint8_t cmd_cursor0[] = {0x80, 0x00, 0x80, 0x10}; 
uint8_t cmd_cursor15[] = {0x80, 0x08, 0x80, 0x13}; /* 3-high nibble, 4-low nibble, total offset from page begin = 0011_0100 == */
uint8_t cmd_invert[] = {0x80, 0xA6}; /* инверсия изображения (черное стало белым */

uint8_t pagebuffer[129] = {0x40, 0};

int main()
{
	sei();
	I2C_init(frequency);		/* 1 kHz SCL frequency */

	busyflag = true; I2C_tx_schedule(0b0111100, cmd_chargepump, 4, &empty_callback, false); /* включили емкостный умножитель напряжения */
	while (busyflag); /* пока busyflag == true, тоесть пока не сработает callback, тоесть пока не завершена I2C транзакция */

	busyflag = true; I2C_tx_schedule(0b0111100, cmd_displayon, 2, &empty_callback, false); /* вкл дисплей */
	while (busyflag);

	busyflag = true; I2C_tx_schedule(0b0111100, cmd_setbrightness, 4, &empty_callback, false); /* set max level of brihgtness */
	while (busyflag);

	busyflag = true; I2C_tx_schedule(0b0111100, cmd_invert, 2, &empty_callback, false); /* включили инверсию изображения (чарное стало белым */
	while (busyflag);
	
	for (uint32_t pg = 0; pg < 8; pg++) {
		cmd_selpage[1] = 0xB0 | pg; /* инкрементируем страницу: 0хВ0, 0xB1, 0xB2 ... 0xB7 */
		busyflag = true; I2C_tx_schedule(0b0111100, cmd_selpage, 2, &empty_callback, false); /* обязательно это */
		while (busyflag);
		busyflag = true; I2C_tx_schedule(0b0111100, cmd_cursor0, 4, &empty_callback, false); /* а потом это */
		while (busyflag);

		for (uint8_t i = 1; i < 129; i++) {
			/* достаем картинку из flash-памяти (смещение от начала = 128*page_num + байты от нулевого до 127*/
			pagebuffer[i] = pgm_read_byte(&bitmap_open[128 * pg + i - 1]); 
		}
		
		busyflag = true; I2C_tx_schedule(0b0111100, pagebuffer, 129, &empty_callback, false);
		while (busyflag);
	}

	while (1) {
		
		soft_delay(delay);
		
		for (uint32_t pg = 2; pg < 4; pg++) {
			cmd_selpage[1] = 0xB0 | pg; /* инкрементируем страницу: 0хВ0, 0xB1, 0xB2 ... 0xB7 */
			busyflag = true; I2C_tx_schedule(0b0111100, cmd_selpage, 2, &empty_callback, false); /* обязательно это */
			while (busyflag);
			busyflag = true; I2C_tx_schedule(0b0111100, cmd_cursor15, 4, &empty_callback, false); /* а потом это */
			while (busyflag);

			for (uint8_t i = 1; i <= 15; i++) {
				/* достаем картинку из flash-памяти (смещение от начала = 128*page_num + байты от нулевого до 127*/
				pagebuffer[i] = pgm_read_byte(&eye3[15 * (pg - 2) + i - 1]); 
			}
			
			busyflag = true; I2C_tx_schedule(0b0111100, pagebuffer, 16, &empty_callback, false);
			while (busyflag);
		}
		
		soft_delay(delay);
		
		for (uint32_t pg = 2; pg < 4; pg++) {
			cmd_selpage[1] = 0xB0 | pg; /* инкрементируем страницу: 0хВ0, 0xB1, 0xB2 ... 0xB7 */
			busyflag = true; I2C_tx_schedule(0b0111100, cmd_selpage, 2, &empty_callback, false); /* обязательно это */
			while (busyflag);
			busyflag = true; I2C_tx_schedule(0b0111100, cmd_cursor15, 4, &empty_callback, false); /* а потом это */
			while (busyflag);

			for (uint8_t i = 1; i <= 15; i++) {
				/* достаем картинку из flash-памяти (смещение от начала = 128*page_num + байты от нулевого до 127*/
				pagebuffer[i] = pgm_read_byte(&eye2[15 * (pg - 2) + i - 1]); 
			}
			
			busyflag = true; I2C_tx_schedule(0b0111100, pagebuffer, 16, &empty_callback, false);
			while (busyflag);
		}
		
		soft_delay(delay);
		
		for (uint32_t pg = 2; pg < 4; pg++) {
			cmd_selpage[1] = 0xB0 | pg; /* инкрементируем страницу: 0хВ0, 0xB1, 0xB2 ... 0xB7 */
			busyflag = true; I2C_tx_schedule(0b0111100, cmd_selpage, 2, &empty_callback, false); /* обязательно это */
			while (busyflag);
			busyflag = true; I2C_tx_schedule(0b0111100, cmd_cursor15, 4, &empty_callback, false); /* а потом это */
			while (busyflag);

			for (uint8_t i = 1; i <= 15; i++) {
				/* достаем картинку из flash-памяти (смещение от начала = 128*page_num + байты от нулевого до 127*/
				pagebuffer[i] = pgm_read_byte(&eye1_5[15 * (pg - 2) + i - 1]); 
			}
			
			busyflag = true; I2C_tx_schedule(0b0111100, pagebuffer, 16, &empty_callback, false);
			while (busyflag);
		}
		
		soft_delay(delay);
		
		for (uint32_t pg = 2; pg < 4; pg++) {
			cmd_selpage[1] = 0xB0 | pg; /* инкрементируем страницу: 0хВ0, 0xB1, 0xB2 ... 0xB7 */
			busyflag = true; I2C_tx_schedule(0b0111100, cmd_selpage, 2, &empty_callback, false); /* обязательно это */
			while (busyflag);
			busyflag = true; I2C_tx_schedule(0b0111100, cmd_cursor15, 4, &empty_callback, false); /* а потом это */
			while (busyflag);

			for (uint8_t i = 1; i <= 15; i++) {
				/* достаем картинку из flash-памяти (смещение от начала = 128*page_num + байты от нулевого до 127*/
				pagebuffer[i] = pgm_read_byte(&eye1[15 * (pg - 2) + i - 1]); 
			}
			
			busyflag = true; I2C_tx_schedule(0b0111100, pagebuffer, 16, &empty_callback, false);
			while (busyflag);
		}
		
		soft_delay(delay);
		
		for (uint32_t pg = 2; pg < 4; pg++) {
			cmd_selpage[1] = 0xB0 | pg; /* инкрементируем страницу: 0хВ0, 0xB1, 0xB2 ... 0xB7 */
			busyflag = true; I2C_tx_schedule(0b0111100, cmd_selpage, 2, &empty_callback, false); /* обязательно это */
			while (busyflag);
			busyflag = true; I2C_tx_schedule(0b0111100, cmd_cursor15, 4, &empty_callback, false); /* а потом это */
			while (busyflag);

			for (uint8_t i = 1; i <= 15; i++) {
				/* достаем картинку из flash-памяти (смещение от начала = 128*page_num + байты от нулевого до 127*/
				pagebuffer[i] = pgm_read_byte(&eye1_5[15 * (pg - 2) + i - 1]); 
			}
			
			busyflag = true; I2C_tx_schedule(0b0111100, pagebuffer, 16, &empty_callback, false);
			while (busyflag);
		}
		
		soft_delay(delay);
		
		for (uint32_t pg = 2; pg < 4; pg++) {
			cmd_selpage[1] = 0xB0 | pg; /* инкрементируем страницу: 0хВ0, 0xB1, 0xB2 ... 0xB7 */
			busyflag = true; I2C_tx_schedule(0b0111100, cmd_selpage, 2, &empty_callback, false); /* обязательно это */
			while (busyflag);
			busyflag = true; I2C_tx_schedule(0b0111100, cmd_cursor15, 4, &empty_callback, false); /* а потом это */
			while (busyflag);

			for (uint8_t i = 1; i <= 15; i++) {
				/* достаем картинку из flash-памяти (смещение от начала = 128*page_num + байты от нулевого до 127*/
				pagebuffer[i] = pgm_read_byte(&eye2[15 * (pg - 2) + i - 1]); 
			}
			
			busyflag = true; I2C_tx_schedule(0b0111100, pagebuffer, 16, &empty_callback, false);
			while (busyflag);
		}
		
		soft_delay(delay);
		
		for (uint32_t pg = 2; pg < 4; pg++) {
			cmd_selpage[1] = 0xB0 | pg; /* инкрементируем страницу: 0хВ0, 0xB1, 0xB2 ... 0xB7 */
			busyflag = true; I2C_tx_schedule(0b0111100, cmd_selpage, 2, &empty_callback, false); /* обязательно это */
			while (busyflag);
			busyflag = true; I2C_tx_schedule(0b0111100, cmd_cursor15, 4, &empty_callback, false); /* а потом это */
			while (busyflag);

			for (uint8_t i = 1; i <= 15; i++) {
				/* достаем картинку из flash-памяти (смещение от начала = 128*page_num + байты от нулевого до 127*/
				pagebuffer[i] = pgm_read_byte(&eye3[15 * (pg - 2) + i - 1]); 
			}
			
			busyflag = true; I2C_tx_schedule(0b0111100, pagebuffer, 16, &empty_callback, false);
			while (busyflag);
		}
	}
}
