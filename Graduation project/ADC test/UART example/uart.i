# 1 "uart.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "uart.c"
# 11 "uart.c"
# 1 "print_uart.h" 1







# 1 "/usr/avr/include/avr/interrupt.h" 1 3
# 38 "/usr/avr/include/avr/interrupt.h" 3
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
# 39 "/usr/avr/include/avr/interrupt.h" 2 3
# 9 "print_uart.h" 2
# 1 "/usr/avr/include/avr/sleep.h" 1 3
# 10 "print_uart.h" 2
# 1 "/usr/avr/include/util/atomic.h" 1 3
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
# 11 "print_uart.h" 2

# 1 "/usr/lib/gcc/avr/8.2.0/include/stdbool.h" 1 3 4
# 13 "print_uart.h" 2
# 1 "/usr/avr/include/stdlib.h" 1 3
# 48 "/usr/avr/include/stdlib.h" 3
# 1 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 1 3 4
# 216 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 3 4
typedef unsigned int size_t;
# 328 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 3 4
typedef int wchar_t;
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
# 14 "print_uart.h" 2


# 15 "print_uart.h"
const uint32_t uart_baudrate = 19200;


const uint16_t ubrr_val = (16000000UL / (16 * uart_baudrate)) - 1;

uint8_t rdbuff[(64)] = {'\0'},
  wrbuff[(64)] = {'\0'};
uint8_t rdind = 0, wrind = 0;

volatile 
# 24 "print_uart.h" 3 4
        _Bool 
# 24 "print_uart.h"
             txcflag = 
# 24 "print_uart.h" 3 4
                       1
# 24 "print_uart.h"
                           ;
volatile 
# 25 "print_uart.h" 3 4
        _Bool 
# 25 "print_uart.h"
             rxcflag = 
# 25 "print_uart.h" 3 4
                       0
# 25 "print_uart.h"
                            ;




# 29 "print_uart.h" 3
void __vector_18 (void) __attribute__ ((signal,used, externally_visible)) ; void __vector_18 (void)

# 30 "print_uart.h"
{

 rdbuff[rdind] = 
# 32 "print_uart.h" 3
                (*(volatile uint8_t *)(0xC6))
# 32 "print_uart.h"
                    ;

 if ('\n' == rdbuff[rdind]) {
  rdbuff[rdind] = '\0';
  rxcflag = 
# 36 "print_uart.h" 3 4
           1
# 36 "print_uart.h"
               ;
  rdind = 0;
 } else {
  rxcflag = 
# 39 "print_uart.h" 3 4
           0
# 39 "print_uart.h"
                ;
  rdind++;
 }

 if (rdind >= (64))
  rdind = 0;
}




# 49 "print_uart.h" 3
void __vector_20 (void) __attribute__ ((signal,used, externally_visible)) ; void __vector_20 (void)

# 50 "print_uart.h"
{


 
# 53 "print_uart.h" 3
(*(volatile uint8_t *)(0xC1)) 
# 53 "print_uart.h"
       &= ~(1 << 
# 53 "print_uart.h" 3
                 6
# 53 "print_uart.h"
                       );
}




# 58 "print_uart.h" 3
void __vector_19 (void) __attribute__ ((signal,used, externally_visible)) ; void __vector_19 (void)

# 59 "print_uart.h"
{
 if (('\0' == wrbuff[wrind]) || txcflag) {

  
# 62 "print_uart.h" 3
 (*(volatile uint8_t *)(0xC1)) 
# 62 "print_uart.h"
        &= ~(1 << 
# 62 "print_uart.h" 3
                  5
# 62 "print_uart.h"
                        );
  txcflag = 
# 63 "print_uart.h" 3 4
           1
# 63 "print_uart.h"
               ;
  return;
 }

 
# 67 "print_uart.h" 3
(*(volatile uint8_t *)(0xC6)) 
# 67 "print_uart.h"
     = wrbuff[wrind++];


 if (wrind >= (64))
  wrind = 0;
}

void uart_init(void);

void uart_put(char *str);


# 78 "print_uart.h" 3 4
_Bool 
# 78 "print_uart.h"
    atomic_str_eq(char *str1, char *str2);

char* to_string_uint8(uint8_t arg, char* str);

char* to_string_uint16(uint16_t arg, char* str);

inline void uart_print_str(char *str)
{
 uart_put(str);
}

inline void uart_print_uint8(uint8_t arg, char* str)
{
 uart_put(to_string_uint8(arg, str));
}

inline void uart_print_uint16(uint16_t arg, char* str)
{
 uart_put(to_string_uint16(arg, str));
}
# 12 "uart.c" 2





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
# 18 "uart.c" 2
# 260 "uart.c"

# 260 "uart.c"
int main()
{
 
# 262 "uart.c" 3
(*(volatile uint8_t *)((0x04) + 0x20)) 
# 262 "uart.c"
     |= (1 << 0) | (1 << 1);
 
# 263 "uart.c" 3
(*(volatile uint8_t *)((0x05) + 0x20)) 
# 263 "uart.c"
      |= (1 << 0);

 uart_init();
# 308 "uart.c"
}
