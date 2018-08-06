# 1 "lock.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "lock.c"




# 1 "lock.h" 1



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
# 5 "lock.h" 2
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
# 6 "lock.h" 2


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
# 6 "lock.c" 2


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
# 9 "lock.c" 2

# 1 "/usr/avr/include/util/delay.h" 1 3
# 45 "/usr/avr/include/util/delay.h" 3
# 1 "/usr/avr/include/util/delay_basic.h" 1 3
# 40 "/usr/avr/include/util/delay_basic.h" 3

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
# 11 "lock.c" 2






# 1 "/usr/avr/include/string.h" 1 3
# 46 "/usr/avr/include/string.h" 3
# 1 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 1 3 4
# 47 "/usr/avr/include/string.h" 2 3
# 113 "/usr/avr/include/string.h" 3
extern int ffs (int __val) __attribute__((__const__));
extern int ffsl (long __val) __attribute__((__const__));
__extension__ extern int ffsll (long long __val) __attribute__((__const__));
extern void *memccpy(void *, const void *, int, size_t);
extern void *memchr(const void *, int, size_t) __attribute__((__pure__));
extern int memcmp(const void *, const void *, size_t) __attribute__((__pure__));
extern void *memcpy(void *, const void *, size_t);
extern void *memmem(const void *, size_t, const void *, size_t) __attribute__((__pure__));
extern void *memmove(void *, const void *, size_t);
extern void *memrchr(const void *, int, size_t) __attribute__((__pure__));
extern void *memset(void *, int, size_t);
extern char *strcat(char *, const char *);
extern char *strchr(const char *, int) __attribute__((__pure__));
extern char *strchrnul(const char *, int) __attribute__((__pure__));
extern int strcmp(const char *, const char *) __attribute__((__pure__));
extern char *strcpy(char *, const char *);
extern int strcasecmp(const char *, const char *) __attribute__((__pure__));
extern char *strcasestr(const char *, const char *) __attribute__((__pure__));
extern size_t strcspn(const char *__s, const char *__reject) __attribute__((__pure__));
extern char *strdup(const char *s1);
extern size_t strlcat(char *, const char *, size_t);
extern size_t strlcpy(char *, const char *, size_t);
extern size_t strlen(const char *) __attribute__((__pure__));
extern char *strlwr(char *);
extern char *strncat(char *, const char *, size_t);
extern int strncmp(const char *, const char *, size_t) __attribute__((__pure__));
extern char *strncpy(char *, const char *, size_t);
extern int strncasecmp(const char *, const char *, size_t) __attribute__((__pure__));
extern size_t strnlen(const char *, size_t) __attribute__((__pure__));
extern char *strpbrk(const char *__s, const char *__accept) __attribute__((__pure__));
extern char *strrchr(const char *, int) __attribute__((__pure__));
extern char *strrev(char *);
extern char *strsep(char **, const char *);
extern size_t strspn(const char *__s, const char *__accept) __attribute__((__pure__));
extern char *strstr(const char *, const char *) __attribute__((__pure__));
extern char *strtok(char *, const char *);
extern char *strtok_r(char *, const char *, char **);
extern char *strupr(char *);



extern int strcoll(const char *s1, const char *s2);
extern char *strerror(int errnum);
extern size_t strxfrm(char *dest, const char *src, size_t n);
# 18 "lock.c" 2
# 26 "lock.c"

# 26 "lock.c"
static volatile 
# 26 "lock.c" 3 4
               _Bool 
# 26 "lock.c"
                    key_add_flag = 
# 26 "lock.c" 3 4
                                   0 
# 26 "lock.c"
                                                ;


void lock_init(lock_st *lock, void(*lock_func)(void*),
        void(*wait_func)(void*), void(*unlock_func)(void*),
        volatile uint8_t *DDR, volatile uint8_t *PORT,
        volatile uint8_t *PIN)
{
 lock->lock_func = lock_func;
 lock->wait_func = wait_func;
 lock->unlock_func = unlock_func;

 lock->DDR = DDR;
 lock->PORT = PORT;
 lock->PIN = PIN;





 lock->num_keys = eeprom_read_byte(0x00);


}

