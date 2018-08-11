#include "i2c.h"
#include <avr/interrupt.h>
#include <avr/power.h>
#include <util/atomic.h>
#include <stdint.h>

volatile enum I2C_Error I2C_lasterror = I2C_EOK;
static uint8_t *dataptr;
static uint16_t datacount;
static uint8_t devaddr;
static bool is_fastfail;
static void (*callback)(void); /* called after transaction finish */

/* States used in ISR FSM */
enum I2C_State_e {
	STATE_IDLE = 0,
	STATE_STOP,
	STATE_SLAVEADDR,
	STATE_WRITEBYTE
};
static enum I2C_State_e I2C_state = STATE_IDLE;


void __I2C_init(uint32_t hz_freq)
{
	I2C_state = STATE_IDLE;
	/* Enable the Two Wire Interface module */
	power_twi_enable();

	/* Select TWBR and TWPS based on frequency. Quite tricky, the main point */
	/* is that prescaler is a pow(4, TWPS)				 	 */
	/* TWBR * TWPS_prescaler value */
	uint32_t twbr = F_CPU / (2 * hz_freq) - 8;
	uint8_t twps;
	for (twps = 0; twps < 4; twps++) {
		if (twbr <= 255)
			break;
		twbr /= 4;
	}

	TWBR = (uint8_t)twbr;
	TWSR = (TWSR & 0xFC) | (twps & 0x3);
	//TWBR = 1;
	//TWSR = (TWSR & 0xFC) | (0 & 0x3);

	TWCR = (1 << TWEN) | (1 << TWIE); /* allow TWI interrupt and power on TWI module */
}

/* Returns true on success, false if I2C is not ready for new transaction */
bool __I2C_tx_schedule(uint8_t addr, uint8_t *bytes, uint16_t len, void (*end_callback)(void), bool fastfail)
{
	bool ret = false;
	/* No interrupts can occur while this block is executed */
	ATOMIC_BLOCK(ATOMIC_RESTORESTATE) {
		if (I2C_state == STATE_IDLE) {
			dataptr = bytes;
			datacount = len;
			is_fastfail = fastfail;
			callback = end_callback;
			I2C_state = STATE_SLAVEADDR;
			/* Send START signal and initiating new transaction */
			devaddr = (addr << 1); /* сдвиг потому что 7бит - адрес + 8 бит - READ / WRITE ;
						write = 0, read = 1, мы установили 0 - значит режим write*/
			TWCR |= (1 << TWSTA) | (1 << TWINT); /* TWSTA - send start bit; TWINT - set interrupt bit */
			ret = true;
		}
	}
	return ret;
}


ISR(TWI_vect, ISR_BLOCK)
{
	switch(I2C_state) {
	case(STATE_IDLE):
	case(STATE_STOP):
		/* transfer stop and go to IDLE*/
		/* signal with callback that transaction is over */
		TWCR |= (1 << TWSTO) | (1 << TWINT); /* send STOP signal */
		I2C_state = STATE_IDLE;
		(*callback)(); /* показывает что мы закончили работу с ай2си (больше не заняты */
		break;
	case(STATE_SLAVEADDR):
		// load value
		TWDR = devaddr; /* write to TWDR adress + R/W bit (W = 0 in our case */
		TWCR = (TWCR & ~(1 << TWSTA)) | (1 << TWINT); /* we don't need send START signal now, so TWSTA = 0 */
		I2C_state = STATE_WRITEBYTE;
		break;
	case(STATE_WRITEBYTE):
		// load next byte
		TWDR = *dataptr++;
		datacount--;
		if (!datacount) /* when we sended all bytes */
			I2C_state = STATE_STOP;
		TWCR |= (1 << TWINT);
		break;
	}
}
