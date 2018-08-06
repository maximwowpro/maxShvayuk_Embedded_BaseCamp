# 1 "main.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "main.c"
# 1 "onewire.h" 1



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
# 5 "onewire.h" 2
# 1 "/usr/lib/gcc/avr/8.2.0/include/stdbool.h" 1 3 4
# 6 "onewire.h" 2
# 1 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 1 3 4
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
# 2 "main.c" 2
# 1 "led_rgb.h" 1



# 1 "/usr/avr/include/avr/io.h" 1 3
# 99 "/usr/avr/include/avr/io.h" 3
# 1 "/usr/avr/include/avr/sfr_defs.h" 1 3
# 126 "/usr/avr/include/avr/sfr_defs.h" 3
# 1 "/usr/avr/include/inttypes.h" 1 3
# 77 "/usr/avr/include/inttypes.h" 3

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
# 3 "main.c" 2
# 1 "lock.h" 1







# 1 "/usr/avr/include/avr/eeprom.h" 1 3
# 50 "/usr/avr/include/avr/eeprom.h" 3
# 1 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 1 3 4
# 51 "/usr/avr/include/avr/eeprom.h" 2 3
# 137 "/usr/avr/include/avr/eeprom.h" 3

# 137 "/usr/avr/include/avr/eeprom.h" 3
uint8_t eeprom_read_byte (const uint8_t *__p) __attribute__((__pure__));




uint16_t eeprom_read_word (const uint16_t *__p) __attribute__((__pure__));




uint32_t eeprom_read_dword (const uint32_t *__p) __attribute__((__pure__));




float eeprom_read_float (const float *__p) __attribute__((__pure__));





void eeprom_read_block (void *__dst, const void *__src, size_t __n);





void eeprom_write_byte (uint8_t *__p, uint8_t __value);




void eeprom_write_word (uint16_t *__p, uint16_t __value);




void eeprom_write_dword (uint32_t *__p, uint32_t __value);




void eeprom_write_float (float *__p, float __value);





void eeprom_write_block (const void *__src, void *__dst, size_t __n);





void eeprom_update_byte (uint8_t *__p, uint8_t __value);




void eeprom_update_word (uint16_t *__p, uint16_t __value);




void eeprom_update_dword (uint32_t *__p, uint32_t __value);




void eeprom_update_float (float *__p, float __value);





void eeprom_update_block (const void *__src, void *__dst, size_t __n);
# 9 "lock.h" 2








# 16 "lock.h"
typedef struct __lock_st {
 ow_Pin data_pin;

 void(*lock_func)(void*);
 void(*wait_func)(void*);
 void(*unlock_func)(void*);

 volatile uint8_t *DDR;
 volatile uint8_t *PORT;
 volatile uint8_t *PIN;




 uint8_t num_keys;
} lock_st;

void lock_init(lock_st *lock, void(*lock_func)(void*),
        void(*wait_func)(void*), void(*unlock_func)(void*),
        volatile uint8_t *DDR, volatile uint8_t *PORT,
        volatile uint8_t *PIN);

void lock_lock_func_LED(void* arg);

void lock_wait_func_LED(void* arg);

void lock_unlock_func_LED(void* arg);

void lock_add_key_by_button(lock_st *lock, led_RGB *led);




# 48 "lock.h" 3 4
_Bool 
# 48 "lock.h"
    lock_search_key(lock_st *lock, uint8_t *key, uint8_t crc);

void lock_try_unlock_LED(lock_st *lock, led_RGB *led, uint8_t *id_compare,
    uint8_t *crc, 
# 51 "lock.h" 3 4
                 _Bool 
# 51 "lock.h"
                      resetfirst, 
# 51 "lock.h" 3 4
                                  _Bool 
# 51 "lock.h"
                                       fastfail);

void sleep_ms(uint16_t ms_val);




inline void soft_delay(volatile uint16_t N)
{
 volatile uint8_t inner = 0xFF;
 while (N--) {
  while (inner--);
 }
 return;
}

void lock_interrupt_INT0_init();

void lock_eeprom_write_byte(uint16_t adr_eeprom, uint8_t data_eeprom);

