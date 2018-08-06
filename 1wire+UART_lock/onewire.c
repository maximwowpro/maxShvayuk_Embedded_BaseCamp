/* We use native stuff on AVR and dummy replacements on PC to provide some
 * compatibility for the means of testing
 */
#ifdef __AVR__
#include <avr/pgmspace.h>
#else
#define PROGMEM
#define pgm_read_byte(addr) ({uint8_t byte__ = *(addr); byte__; }) 
#endif

#include "onewire.h"
#include <stdbool.h>
#include <stdint.h>
#include <stddef.h>


/* On AVR we store this in Flash memory instead of RAM. We have about 32 KB of flash
 * and only 2K of RAM. So this stuff saves us much.
 * It will still be some overhead when accessing data from Flash (we have Harvard
 * architecture in the end, not Von Neuman). But this overhead will be still small
 * compared to calculating CRC bit-by-bit
 *
 * See https://www.nongnu.org/avr-libc/user-manual/pgmspace.html
 * and https://www.nongnu.org/avr-libc/user-manual/pgmspace_8h.html
 */
static const uint8_t ow_maxim_crc_table[] PROGMEM = {
	0, 94, 188, 226, 97, 63, 221, 131, 194, 156, 126, 32, 163, 253, 31, 65,
	157, 195, 33, 127, 252, 162, 64, 30, 95, 1, 227, 189, 62, 96, 130, 220,
	35, 125, 159, 193, 66, 28, 254, 160, 225, 191, 93, 3, 128, 222, 60, 98,
	190, 224, 2, 92, 223, 129, 99, 61, 124, 34, 192, 158, 29, 67, 161, 255,
	70, 24, 250, 164, 39, 121, 155, 197, 132, 218, 56, 102, 229, 187, 89, 7,
	219, 133, 103, 57, 186, 228, 6, 88, 25, 71, 165, 251, 120, 38, 196, 154,
	101, 59, 217, 135, 4, 90, 184, 230, 167, 249, 27, 69, 198, 152, 122, 36,
	248, 166, 68, 26, 153, 199, 37, 123, 58, 100, 134, 216, 91, 5, 231, 185,
	140, 210, 48, 110, 237, 179, 81, 15, 78, 16, 242, 172, 47, 113, 147, 205,
	17, 79, 173, 243, 112, 46, 204, 146, 211, 141, 111, 49, 178, 236, 14, 80,
	175, 241, 19, 77, 206, 144, 114, 44, 109, 51, 209, 143, 12, 82, 176, 238,
	50, 108, 142, 208, 83, 13, 239, 177, 240, 174, 76, 18, 145, 207, 45, 115,
	202, 148, 118, 40, 171, 245, 23, 73, 8, 86, 180, 234, 105, 55, 213, 139,
	87, 9, 235, 181, 54, 104, 138, 212, 149, 203, 41, 119, 244, 170, 72, 22,
	233, 183, 85, 11, 136, 214, 52, 106, 43, 117, 151, 201, 74, 20, 246, 168,
	116, 42, 200, 150, 21, 75, 169, 247, 182, 232, 10, 84, 215, 137, 107, 53
};


void ow_crc8_fast(uint8_t *crc_ptr, uint8_t byte)
{
	byte ^= *crc_ptr;
	*crc_ptr = pgm_read_byte(&(ow_maxim_crc_table[byte]));
}


uint8_t ow_crc8_fast_arr(uint8_t *array, uint16_t len)
{
	uint8_t crc = 0;
	for (typeof(len) i = 0; i < len; i++)
		ow_crc8_fast(&crc, array[i]);
	return crc;
}


ow_err __ow_Pin_init(ow_Pin *pin, void (*line_low)(void), void (*line_release)(void), bool (*line_read)(void),
		     void (*delay_us)(uint16_t), uint8_t release_step_us, uint16_t release_max_us, 
		     uint8_t ts_len_us, uint8_t ts_holdlow_us)
{
	if ((release_max_us % release_step_us != 0) || (release_max_us < 15) || (release_max_us > 60))
		return OW_EINIT;
	if ((line_low == NULL) || (line_release == NULL) || (line_read == NULL) || (delay_us == NULL))
		return OW_EINIT;
	if ((ts_len_us < 60) || (ts_len_us > 120))
		return OW_EINIT;
	if ((ts_holdlow_us < 1) || (ts_holdlow_us > 15))
		return OW_EINIT;

	pin->line_low = line_low;
	pin->line_release = line_release;
	pin->line_read = line_read;
	pin->delay_us = delay_us;
	pin->release_max_steps = release_max_us / release_step_us;
	pin->release_step_us = release_step_us;
	pin->ts_len_us = ts_len_us;
	pin->ts_holdlow_us = ts_holdlow_us;

	return OW_EOK;
}


uint16_t ow_wait_release(ow_Pin *pin)
{
	/* Wait for line to recover (when logical 1 appears) */
	/* Returns time left to the end of wait in case of success */
	/* Or 0 in case of error */
	uint16_t wait;
	for (wait = pin->release_max_steps; wait > 0 ; wait--) {
		if ((*pin->line_read)())
			break;
		(*pin->delay_us)(pin->release_step_us);
	}
	return wait * pin->release_step_us;
}


