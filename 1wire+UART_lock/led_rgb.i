# 1 "led_rgb.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "led_rgb.c"




# 1 "led_rgb.h" 1



# 1 "/usr/avr/include/avr/io.h" 1 3
# 99 "/usr/avr/include/avr/io.h" 3
# 1 "/usr/avr/include/avr/sfr_defs.h" 1 3
# 126 "/usr/avr/include/avr/sfr_defs.h" 3
# 1 "/usr/avr/include/inttypes.h" 1 3
# 37 "/usr/avr/include/inttypes.h" 3
# 1 "/usr/lib/gcc/avr/8.2.0/include/stdint.h" 1 3 4
# 9 "/usr/lib/gcc/avr/8.2.0/include/stdint.h" 3 4
# 1 "/usr/avr/include/stdint.h" 1 3 4
# 125 "/usr/avr/include/stdint.h" 3 4

# 125 "/usr/avr/include/stdint.h" 3 4
typedef signed int int8_t __attribute__((__mode__(__QI__)));
typedef unsigned int uint8_t __attribute__((__mode__(__QI__)));
typedef signed int int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int uint16_t __attribute__ ((__mode__ (__HI__)));
typedef signed int int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int uint32_t __attribute__ ((__mode__ (__SI__)));

typedef signed int int64_t __attribute__((__mode__(__DI__)));
typedef unsigned int uint64_t __attribute__((__mode__(__DI__)));
# 146 "/usr/avr/include/stdint.h" 3 4
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
# 163 "/usr/avr/include/stdint.h" 3 4
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;







typedef int64_t int_least64_t;






typedef uint64_t uint_least64_t;
# 217 "/usr/avr/include/stdint.h" 3 4
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;







typedef int64_t int_fast64_t;






typedef uint64_t uint_fast64_t;
# 277 "/usr/avr/include/stdint.h" 3 4
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
# 10 "/usr/lib/gcc/avr/8.2.0/include/stdint.h" 2 3 4
# 38 "/usr/avr/include/inttypes.h" 2 3
# 77 "/usr/avr/include/inttypes.h" 3
typedef int32_t int_farptr_t;



typedef uint32_t uint_farptr_t;
# 127 "/usr/avr/include/avr/sfr_defs.h" 2 3
# 100 "/usr/avr/include/avr/io.h" 2 3
# 252 "/usr/avr/include/avr/io.h" 3
# 1 "/usr/avr/include/avr/iom328p.h" 1 3
# 253 "/usr/avr/include/avr/io.h" 2 3
# 585 "/usr/avr/include/avr/io.h" 3
# 1 "/usr/avr/include/avr/portpins.h" 1 3
# 586 "/usr/avr/include/avr/io.h" 2 3

# 1 "/usr/avr/include/avr/common.h" 1 3
# 588 "/usr/avr/include/avr/io.h" 2 3

# 1 "/usr/avr/include/avr/version.h" 1 3
# 590 "/usr/avr/include/avr/io.h" 2 3






# 1 "/usr/avr/include/avr/fuse.h" 1 3
# 239 "/usr/avr/include/avr/fuse.h" 3
typedef struct
{
    unsigned char low;
    unsigned char high;
    unsigned char extended;
} __fuse_t;
# 597 "/usr/avr/include/avr/io.h" 2 3


# 1 "/usr/avr/include/avr/lock.h" 1 3
# 600 "/usr/avr/include/avr/io.h" 2 3
# 5 "led_rgb.h" 2


# 6 "led_rgb.h"
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
# 6 "led_rgb.c" 2
# 1 "onewire.h" 1




# 1 "/usr/lib/gcc/avr/8.2.0/include/stdbool.h" 1 3 4
# 6 "onewire.h" 2
# 1 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 1 3 4
# 149 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 3 4

# 149 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 3 4
typedef int ptrdiff_t;
# 216 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 3 4
typedef unsigned int size_t;
# 328 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 3 4
typedef int wchar_t;
# 426 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 3 4
typedef struct {
  long long __max_align_ll __attribute__((__aligned__(__alignof__(long long))));
  long double __max_align_ld __attribute__((__aligned__(__alignof__(long double))));
# 437 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 3 4
} max_align_t;
# 7 "onewire.h" 2