void lock_eeprom_write_key(lock_st *lock, uint8_t *new_key);

uint8_t lock_eeprom_read_byte(uint16_t adr_eeprom);

uint8_t * lock_eeprom_read_key(lock_st *lock, uint8_t key_number, uint8_t *key);
# 4 "main.c" 2
# 1 "print_uart.h" 1
# 9 "print_uart.h"
# 1 "/usr/avr/include/avr/interrupt.h" 1 3
# 10 "print_uart.h" 2
# 1 "/usr/avr/include/avr/sleep.h" 1 3
# 11 "print_uart.h" 2
# 1 "/usr/avr/include/util/atomic.h" 1 3
# 42 "/usr/avr/include/util/atomic.h" 3

# 42 "/usr/avr/include/util/atomic.h" 3
static __inline__ uint8_t __iSeiRetVal(void)
{
    __asm__ __volatile__ ("sei" ::: "memory");
    return 1;
}

static __inline__ uint8_t __iCliRetVal(void)
{
    __asm__ __volatile__ ("cli" ::: "memory");
    return 1;
}

static __inline__ void __iSeiParam(const uint8_t *__s)
{
    __asm__ __volatile__ ("sei" ::: "memory");
    __asm__ volatile ("" ::: "memory");
    (void)__s;
}

static __inline__ void __iCliParam(const uint8_t *__s)
{
    __asm__ __volatile__ ("cli" ::: "memory");
    __asm__ volatile ("" ::: "memory");
    (void)__s;
}

static __inline__ void __iRestore(const uint8_t *__s)
{
    (*(volatile uint8_t *)((0x3F) + 0x20)) = *__s;
    __asm__ volatile ("" ::: "memory");
}
# 12 "print_uart.h" 2


# 1 "/usr/avr/include/stdlib.h" 1 3
# 48 "/usr/avr/include/stdlib.h" 3
# 1 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 1 3 4
# 49 "/usr/avr/include/stdlib.h" 2 3
# 70 "/usr/avr/include/stdlib.h" 3
typedef struct {
 int quot;
 int rem;
} div_t;


typedef struct {
 long quot;
 long rem;
} ldiv_t;


typedef int (*__compar_fn_t)(const void *, const void *);
# 116 "/usr/avr/include/stdlib.h" 3
extern void abort(void) __attribute__((__noreturn__));




extern int abs(int __i) __attribute__((__const__));
# 130 "/usr/avr/include/stdlib.h" 3
extern long labs(long __i) __attribute__((__const__));
# 153 "/usr/avr/include/stdlib.h" 3
extern void *bsearch(const void *__key, const void *__base, size_t __nmemb,
       size_t __size, int (*__compar)(const void *, const void *));







extern div_t div(int __num, int __denom) __asm__("__divmodhi4") __attribute__((__const__));





extern ldiv_t ldiv(long __num, long __denom) __asm__("__divmodsi4") __attribute__((__const__));
# 185 "/usr/avr/include/stdlib.h" 3
extern void qsort(void *__base, size_t __nmemb, size_t __size,
    __compar_fn_t __compar);
# 218 "/usr/avr/include/stdlib.h" 3
extern long strtol(const char *__nptr, char **__endptr, int __base);
# 252 "/usr/avr/include/stdlib.h" 3
extern unsigned long strtoul(const char *__nptr, char **__endptr, int __base);
# 264 "/usr/avr/include/stdlib.h" 3
extern long atol(const char *__s) __attribute__((__pure__));
# 276 "/usr/avr/include/stdlib.h" 3
extern int atoi(const char *__s) __attribute__((__pure__));
# 288 "/usr/avr/include/stdlib.h" 3
extern void exit(int __status) __attribute__((__noreturn__));
# 300 "/usr/avr/include/stdlib.h" 3
extern void *malloc(size_t __size) __attribute__((__malloc__));






extern void free(void *__ptr);




extern size_t __malloc_margin;




extern char *__malloc_heap_start;




extern char *__malloc_heap_end;






extern void *calloc(size_t __nele, size_t __size) __attribute__((__malloc__));
# 348 "/usr/avr/include/stdlib.h" 3
extern void *realloc(void *__ptr, size_t __size) __attribute__((__malloc__));

