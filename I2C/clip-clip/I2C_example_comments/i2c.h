#include <avr/io.h>
#include <assert.h>
#include <stdbool.h>

#ifndef F_CPU
	#define F_CPU 16000000UL
	#warning "F_CPU not set. Using default 16 Mhz as fallback"
#endif

#if !(defined(TWBR) && defined(TWSR) && defined(TWAR) && defined(TWDR))
	#error "AVR target has no TWI peripheral"
#endif

/* TODO: check TWS7..TWS0 bytes in TWSR status register and set global err flag accordingly */
enum I2C_Error {
	I2C_EOK = 0,
	I2C_ESTART	/* START signal failed */
};

/* Global, which contains the latest error (like errno) */
extern volatile enum I2C_Error I2C_lasterror;


void __I2C_init(uint32_t hz_freq);
#define I2C_init(hz, ...)	({\
	_Static_assert(((hz) > F_CPU / 32656 + 1) && ((hz) <= F_CPU / 16),		\
		      "I2C hz freq must be in range [1+F_CPU/32656...F_CPU/16]");	\
	__I2C_init((hz), ##__VA_ARGS__); })



bool __I2C_tx_schedule(uint8_t addr, uint8_t *bytes, uint16_t len, void (*end_callback)(void), bool fastfail);
#define I2C_tx_schedule_5(addr, bytes, len, cbk, flag)		({ \
	_Static_assert( ((addr) & 0x80) == 0,						\
		      "I2C address must be 7-bit wide");				\
	bool __ret = __I2C_tx_schedule((addr), (bytes), (len), (cbk), (flag)); __ret; })
#define I2C_tx_schedule_4(addr, bytes, len, cbk)		({ \
	_Static_assert( ((addr) & 0x80) == 0,						\
		      "I2C address must be 7-bit wide");				\
	bool __ret = __I2C_tx_schedule((addr), (bytes), (len), (cbk), 0); __ret; })
#define I2C_tx_schedule_N(x, a1, a2, a3, a4, a5, FUNC, ...)	FUNC
#define I2C_tx_schedule(...)					I2C_tx_schedule_N(, ##__VA_ARGS__, I2C_tx_schedule_5(__VA_ARGS__), I2C_tx_schedule_4(__VA_ARGS__))