# 8 "onewire.h"
typedef struct ow_Pin_s_ {
 void (*line_low)(void);
 void (*line_release)(void);
 
# 11 "onewire.h" 3 4
_Bool 
# 11 "onewire.h"
     (*line_read)(void);
 void (*delay_us)(uint16_t);
 uint8_t release_max_steps;
 uint8_t release_step_us;
 uint8_t ts_len_us;
 uint8_t ts_holdlow_us;
} ow_Pin;

typedef enum {
 OW_EOK = 0,
 OW_EINIT,
 OW_ELINEBREAK,
 OW_ENORESP,
 OW_ENOISESIG,
 OW_ECRC
} ow_err;






void ow_crc8_fast(uint8_t *crc_ptr, uint8_t byte);


uint8_t ow_crc8_fast_arr(uint8_t *array, uint16_t len);
# 59 "onewire.h"
ow_err __ow_Pin_init(ow_Pin *pin, void (*line_low)(void), void (*line_release)(void), 
# 59 "onewire.h" 3 4
                                                                                     _Bool 
# 59 "onewire.h"
                                                                                          (*line_read)(void),
       void (*delay_us)(uint16_t), uint8_t release_step_us, uint16_t release_max_us,
       uint8_t ts_len_us, uint8_t ts_holdlow_us);
# 91 "onewire.h"
uint16_t ow_wait_release(ow_Pin *pin);



ow_err ow_tx_reset(ow_Pin *pin);



ow_err ow_tx_bit(ow_Pin *pin, 
# 99 "onewire.h" 3 4
                             _Bool 
# 99 "onewire.h"
                                  bit);
# 111 "onewire.h"
ow_err __ow_rx_bit(ow_Pin *pin, 
# 111 "onewire.h" 3 4
                               _Bool 
# 111 "onewire.h"
                                    *bit, 
# 111 "onewire.h" 3 4
                                          _Bool 
# 111 "onewire.h"
                                               fastfail);
# 127 "onewire.h"
ow_err __ow_tx_byte(ow_Pin *pin, uint8_t byte, 
# 127 "onewire.h" 3 4
                                              _Bool 
# 127 "onewire.h"
                                                   fastfail);
# 143 "onewire.h"
ow_err __ow_rx_byte(ow_Pin *pin, uint8_t *byte, 
# 143 "onewire.h" 3 4
                                               _Bool 
# 143 "onewire.h"
                                                    fastfail);
# 172 "onewire.h"
ow_err __ow_cmd_readrom(ow_Pin *pin, uint8_t *rombytes, uint8_t *devcrc, 
# 172 "onewire.h" 3 4
                                                                        _Bool 
# 172 "onewire.h"
                                                                             resetfirst, 
# 172 "onewire.h" 3 4
                                                                                         _Bool 
# 172 "onewire.h"
                                                                                              fastfail);
# 7 "led_rgb.c" 2


# 1 "/usr/avr/include/avr/interrupt.h" 1 3
# 10 "led_rgb.c" 2

void led_RGB_init(led_RGB *led, volatile uint8_t *PORT, volatile uint8_t *DDR,
    uint8_t pin_red, uint8_t pin_green, uint8_t pin_blue,
    void (*delay_func)(uint8_t) )
{
 led->red = 0;
 led->green = 0;
 led->blue = 0;

 led->pin_red = pin_red;
 led->pin_green = pin_green;
 led->pin_blue = pin_blue;

 led->PORT = PORT;
 led->DDR = DDR;

 *(led->DDR ) |= (1 << pin_red) | (1 << pin_green) | (1 << pin_blue);
 *(led->PORT) &= ~(1 << pin_red) | ~(1 << pin_green) | ~(1 << pin_blue);

 led->delay_func = delay_func;
}

void led_RGB_red(led_RGB *led)
{
 led->red = 0xFF;
 led->green = 0x00;
 led->blue = 0x00;

 *(led->PORT) |= (1 << led->pin_red);
 *(led->PORT) &= ~(1 << led->pin_green) & ~(1 << led->pin_blue);
}

void led_RGB_green(led_RGB *led)
{
 led->red = 0x00;
 led->green = 0xFF;
 led->blue = 0x00;

 *(led->PORT) |= (1 << led->pin_green);
 *(led->PORT) &= ~(1 << led->pin_red) & ~(1 << led->pin_blue);
}

void led_RGB_blue(led_RGB *led)
{
 led->red = 0x00;
 led->green = 0x00;
 led->blue = 0xFF;

 *(led->PORT) |= (1 << led->pin_blue);
 *(led->PORT) &= ~(1 << led->pin_red) & ~(1 << led->pin_green);
}