extern double strtod(const char *__nptr, char **__endptr);

extern double atof(const char *__nptr);
# 374 "/usr/avr/include/stdlib.h" 3
extern int rand(void);



extern void srand(unsigned int __seed);






extern int rand_r(unsigned long *__ctx);
# 419 "/usr/avr/include/stdlib.h" 3
extern __inline__ __attribute__((__gnu_inline__))
char *itoa (int __val, char *__s, int __radix)
{
    if (!__builtin_constant_p (__radix)) {
 extern char *__itoa (int, char *, int);
 return __itoa (__val, __s, __radix);
    } else if (__radix < 2 || __radix > 36) {
 *__s = 0;
 return __s;
    } else {
 extern char *__itoa_ncheck (int, char *, unsigned char);
 return __itoa_ncheck (__val, __s, __radix);
    }
}
# 464 "/usr/avr/include/stdlib.h" 3
extern __inline__ __attribute__((__gnu_inline__))
char *ltoa (long __val, char *__s, int __radix)
{
    if (!__builtin_constant_p (__radix)) {
 extern char *__ltoa (long, char *, int);
 return __ltoa (__val, __s, __radix);
    } else if (__radix < 2 || __radix > 36) {
 *__s = 0;
 return __s;
    } else {
 extern char *__ltoa_ncheck (long, char *, unsigned char);
 return __ltoa_ncheck (__val, __s, __radix);
    }
}
# 507 "/usr/avr/include/stdlib.h" 3
extern __inline__ __attribute__((__gnu_inline__))
char *utoa (unsigned int __val, char *__s, int __radix)
{
    if (!__builtin_constant_p (__radix)) {
 extern char *__utoa (unsigned int, char *, int);
 return __utoa (__val, __s, __radix);
    } else if (__radix < 2 || __radix > 36) {
 *__s = 0;
 return __s;
    } else {
 extern char *__utoa_ncheck (unsigned int, char *, unsigned char);
 return __utoa_ncheck (__val, __s, __radix);
    }
}
# 549 "/usr/avr/include/stdlib.h" 3
extern __inline__ __attribute__((__gnu_inline__))
char *ultoa (unsigned long __val, char *__s, int __radix)
{
    if (!__builtin_constant_p (__radix)) {
 extern char *__ultoa (unsigned long, char *, int);
 return __ultoa (__val, __s, __radix);
    } else if (__radix < 2 || __radix > 36) {
 *__s = 0;
 return __s;
    } else {
 extern char *__ultoa_ncheck (unsigned long, char *, unsigned char);
 return __ultoa_ncheck (__val, __s, __radix);
    }
}
# 581 "/usr/avr/include/stdlib.h" 3
extern long random(void);




extern void srandom(unsigned long __seed);







extern long random_r(unsigned long *__ctx);
# 640 "/usr/avr/include/stdlib.h" 3
extern char *dtostre(double __val, char *__s, unsigned char __prec,
       unsigned char __flags);
# 657 "/usr/avr/include/stdlib.h" 3
extern char *dtostrf(double __val, signed char __width,
                     unsigned char __prec, char *__s);
# 676 "/usr/avr/include/stdlib.h" 3
extern int atexit(void (*)(void));
extern int system (const char *);
extern char *getenv (const char *);
# 15 "print_uart.h" 2


# 16 "print_uart.h"
static const uint32_t uart_baudrate = 19200;


static const uint16_t ubrr_val = (16000000UL / (16 * uart_baudrate)) - 1;

static uint8_t rdbuff[(64)] = {'\0'},
  wrbuff[(64)] = {'\0'};
static uint8_t rdind = 0, wrind = 0;

static volatile 
# 25 "print_uart.h" 3 4
               _Bool 
# 25 "print_uart.h"
                    txcflag = 
# 25 "print_uart.h" 3 4
                              1
# 25 "print_uart.h"
                                  ;
static volatile 
# 26 "print_uart.h" 3 4
               _Bool 
# 26 "print_uart.h"
                    rxcflag = 
# 26 "print_uart.h" 3 4
                              0
# 26 "print_uart.h"
                                   ;


void uart_init(void);

void uart_put(char *str);