void lock_lock_func_LED(void* arg)
{
 led_RGB *led = (led_RGB*)arg;
 led_RGB_red(led);
}

void lock_wait_func_LED(void* arg)
{
 led_RGB *led = (led_RGB*)arg;
 led_RGB_blue(led);
}

void lock_unlock_func_LED(void* arg)
{
 led_RGB *led = (led_RGB*)arg;
 led_RGB_green(led);
}

void lock_add_key_by_button(lock_st *lock, led_RGB *led)
{
 if( 
# 71 "lock.c" 3 4
    1 
# 71 "lock.c"
         == key_add_flag ) {
  uint8_t error_code = 0;
  uint8_t new_key[8];
  uint8_t crc;
  error_code = ({ ow_err __ret = __ow_cmd_readrom(&(lock->data_pin), new_key, &crc, 
# 75 "lock.c" 3 4
              1
# 75 "lock.c"
              , 
# 75 "lock.c" 3 4
              0
# 75 "lock.c"
              ); __ret; })
                                                  ;
  if(OW_EOK == error_code) {
   new_key[7] = crc;
   lock_eeprom_write_key(lock, new_key);
   uart_print_str("\nYou added new key: ");
   uart_print_1wire_id_hex(new_key);
   key_add_flag = 
# 82 "lock.c" 3 4
                 0
# 82 "lock.c"
                      ;

   lock->lock_func(led);
   sleep_ms(1000);
  }
 }
}
# 110 "lock.c"
void lock_eeprom_write_byte(uint16_t adr_eeprom, uint8_t data_eeprom)
{
 
# 112 "lock.c" 3
for ( uint8_t sreg_save __attribute__((__cleanup__(__iRestore))) = (*(volatile uint8_t *)((0x3F) + 0x20)), __ToDo = __iCliRetVal(); __ToDo ; __ToDo = 0 ) 
# 112 "lock.c"
                                  {

  while(
# 114 "lock.c" 3
       (*(volatile uint8_t *)((0x1F) + 0x20)) 
# 114 "lock.c"
            & (1<<
# 114 "lock.c" 3
                  1
# 114 "lock.c"
                      ))
  ;

  
# 117 "lock.c" 3
 (*(volatile uint16_t *)((0x21) + 0x20)) 
# 117 "lock.c"
      = adr_eeprom;
  
# 118 "lock.c" 3
 (*(volatile uint8_t *)((0x20) + 0x20)) 
# 118 "lock.c"
      = data_eeprom;

  
# 120 "lock.c" 3
 (*(volatile uint8_t *)((0x1F) + 0x20)) 
# 120 "lock.c"
      |= (1<<
# 120 "lock.c" 3
             2
# 120 "lock.c"
                  );

  
# 122 "lock.c" 3
 (*(volatile uint8_t *)((0x1F) + 0x20)) 
# 122 "lock.c"
      |= (1<<
# 122 "lock.c" 3
             1
# 122 "lock.c"
                 );
 }
}

void lock_eeprom_write_key(lock_st *lock, uint8_t *new_key)
{
 uint16_t adr_begin = (lock->num_keys) * 8 + 1;
 uint16_t adr_end = adr_begin + 7;
 uint8_t pos = 0;

 for(uint16_t i = adr_begin; i <= adr_end; i++, pos++)
  lock_eeprom_write_byte(i, new_key[pos]);

 (lock->num_keys)++;
 eeprom_write_byte(0x00, lock->num_keys);
}


uint8_t lock_eeprom_read_byte(uint16_t adr_eeprom)
{

 while(
# 143 "lock.c" 3
      (*(volatile uint8_t *)((0x1F) + 0x20)) 
# 143 "lock.c"
           & (1<<
# 143 "lock.c" 3
                 1
# 143 "lock.c"
                     ))
 ;

 
# 146 "lock.c" 3
(*(volatile uint16_t *)((0x21) + 0x20)) 
# 146 "lock.c"
     = adr_eeprom;

 
# 148 "lock.c" 3
(*(volatile uint8_t *)((0x1F) + 0x20)) 
# 148 "lock.c"
     |= (1<<
# 148 "lock.c" 3
            0
# 148 "lock.c"
                );

 return 
# 150 "lock.c" 3
       (*(volatile uint8_t *)((0x20) + 0x20))
# 150 "lock.c"
           ;
}





