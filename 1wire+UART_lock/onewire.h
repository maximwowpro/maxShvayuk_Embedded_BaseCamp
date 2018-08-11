/*
 * lib for working with 1-Wire protocol
 */

#ifndef ONEWIRE_H
#define ONEWIRE_H

#include <stdint.h> 
#include <stdbool.h>
#include <stddef.h> 

typedef struct ow_Pin_s_ {
	void (*line_low)(void);
	void (*line_release)(void);
	bool (*line_read)(void);
	void (*delay_us)(uint16_t);
	uint8_t release_max_steps;
	uint8_t release_step_us;
	uint8_t ts_len_us;
	uint8_t ts_holdlow_us;	
} ow_Pin;

typedef enum {
	OW_EOK = 0,
	OW_EINIT,	/* Error during initialization */
	OW_ELINEBREAK,	/* Caught line break (constant logic 0) */
	OW_ENORESP,	/* Slave does not respond */
	OW_ENOISESIG,	/* Caught noise on line during read */
	OW_ECRC		/* Calculated CRC does not match device CRC */
} ow_err;

/* This procedure calculates the cumulative Maxim 1-Wire CRC of all bytes passed to it.
 * The result accumulates in the variable *crc_ptr.
 * Port of: https://www.maximintegrated.com/en/app-notes/index.mvp/id/27
 * Before calculation, initialize *crc_ptr to 0x00
 */
void ow_crc8_fast(uint8_t *crc_ptr, uint8_t byte);

/* Calculate CRC for passed in array of bytes using ow_crc8_fast */
uint8_t ow_crc8_fast_arr(uint8_t *array, uint16_t len);


/* ow_Pin_init() - Perform ow_Pin object initialization 
 * @pin:		ow_Pin object
 * @line_low:		Pointer to function, which sets line to logical 0
 * @line_release:	Pointer to function, which releases line (sets pin to input)
 * @line_read:		Pointer to function, returning current signal on line (0 or 1)
 * @delay_us:		Pointer to function, providing microsecond delays
 * 
 * Optional arguments:
 * @release_step_us:	Defines a single step of wait for line recovery into a logical 1
 * 			Defaults to 10.
 * @release_max_us:	Defines maximum microsecond wait for line recovery
 *			Defaults to 60.
 * @ts_len_us:		Length of time-slot (MUST BE in range [60...120])
 *			Defaults to 60.
 * @ts_holdlow_us:	Time to hold line 0 in logical 0 transmission time-slot
 *			Defaults to 3.
 *
 * (release_max_us % release_step_us) MUST BE == 0
 * release_max_us MUST BE in range [15...60]
 */
ow_err __ow_Pin_init(ow_Pin *pin, void (*line_low)(void), void (*line_release)(void), bool (*line_read)(void),
		     void (*delay_us)(uint16_t), uint8_t release_step_us, uint16_t release_max_us, 
		     uint8_t ts_len_us, uint8_t ts_holdlow_us);

/* Some macro-polymorphism to allow for optional values */
#define ow_Pin_init_9(pin, llow, lrel, lrd, del, rs, rm, tl, hl)	\
	({ ow_err __ret = __ow_Pin_init(pin, llow, lrel, lrd, del, rs, rm, tl, hl); __ret; })
#define ow_Pin_init_8(pin, llow, lrel, lrd, del, rs, rm, tl)		\
	({ ow_err __ret = __ow_Pin_init(pin, llow, lrel, lrd, del, rs, rm, tl, 3); __ret; })
#define ow_Pin_init_7(pin, llow, lrel, lrd, del, rs, rm)		\
	({ ow_err __ret = __ow_Pin_init(pin, llow, lrel, lrd, del, rs, rm, 60, 3); __ret; })
#define ow_Pin_init_6(pin, llow, lrel, lrd, del, rs)			\
	({ ow_err __ret = __ow_Pin_init(pin, llow, lrel, lrd, del, rs, 60, 60, 3); __ret; })
#define ow_Pin_init_5(pin, llow, lrel, lrd, del)			\
	({ ow_err __ret = __ow_Pin_init(pin, llow, lrel, lrd, del, 10, 60, 60, 3); __ret; })

#define ow_Pin_init_N(x, a1, a2, a3, a4, a5, a6, a7, a8, a9, FUNC, ...)	FUNC
#define ow_Pin_init(...)	ow_Pin_init_N(, ##__VA_ARGS__, ow_Pin_init_9(__VA_ARGS__), ow_Pin_init_8(__VA_ARGS__), \
					      ow_Pin_init_7(__VA_ARGS__), ow_Pin_init_6(__VA_ARGS__), ow_Pin_init_5(__VA_ARGS__))
/* For example
 * 	err = ow_Pin_init(&pin, &line_low, &line_release, &line_read, &soft_delay_us, 5, 20);
 * gets expanded to:
 *	err = ({ ow_err __ret = __ow_Pin_init(&pin, &line_low, &line_release, &line_read, &soft_delay_us, 5, 20, 60, 3); __ret; });
 * which is the same as:
 * 	err = __ow_Pin_init(&pin, &line_low, &line_release, &line_read, &soft_delay_us, 5, 20, 60, 3);
 */


/* Waits for line to recover (when logical 1 appears)
 * Returns time left to the end of wait in case of success
 * Or 0 in case of error
 */
uint16_t ow_wait_release(ow_Pin *pin);


/* Transmit RESET pulse to slave(s) */
ow_err ow_tx_reset(ow_Pin *pin);


/* Transmit one bit */
ow_err ow_tx_bit(ow_Pin *pin, bool bit);