# 33 "print_uart.h" 3 4
_Bool 
# 33 "print_uart.h"
    atomic_str_eq(char *str1, char *str2);

char* to_string_uint8_dec(uint8_t arg, char* str);

char* to_string_uint16_dec(uint16_t arg, char* str);

char* to_string_uint8_hex(uint8_t arg, char* str);

char* to_string_uint16_hex(uint16_t arg, char* str);


inline void uart_print_str(char *str)
{
 uart_put(str);
}

inline void uart_print_uint8_dec(uint8_t arg, char* str)
{
 uart_put(to_string_uint8_dec(arg, str));
}

inline void uart_print_uint16_dec(uint16_t arg, char* str)
{
 uart_put(to_string_uint16_dec(arg, str));
}


void uart_print_1wire_id_dec(uint8_t *id);

void uart_print_1wire_id_hex(uint8_t *id);


inline void uart_print_uint8_hex(uint8_t arg, char* str)
{
 uart_put(to_string_uint8_hex(arg, str));
}

inline void uart_print_uint16_hex(uint16_t arg, char* str)
{
 uart_put(to_string_uint16_hex(arg, str));
}
# 5 "main.c" 2





# 1 "/usr/avr/include/avr/power.h" 1 3
# 1147 "/usr/avr/include/avr/power.h" 3

# 1147 "/usr/avr/include/avr/power.h" 3
static __inline void
__attribute__ ((__always_inline__))
__power_all_enable()
{

    (*(volatile uint8_t *)(0x64)) &= (uint8_t)~(((1<<0)|(1<<1)|(1<<2)|(1<<3)|(1<<5)|(1<<6)|(1<<7)));
# 1194 "/usr/avr/include/avr/power.h" 3
}

static __inline void
__attribute__ ((__always_inline__))
__power_all_disable()
{

    (*(volatile uint8_t *)(0x64)) |= (uint8_t)(((1<<0)|(1<<1)|(1<<2)|(1<<3)|(1<<5)|(1<<6)|(1<<7)));
# 1243 "/usr/avr/include/avr/power.h" 3
}
# 1413 "/usr/avr/include/avr/power.h" 3
typedef enum
{
    clock_div_1 = 0,
    clock_div_2 = 1,
    clock_div_4 = 2,
    clock_div_8 = 3,
    clock_div_16 = 4,
    clock_div_32 = 5,
    clock_div_64 = 6,
    clock_div_128 = 7,
    clock_div_256 = 8
# 1433 "/usr/avr/include/avr/power.h" 3
} clock_div_t;

static __inline__ void clock_prescale_set(clock_div_t) __attribute__((__always_inline__));
# 1451 "/usr/avr/include/avr/power.h" 3
void clock_prescale_set(clock_div_t __x)
{
    uint8_t __tmp = (1 << (7));
    __asm__ __volatile__ (
        "in __tmp_reg__,__SREG__" "\n\t"
        "cli" "\n\t"
        "sts %1, %0" "\n\t"
        "sts %1, %2" "\n\t"
        "out __SREG__, __tmp_reg__"
        :
        : "d" (__tmp),
          "M" (((uint16_t) &((*(volatile uint8_t *)(0x61))))),
          "d" (__x)
        : "r0");
}
# 11 "main.c" 2

# 1 "/usr/avr/include/util/delay.h" 1 3
# 45 "/usr/avr/include/util/delay.h" 3
# 1 "/usr/avr/include/util/delay_basic.h" 1 3
# 40 "/usr/avr/include/util/delay_basic.h" 3
static __inline__ void _delay_loop_1(uint8_t __count) __attribute__((__always_inline__));
static __inline__ void _delay_loop_2(uint16_t __count) __attribute__((__always_inline__));
# 80 "/usr/avr/include/util/delay_basic.h" 3
void
_delay_loop_1(uint8_t __count)
{
 __asm__ volatile (
  "1: dec %0" "\n\t"
  "brne 1b"
  : "=r" (__count)
  : "0" (__count)
 );
}
# 102 "/usr/avr/include/util/delay_basic.h" 3
void
_delay_loop_2(uint16_t __count)
{
 __asm__ volatile (
  "1: sbiw %0,1" "\n\t"
  "brne 1b"
  : "=w" (__count)
  : "0" (__count)
 );
}
# 46 "/usr/avr/include/util/delay.h" 2 3
# 1 "/usr/avr/include/math.h" 1 3
# 127 "/usr/avr/include/math.h" 3
extern double cos(double __x) __attribute__((__const__));