uint8_t * lock_eeprom_read_key(lock_st *lock, uint8_t key_number, uint8_t *key)
{
 if(key_number == 0 || key_number > lock->num_keys)
  return 
# 160 "lock.c" 3 4
        ((void *)0)
# 160 "lock.c"
            ;

 if(
# 162 "lock.c" 3 4
   ((void *)0) 
# 162 "lock.c"
        == key) {
  key = malloc(8 * sizeof(*key));
  if(
# 164 "lock.c" 3 4
    ((void *)0) 
# 164 "lock.c"
         == key)
   return 
# 165 "lock.c" 3 4
         ((void *)0)
# 165 "lock.c"
             ;
 }

 uint16_t adr_begin = (key_number - 1) * 8 + 1;
 uint16_t adr_end = adr_begin + 7;
 uint8_t pos = 0;

 for(uint16_t i = adr_begin; i <= adr_end; i++, pos++)
  key[pos] = lock_eeprom_read_byte(i);

 return key;
}








# 184 "lock.c" 3 4
_Bool 
# 184 "lock.c"
    lock_search_key(lock_st *lock, uint8_t *key, uint8_t crc)
{
 uint8_t pos = 0;

 for(uint8_t i = 0; i < lock->num_keys; i++) {
  uint16_t adr_begin = 8 * i + 1;
  uint16_t adr_end = adr_begin + 7;

  for(; pos < 7; pos++) {
   if( key[pos] != lock_eeprom_read_byte(adr_begin + pos) ) {
    pos = 0;
    break;
   }
  }
  if( pos >= 6 && lock_eeprom_read_byte(adr_begin + 7) == crc )
   return 
# 199 "lock.c" 3 4
         1
# 199 "lock.c"
             ;
 }

 return 
# 202 "lock.c" 3 4
       0
# 202 "lock.c"
            ;
# 215 "lock.c"
}

void lock_try_unlock_LED(lock_st *lock, led_RGB *led, uint8_t *id_compare,
    uint8_t *crc, 
# 218 "lock.c" 3 4
                 _Bool 
# 218 "lock.c"
                      resetfirst, 
# 218 "lock.c" 3 4
                                  _Bool 
# 218 "lock.c"
                                       fastfail)
{
 lock->wait_func(led);

 uint8_t error_code = 0;
 error_code = ({ ow_err __ret = __ow_cmd_readrom(&(lock->data_pin), id_compare, crc, resetfirst, fastfail); __ret; })
                                                            ;

 if(OW_EOK == error_code) {
  char* str = 
# 227 "lock.c" 3 4
             ((void *)0)
# 227 "lock.c"
                 ;
  uart_put("\nlock_try_unlock_LED:  ");
  uart_print_1wire_id_hex(id_compare);
  uart_put("\nCRC = ");
  uart_print_uint8_hex(*crc, str);

  if( 
# 233 "lock.c" 3 4
     1 
# 233 "lock.c"
          == lock_search_key(lock, id_compare, *crc) ) {
   lock->unlock_func(led);
   uart_put("\nUnlocking success!\n");
   sleep_ms(2000);

   for(uint8_t i = 0; i < 8; i++)
    id_compare[i] = 0x00;

   lock->wait_func(led);
  } else {
   lock->lock_func(led);
   uart_put("\nUnlocking failed! Your devise isn't suitable key\n");
   sleep_ms(1000);
   lock->wait_func(led);
  }
 }
}




# 253 "lock.c" 3
void __vector_9 (void) __attribute__ ((signal,used, externally_visible)) ; void __vector_9 (void)

# 254 "lock.c"
{
 
# 255 "lock.c" 3
(*(volatile uint8_t *)(0xB1)) 
# 255 "lock.c"
       &= ~((1 << 
# 255 "lock.c" 3
                  2
# 255 "lock.c"
                      ) | (1 << 
# 255 "lock.c" 3
                                1
# 255 "lock.c"
                                    ) | (1 << 
# 255 "lock.c" 3
                                              0
# 255 "lock.c"
                                                  ));
}