ow_err ow_tx_reset(ow_Pin *pin)
{
	/* Transmit RESET pulse */
	(*pin->line_low)();
	(*pin->delay_us)(480);
	(*pin->line_release)();

	/* Wait for line to recover (when logical 1 appears) */
	uint16_t wait = ow_wait_release(pin);
	if (!wait)	/* If haven't reached line recovery in time */
		return OW_ELINEBREAK;

	/* Wait for PRESENCE pulse */
	(*pin->delay_us)(60);
	if ((*pin->line_read)())	/* if still logic 1 */
		return OW_ENORESP;  /* no response from slave */

	/* Give slave time to finish its initialization */
	/* We need 480 us after RESET pulse by standard */
	uint16_t us_left = 480 - 60 - wait;
	(*pin->delay_us)(us_left);

	/* One more check that line returned to 1 */
	if (!(*pin->line_read)())	/* if still logic 0 */
		return OW_ELINEBREAK;
	
	return OW_EOK;
}


ow_err ow_tx_bit(ow_Pin *pin, bool bit)
{
	/* Transmit 0 -- pull line to 0 for all time-slot */
	/* Transmit 1 -- pull line to 0, wait 1..15 us, release line */
	(*pin->line_low)();
	uint16_t wait;

	if (!bit) {
		(*pin->delay_us)(pin->ts_len_us);
		(*pin->line_release)();
		if (!ow_wait_release(pin))	/* Wait for line to release */
			return OW_ELINEBREAK;
	} else {
		(*pin->delay_us)(pin->ts_holdlow_us);
		(*pin->line_release)();
		wait = ow_wait_release(pin);	/* Wait for line to release */
		if (!wait)			/* If line has not recovered */
			return OW_ELINEBREAK;
		/* If OK -- wait to the end of time-slot */
		(*pin->delay_us)(pin->ts_len_us - pin->ts_holdlow_us - wait);
	}
	return OW_EOK;
}


ow_err __ow_rx_bit(ow_Pin *pin, bool *bit, bool fastfail)
{
	/* Receive -- pull line to 0, wait 1..15 us, then read line */
	/* Slave either holds line low (0), or allows it to recover (1) */
	/* We rely on arbitrage to reliably input a bit */
	(*pin->line_low)();
	(*pin->delay_us)(pin->ts_holdlow_us);
	(*pin->line_release)();
	(*pin->delay_us)(15 - pin->ts_holdlow_us);

	/* Arbitrage: read value 8 times, then count most */
	uint8_t arb = 0, cnt = 0;
	for (uint8_t i = 0; i < 8; i++) {
		arb |= (*pin->line_read)() << i;
	}
	for (uint8_t i = 0; i < 8; i++) {
		if (arb & (1 << i))
			cnt++;
	}
	/* If we have 7/9 zeros or 7/9 ones -- its the result.		*/
	/* Otherwise, it's an error. But we set the result value anyway */
	/* cnt = |  0   1   2   3   4   5   6   7   8  |		*/
	/* res = |  0   0   x0  x0  x0  x1  x1  1   1  |,  x = usure	*/
	*bit = (cnt >= 5);
	bool err = (cnt >= 2) && (cnt <= 7);

	/* Wait to the end of timeslot if all ok or not failing fast */
	if (!err || !fastfail) {
		(*pin->delay_us)(pin->ts_len_us - 15);
		/* Wait for line to recover after time-slot */
		//if (!ow_wait_release(pin))
		//	return OW_ELINEBREAK;
	}

	if (err)
		return OW_ENOISESIG;

	return OW_EOK;
}


ow_err __ow_tx_byte(ow_Pin *pin, uint8_t byte, bool fastfail)
{
	ow_err err = OW_EOK;
	for (uint8_t i = 0; i < 8; i++)	{
		bool bit = (byte & (1 << i)) >> i;
		err = ow_tx_bit(pin, bit);
		if ((err != OW_EOK) && fastfail)
			break;
	}
	return err;
}


ow_err __ow_rx_byte(ow_Pin *pin, uint8_t *byte, bool fastfail)
{
	ow_err err = OW_EOK;
	*byte = 0;
	for (uint8_t i = 0; i < 8; i++)	{
		bool bit;
		err = ow_rx_bit(pin, &bit, fastfail);
		*byte |= bit << i;
		if ((err != OW_EOK) && fastfail)
			break;
	}
	return err;
}


ow_err __ow_cmd_readrom(ow_Pin *pin, uint8_t *rombytes, uint8_t *devcrc, bool resetfirst, bool fastfail)
{
	/* Read 7-byte device number. First byte reflects family, next 6 bytes -- unique id */
	/* 8th byte is CRC */
	ow_err err = OW_EOK;

	if (resetfirst)
		err = ow_tx_reset(pin);
	/* No need to do other stuff if device fails to reset -- return ASAP */
	if (err != OW_EOK)
		return err;

	/* Emit READ ROM command (0x33) byte */
	err = ow_tx_byte(pin, 0x33, fastfail);
	if ((err != OW_EOK) && fastfail)
		return err;

	/* Read 7 bytes of number from the device */
	for (uint8_t i = 0; i < 7; i++) {
		err = ow_rx_byte(pin, &rombytes[i], fastfail);
		if ((err != OW_EOK) && fastfail)
			return err;
	}

	/* Read CRC from the device */
	uint8_t readcrc = 0;
	err = ow_rx_byte(pin, &readcrc, fastfail);
	if ((err != OW_EOK) && fastfail)
		return err;
	/* If devcrc arg is used, set it to CRC */
	if (NULL != devcrc)
		*devcrc = readcrc;

	/* Calculate CRC and compare it to one got from the device */
	uint8_t calccrc = ow_crc8_fast_arr(rombytes, 7);
	if (readcrc != calccrc)
		return OW_ECRC;	/* CRC mismatch */

	return OW_EOK;
}