extern double sin(double __x) __attribute__((__const__));





extern double tan(double __x) __attribute__((__const__));






extern double fabs(double __x) __attribute__((__const__));






extern double fmod(double __x, double __y) __attribute__((__const__));
# 168 "/usr/avr/include/math.h" 3
extern double modf(double __x, double *__iptr);


extern float modff (float __x, float *__iptr);




extern double sqrt(double __x) __attribute__((__const__));


extern float sqrtf (float) __attribute__((__const__));




extern double cbrt(double __x) __attribute__((__const__));
# 195 "/usr/avr/include/math.h" 3
extern double hypot (double __x, double __y) __attribute__((__const__));







extern double square(double __x) __attribute__((__const__));






extern double floor(double __x) __attribute__((__const__));






extern double ceil(double __x) __attribute__((__const__));
# 235 "/usr/avr/include/math.h" 3
extern double frexp(double __x, int *__pexp);







extern double ldexp(double __x, int __exp) __attribute__((__const__));





extern double exp(double __x) __attribute__((__const__));





extern double cosh(double __x) __attribute__((__const__));





extern double sinh(double __x) __attribute__((__const__));





extern double tanh(double __x) __attribute__((__const__));







extern double acos(double __x) __attribute__((__const__));







extern double asin(double __x) __attribute__((__const__));






extern double atan(double __x) __attribute__((__const__));
# 299 "/usr/avr/include/math.h" 3
extern double atan2(double __y, double __x) __attribute__((__const__));





extern double log(double __x) __attribute__((__const__));





extern double log10(double __x) __attribute__((__const__));





extern double pow(double __x, double __y) __attribute__((__const__));






extern int isnan(double __x) __attribute__((__const__));
# 334 "/usr/avr/include/math.h" 3
extern int isinf(double __x) __attribute__((__const__));






__attribute__((__const__)) static inline int isfinite (double __x)
{
    unsigned char __exp;
    __asm__ (
 "mov	%0, %C1		\n\t"
 "lsl	%0		\n\t"
 "mov	%0, %D1		\n\t"
 "rol	%0		"
 : "=r" (__exp)
 : "r" (__x) );
    return __exp != 0xff;
}






__attribute__((__const__)) static inline double copysign (double __x, double __y)
{
    __asm__ (
 "bst	%D2, 7	\n\t"
 "bld	%D0, 7	"
 : "=r" (__x)
 : "0" (__x), "r" (__y) );
    return __x;
}
# 377 "/usr/avr/include/math.h" 3
extern int signbit (double __x) __attribute__((__const__));






extern double fdim (double __x, double __y) __attribute__((__const__));
# 393 "/usr/avr/include/math.h" 3
extern double fma (double __x, double __y, double __z) __attribute__((__const__));







extern double fmax (double __x, double __y) __attribute__((__const__));







extern double fmin (double __x, double __y) __attribute__((__const__));