/* ow_rx_bit() - Receive one bit
 * @pin:		ow_Pin object
 * @bit:		Pointer to bool variable which will store the resulting bit
 * Optional arguments:
 * @fastfail:		Whether we wait till time-slot finish if error occurs (false)
 *			Defaults to false.
 *
 * If error ocurs and fastfail set to 1 -- don't wait to the end of time-slot, return ASAP.
 */
ow_err __ow_rx_bit(ow_Pin *pin, bool *bit, bool fastfail);
#define ow_rx_bit_3(pin, bit, flag)		({ ow_err __ret = __ow_rx_bit(pin, bit, flag); __ret; })
#define ow_rx_bit_2(pin, bit)			({ ow_err __ret = __ow_rx_bit(pin, bit, 0); __ret; })
#define ow_rx_bit_N(x, a1, a2, a3, FUNC, ...)	FUNC
#define ow_rx_bit(...)				ow_rx_bit_N(, ##__VA_ARGS__, ow_rx_bit_3(__VA_ARGS__), ow_rx_bit_2(__VA_ARGS__))


/* ow_tx_byte() - Transmit byte
 * @pin:		ow_Pin object
 * @byte:		Byte value to transmit
 * Optional arguments:
 * @fastfail:		Whether we stop transmission if error occurs
 *			Defaults to false.
 *
 * If error ocurs and fastfail set to 1 -- don't wait to the end of time-slot, return ASAP.
 */
ow_err __ow_tx_byte(ow_Pin *pin, uint8_t byte, bool fastfail);
#define ow_tx_byte_3(pin, byte, flag)		({ ow_err __ret = __ow_tx_byte(pin, byte, flag); __ret; })
#define ow_tx_byte_2(pin, byte)			({ ow_err __ret = __ow_tx_byte(pin, byte, 0); __ret; })
#define ow_tx_byte_N(x, a1, a2, a3, FUNC, ...)	FUNC
#define ow_tx_byte(...)				ow_tx_byte_N(, ##__VA_ARGS__, ow_tx_byte_3(__VA_ARGS__), ow_tx_byte_2(__VA_ARGS__))


/* ow_rx_byte() - Receive byte
 * @pin:		ow_Pin object
 * @byte:		Pointer to byte variable where result is put
 * Optional arguments:
 * @fastfail:		Whether we stop reception if error occurs
 *			Defaults to false.
 *
 * If error ocurs and fastfail set to 1 -- don't wait to the end of time-slot, return ASAP.
 */
ow_err __ow_rx_byte(ow_Pin *pin, uint8_t *byte, bool fastfail);
#define ow_rx_byte_3(pin, byte, flag)		({ ow_err __ret = __ow_rx_byte(pin, byte, flag); __ret; })
#define ow_rx_byte_2(pin, byte)			({ ow_err __ret = __ow_rx_byte(pin, byte, 0); __ret; })
#define ow_rx_byte_N(x, a1, a2, a3, FUNC, ...)	FUNC
#define ow_rx_byte(...)				ow_rx_byte_N(, ##__VA_ARGS__, ow_rx_byte_3(__VA_ARGS__), ow_rx_byte_2(__VA_ARGS__))


/* ow_cmd_readrom() - Read 7-byte device number (READ ROM command)
 * @pin:		ow_Pin object
 * @rombytes:		Array where resulting 7 bytes of device number are put
 * Optional arguments:
 * @devcrc:		Pointer to variable where *device* CRC value is stored
 * 			Or NULL if it's not required to store CRC.
 * 			CRC is calculated and compared internally anyway.
 * @resetfirst:		Whether RESET should be performed before read
 * 			Defaults to true.
 * @fastfail:		Whether we stop reception if error occurs
 *			Defaults to false.
 *
 * Function emits READ ROM command and reads 7-byte device number.
 *     First byte reflects family, next 6 bytes - unique id.
 * Usually RESET should be performed first before emitting the READ ROM.
 *     To allow for generic use cases, the @resetfirst flag exists.
 * If error ocurs and fastfail set to 1 -- don't wait to the end, return ASAP.
 * CRC is calculated for 7 received bytes and matched against 8th CRC byte of device.
 * The @devcrc variable stores CRC *returned by device*
 *
 * In case error occurs (e.g. crc mismatch) it results in corresponding return value
 */
ow_err __ow_cmd_readrom(ow_Pin *pin, uint8_t *rombytes, uint8_t *devcrc, bool resetfirst, bool fastfail);
#define ow_cmd_readrom_5(pin, bt, crc, rf, ff)	({ ow_err __ret = __ow_cmd_readrom(pin, bt, crc, rf, ff); __ret; })
#define ow_cmd_readrom_4(pin, bt, crc, rf)	({ ow_err __ret = __ow_cmd_readrom(pin, bt, crc, rf, 0); __ret; })
#define ow_cmd_readrom_3(pin, bt, crc)		({ ow_err __ret = __ow_cmd_readrom(pin, bt, crc, 1, 0); __ret; })
#define ow_cmd_readrom_2(pin, bt)		({ ow_err __ret = __ow_cmd_readrom(pin, bt, NULL, 1, 0); __ret; })
#define ow_cmd_readrom_N(x, a1, a2, a3, a4, a5, FUNC, ...)	FUNC
#define ow_cmd_readrom(...)			ow_cmd_readrom_N(, ##__VA_ARGS__, ow_cmd_readrom_5(__VA_ARGS__), \
								 ow_cmd_readrom_4(__VA_ARGS__), ow_cmd_readrom_3(__VA_ARGS__), \
								 ow_cmd_readrom_2(__VA_ARGS__))

#endif