void sleep_ms(uint16_t ms_val)
{
 
# 260 "lock.c" 3
do { (*(volatile uint8_t *)((0x33) + 0x20)) = (((*(volatile uint8_t *)((0x33) + 0x20)) & ~((1 << (1)) | (1 << (2)) | (1 << (3)))) | ((0x00<<1))); } while(0)
# 260 "lock.c"
                               ;

 
# 262 "lock.c" 3
__asm__ __volatile__ ("cli" ::: "memory")
# 262 "lock.c"
     ;
 
# 263 "lock.c" 3
do { (*(volatile uint8_t *)((0x33) + 0x20)) |= (uint8_t)(1 << (0)); } while(0)
# 263 "lock.c"
              ;
 
# 264 "lock.c" 3
__asm__ __volatile__ ("sei" ::: "memory")
# 264 "lock.c"
     ;
 
# 265 "lock.c" 3
(*(volatile uint8_t *)(0x70)) 
# 265 "lock.c"
       |= (1 << 
# 265 "lock.c" 3
                0
# 265 "lock.c"
                     );
 while (ms_val--) {

  
# 268 "lock.c" 3
 (*(volatile uint8_t *)(0xB2)) 
# 268 "lock.c"
       = (uint8_t)(0xFF - (16000000UL / 128) / 1000);


  
# 271 "lock.c" 3
 (*(volatile uint8_t *)(0xB1)) 
# 271 "lock.c"
        = (1 << 
# 271 "lock.c" 3
                 2
# 271 "lock.c"
                     ) | (1 << 
# 271 "lock.c" 3
                               0
# 271 "lock.c"
                                   );

  
# 273 "lock.c" 3
 do { __asm__ __volatile__ ( "sleep" "\n\t" :: ); } while(0)
# 273 "lock.c"
            ;
 }
 
# 275 "lock.c" 3
do { (*(volatile uint8_t *)((0x33) + 0x20)) &= (uint8_t)(~(1 << (0))); } while(0)
# 275 "lock.c"
               ;
}

extern void soft_delay(volatile uint16_t N);



# 281 "lock.c" 3
void __vector_1 (void) __attribute__ ((signal,used, externally_visible)) ; void __vector_1 (void)

# 282 "lock.c"
{
 if( 
# 283 "lock.c" 3
    (*(volatile uint8_t *)((0x09) + 0x20)) 
# 283 "lock.c"
         & (1 << 2) ) {
  soft_delay(30);
  if( 
# 285 "lock.c" 3
     (*(volatile uint8_t *)((0x09) + 0x20)) 
# 285 "lock.c"
          & (1 << 2) ) {
   key_add_flag = 
# 286 "lock.c" 3 4
                 1
# 286 "lock.c"
                     ;
   uart_print_str("\nPlease, add new key:\n");
  }
 }

}

void lock_interrupt_INT0_init()
{

 
# 296 "lock.c" 3
(*(volatile uint8_t *)((0x0A) + 0x20)) 
# 296 "lock.c"
      &= ~(1 << 2);
 
# 297 "lock.c" 3
(*(volatile uint8_t *)((0x0B) + 0x20)) 
# 297 "lock.c"
      &= ~(1 << 2);


 
# 300 "lock.c" 3
(*(volatile uint8_t *)(0x69)) 
# 300 "lock.c"
      &= ~(1 << 
# 300 "lock.c" 3
                1
# 300 "lock.c"
                     );
 
# 301 "lock.c" 3
(*(volatile uint8_t *)(0x69)) 
# 301 "lock.c"
      |= (1 << 
# 301 "lock.c" 3
                0
# 301 "lock.c"
                     );

 
# 303 "lock.c" 3
(*(volatile uint8_t *)((0x1D) + 0x20)) 
# 303 "lock.c"
      |= (1 << 
# 303 "lock.c" 3
                0
# 303 "lock.c"
                    );

 
# 305 "lock.c" 3
__asm__ __volatile__ ("sei" ::: "memory")
# 305 "lock.c"
     ;
}