extern double trunc (double __x) __attribute__((__const__));
# 427 "/usr/avr/include/math.h" 3
extern double round (double __x) __attribute__((__const__));
# 440 "/usr/avr/include/math.h" 3
extern long lround (double __x) __attribute__((__const__));
# 454 "/usr/avr/include/math.h" 3
extern long lrint (double __x) __attribute__((__const__));
# 47 "/usr/avr/include/util/delay.h" 2 3
# 86 "/usr/avr/include/util/delay.h" 3
static __inline__ void _delay_us(double __us) __attribute__((__always_inline__));
static __inline__ void _delay_ms(double __ms) __attribute__((__always_inline__));
# 165 "/usr/avr/include/util/delay.h" 3
void
_delay_ms(double __ms)
{
 double __tmp ;



 uint32_t __ticks_dc;
 extern void __builtin_avr_delay_cycles(unsigned long);
 __tmp = ((
# 174 "/usr/avr/include/util/delay.h"
          16000000UL
# 174 "/usr/avr/include/util/delay.h" 3
               ) / 1e3) * __ms;
# 184 "/usr/avr/include/util/delay.h" 3
  __ticks_dc = (uint32_t)(ceil(fabs(__tmp)));


 __builtin_avr_delay_cycles(__ticks_dc);
# 210 "/usr/avr/include/util/delay.h" 3
}
# 254 "/usr/avr/include/util/delay.h" 3
void
_delay_us(double __us)
{
 double __tmp ;



 uint32_t __ticks_dc;
 extern void __builtin_avr_delay_cycles(unsigned long);
 __tmp = ((
# 263 "/usr/avr/include/util/delay.h"
          16000000UL
# 263 "/usr/avr/include/util/delay.h" 3
               ) / 1e6) * __us;
# 273 "/usr/avr/include/util/delay.h" 3
  __ticks_dc = (uint32_t)(ceil(fabs(__tmp)));


 __builtin_avr_delay_cycles(__ticks_dc);
# 299 "/usr/avr/include/util/delay.h" 3
}
# 13 "main.c" 2







void __vector_18 (void) __attribute__ ((signal,used, externally_visible)) ; void __vector_18 (void)

# 21 "main.c"
{

 rdbuff[rdind] = 
# 23 "main.c" 3
                (*(volatile uint8_t *)(0xC6))
# 23 "main.c"
                    ;

 if ('\n' == rdbuff[rdind]) {
  rdbuff[rdind] = '\0';
  rxcflag = 
# 27 "main.c" 3 4
           1
# 27 "main.c"
               ;
  rdind = 0;
 } else {
  rxcflag = 
# 30 "main.c" 3 4
           0
# 30 "main.c"
                ;
  rdind++;
 }

 if (rdind >= (64))
  rdind = 0;
}

void soft_delay_us(uint16_t time)
{
 while (time--) {
  _delay_us(1.0);
 }
}

void line_low(void)
{
 
# 47 "main.c" 3
(*(volatile uint8_t *)((0x05) + 0x20)) 
# 47 "main.c"
      &= ~(1 << 0);
 
# 48 "main.c" 3
(*(volatile uint8_t *)((0x04) + 0x20)) 
# 48 "main.c"
     |= (1 << 0);
}

void line_release(void)
{
 
# 53 "main.c" 3
(*(volatile uint8_t *)((0x04) + 0x20)) 
# 53 "main.c"
     &= ~(1 << 0);
 
# 54 "main.c" 3
(*(volatile uint8_t *)((0x05) + 0x20)) 
# 54 "main.c"
      |= (1 << 0);
}


# 57 "main.c" 3 4
_Bool 
# 57 "main.c"
    line_read(void)
{
 uint8_t val = 
# 59 "main.c" 3
              (*(volatile uint8_t *)((0x03) + 0x20)) 
# 59 "main.c"
                   & 0x01;
 return val;
}

void put(uint8_t byte)
{
 
# 65 "main.c" 3
(*(volatile uint8_t *)((0x05) + 0x20)) 
# 65 "main.c"
      |= 1 << 3;
 soft_delay_us(20);
 
# 67 "main.c" 3
(*(volatile uint8_t *)((0x05) + 0x20)) 
# 67 "main.c"
      &= ~(1 << 3);
 for (int i=0; i<8; i++) {
  if (byte & (1 << i))
   
# 70 "main.c" 3
  (*(volatile uint8_t *)((0x05) + 0x20)) 
# 70 "main.c"
        |= 1 << 3;
  else
   
# 72 "main.c" 3
  (*(volatile uint8_t *)((0x05) + 0x20)) 
# 72 "main.c"
        &= ~(1 << 3);
  soft_delay_us(20);
 }
}


int main(void)
{
 led_RGB led;
 led_RGB_init(&led, &
# 81 "main.c" 3
                    (*(volatile uint8_t *)((0x05) + 0x20))
# 81 "main.c"
                         , &
# 81 "main.c" 3
                            (*(volatile uint8_t *)((0x04) + 0x20))
# 81 "main.c"
                                , 
# 81 "main.c" 3
                                  1
# 81 "main.c"
                                     , 
# 81 "main.c" 3
                                       2
# 81 "main.c"
                                          , 
# 81 "main.c" 3
                                            3
# 81 "main.c"
                                               , 
# 81 "main.c" 3 4
                                                 ((void *)0)
# 81 "main.c"
                                                     );

 lock_st lock;
 lock_init(&lock, lock_lock_func_LED, lock_wait_func_LED,
    lock_unlock_func_LED, 
# 85 "main.c" 3
                         (*(volatile uint8_t *)((0x0A) + 0x20))
# 85 "main.c"
                             , 
# 85 "main.c" 3
                               (*(volatile uint8_t *)((0x0B) + 0x20))
# 85 "main.c"
                                    , 
# 85 "main.c" 3
                                      (*(volatile uint8_t *)((0x09) + 0x20))
# 85 "main.c"
                                          );

 ({ ow_err __ret = __ow_Pin_init(&(lock.data_pin), &line_low, &line_release, &line_read, &soft_delay_us, 5, 60, 60, 5); __ret; })
                                   ;

 lock_interrupt_INT0_init();

 uart_init();
 
# 93 "main.c" 3
do { (*(volatile uint8_t *)((0x33) + 0x20)) = (((*(volatile uint8_t *)((0x33) + 0x20)) & ~((1 << (1)) | (1 << (2)) | (1 << (3)))) | ((0x00<<1))); } while(0)
# 93 "main.c"
                               ;
 
# 94 "main.c" 3
do { (*(volatile uint8_t *)((0x33) + 0x20)) |= (uint8_t)(1 << (0)); } while(0)
# 94 "main.c"
              ;
 
# 95 "main.c" 3
__asm__ __volatile__ ("sei" ::: "memory")
# 95 "main.c"
     ;
 char* str = 
# 96 "main.c" 3 4
            ((void *)0)
# 96 "main.c"
                ;

 uart_put("\n\nHello from avr_lock\n\n");

 ow_err err;

 uint8_t ibutton_id_compare[8];
 uint8_t crc;


 uint8_t true_key[8] = {0x01, 0x31, 0x78, 0x83, 0x15, 0x00, 0x00, 0x9A};




 uart_put("\n\nclear EEPROM:\n");
 for(uint16_t i = 0; i < 24; i++) {
  lock_eeprom_write_byte(i, 0xFF);
 }

 uart_put("\n\nparse EEPROM0:\n");
 for(uint16_t i = 0; i < 24; i++) {
  uart_print_uint8_hex(lock_eeprom_read_byte(i), str);
  uart_put(" ");
 }


 lock.num_keys = 0;

 uint8_t *ibutton_id_EEPROM_test = malloc(8 * sizeof(*ibutton_id_EEPROM_test));
 uint8_t key_eeprom_test[8] = {0x01, 0x02, 0x03, 0x04, 0x05 , 0x06, 0x07, 0x08};

 lock_eeprom_write_key(&lock, key_eeprom_test);
 ibutton_id_EEPROM_test = lock_eeprom_read_key(&lock, 1, ibutton_id_EEPROM_test);

 uart_put("\ntest EEPROM1 = ");
 uart_print_1wire_id_hex(ibutton_id_EEPROM_test);
  uart_put("\nnum keys1 = ");
  uart_print_uint8_dec(lock.num_keys, str);


 uart_put("\n\nparse EEPROM1:\n");
 for(uint16_t i = 0; i < 24; i++) {
  uart_print_uint8_hex(lock_eeprom_read_byte(i), str);
  uart_put(" ");
 }
# 154 "main.c"
 uart_put("\n\nparse EEPROM2:\n");
 for(uint16_t i = 0; i < 24; i++) {
  uart_print_uint8_hex(lock_eeprom_read_byte(i), str);
  uart_put(" ");
 }




 while (1) {
  lock_add_key_by_button(&lock, &led);
  lock_try_unlock_LED(&lock, &led, ibutton_id_compare,
        &crc, 
# 166 "main.c" 3 4
             1
# 166 "main.c"
                 , 
# 166 "main.c" 3 4
                   0
# 166 "main.c"
                        );
 }

}
