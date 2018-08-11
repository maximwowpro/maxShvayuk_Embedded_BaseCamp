# 1 "i2c_test.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "i2c_test.c"
# 1 "i2c.h" 1
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
# 2 "i2c.h" 2
# 1 "/usr/avr/include/assert.h" 1 3
# 65 "/usr/avr/include/assert.h" 3
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
# 66 "/usr/avr/include/assert.h" 2 3
# 104 "/usr/avr/include/assert.h" 3
extern void __assert(const char *__func, const char *__file,
       int __lineno, const char *__sexp);
# 3 "i2c.h" 2
# 1 "/usr/lib/gcc/avr/8.2.0/include/stdbool.h" 1 3 4
# 4 "i2c.h" 2
# 15 "i2c.h"

# 15 "i2c.h"
enum I2C_Error {
 I2C_EOK = 0,
 I2C_ESTART
};


extern volatile enum I2C_Error I2C_lasterror;


void __I2C_init(uint32_t hz_freq);








# 32 "i2c.h" 3 4
_Bool 
# 32 "i2c.h"
    __I2C_tx_schedule(uint8_t addr, uint8_t *bytes, uint16_t len, void (*end_callback)(void), 
# 32 "i2c.h" 3 4
                                                                                              _Bool 
# 32 "i2c.h"
                                                                                                   fastfail);
# 2 "i2c_test.c" 2

# 1 "/usr/avr/include/avr/interrupt.h" 1 3
# 4 "i2c_test.c" 2
# 1 "/usr/avr/include/avr/pgmspace.h" 1 3
# 89 "/usr/avr/include/avr/pgmspace.h" 3
# 1 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 1 3 4
# 90 "/usr/avr/include/avr/pgmspace.h" 2 3
# 1085 "/usr/avr/include/avr/pgmspace.h" 3

# 1085 "/usr/avr/include/avr/pgmspace.h" 3
extern const void * memchr_P(const void *, int __val, size_t __len) __attribute__((__const__));
# 1099 "/usr/avr/include/avr/pgmspace.h" 3
extern int memcmp_P(const void *, const void *, size_t) __attribute__((__pure__));






extern void *memccpy_P(void *, const void *, int __val, size_t);
# 1115 "/usr/avr/include/avr/pgmspace.h" 3
extern void *memcpy_P(void *, const void *, size_t);






extern void *memmem_P(const void *, size_t, const void *, size_t) __attribute__((__pure__));
# 1134 "/usr/avr/include/avr/pgmspace.h" 3
extern const void * memrchr_P(const void *, int __val, size_t __len) __attribute__((__const__));
# 1144 "/usr/avr/include/avr/pgmspace.h" 3
extern char *strcat_P(char *, const char *);
# 1160 "/usr/avr/include/avr/pgmspace.h" 3
extern const char * strchr_P(const char *, int __val) __attribute__((__const__));
# 1172 "/usr/avr/include/avr/pgmspace.h" 3
extern const char * strchrnul_P(const char *, int __val) __attribute__((__const__));
# 1185 "/usr/avr/include/avr/pgmspace.h" 3
extern int strcmp_P(const char *, const char *) __attribute__((__pure__));
# 1195 "/usr/avr/include/avr/pgmspace.h" 3
extern char *strcpy_P(char *, const char *);
# 1212 "/usr/avr/include/avr/pgmspace.h" 3
extern int strcasecmp_P(const char *, const char *) __attribute__((__pure__));






extern char *strcasestr_P(const char *, const char *) __attribute__((__pure__));
# 1232 "/usr/avr/include/avr/pgmspace.h" 3
extern size_t strcspn_P(const char *__s, const char * __reject) __attribute__((__pure__));
# 1248 "/usr/avr/include/avr/pgmspace.h" 3
extern size_t strlcat_P (char *, const char *, size_t );
# 1261 "/usr/avr/include/avr/pgmspace.h" 3
extern size_t strlcpy_P (char *, const char *, size_t );
# 1273 "/usr/avr/include/avr/pgmspace.h" 3
extern size_t strnlen_P(const char *, size_t) __attribute__((__const__));
# 1284 "/usr/avr/include/avr/pgmspace.h" 3
extern int strncmp_P(const char *, const char *, size_t) __attribute__((__pure__));
# 1303 "/usr/avr/include/avr/pgmspace.h" 3
extern int strncasecmp_P(const char *, const char *, size_t) __attribute__((__pure__));
# 1314 "/usr/avr/include/avr/pgmspace.h" 3
extern char *strncat_P(char *, const char *, size_t);
# 1328 "/usr/avr/include/avr/pgmspace.h" 3
extern char *strncpy_P(char *, const char *, size_t);
# 1343 "/usr/avr/include/avr/pgmspace.h" 3
extern char *strpbrk_P(const char *__s, const char * __accept) __attribute__((__pure__));
# 1354 "/usr/avr/include/avr/pgmspace.h" 3
extern const char * strrchr_P(const char *, int __val) __attribute__((__const__));
# 1374 "/usr/avr/include/avr/pgmspace.h" 3
extern char *strsep_P(char **__sp, const char * __delim);
# 1387 "/usr/avr/include/avr/pgmspace.h" 3
extern size_t strspn_P(const char *__s, const char * __accept) __attribute__((__pure__));
# 1401 "/usr/avr/include/avr/pgmspace.h" 3
extern char *strstr_P(const char *, const char *) __attribute__((__pure__));
# 1423 "/usr/avr/include/avr/pgmspace.h" 3
extern char *strtok_P(char *__s, const char * __delim);
# 1443 "/usr/avr/include/avr/pgmspace.h" 3
extern char *strtok_rP(char *__s, const char * __delim, char **__last);
# 1456 "/usr/avr/include/avr/pgmspace.h" 3
extern size_t strlen_PF(uint_farptr_t src) __attribute__((__const__));
# 1472 "/usr/avr/include/avr/pgmspace.h" 3
extern size_t strnlen_PF(uint_farptr_t src, size_t len) __attribute__((__const__));
# 1487 "/usr/avr/include/avr/pgmspace.h" 3
extern void *memcpy_PF(void *dest, uint_farptr_t src, size_t len);
# 1502 "/usr/avr/include/avr/pgmspace.h" 3
extern char *strcpy_PF(char *dest, uint_farptr_t src);
# 1522 "/usr/avr/include/avr/pgmspace.h" 3
extern char *strncpy_PF(char *dest, uint_farptr_t src, size_t len);
# 1538 "/usr/avr/include/avr/pgmspace.h" 3
extern char *strcat_PF(char *dest, uint_farptr_t src);
# 1559 "/usr/avr/include/avr/pgmspace.h" 3
extern size_t strlcat_PF(char *dst, uint_farptr_t src, size_t siz);
# 1576 "/usr/avr/include/avr/pgmspace.h" 3
extern char *strncat_PF(char *dest, uint_farptr_t src, size_t len);
# 1592 "/usr/avr/include/avr/pgmspace.h" 3
extern int strcmp_PF(const char *s1, uint_farptr_t s2) __attribute__((__pure__));
# 1609 "/usr/avr/include/avr/pgmspace.h" 3
extern int strncmp_PF(const char *s1, uint_farptr_t s2, size_t n) __attribute__((__pure__));
# 1625 "/usr/avr/include/avr/pgmspace.h" 3
extern int strcasecmp_PF(const char *s1, uint_farptr_t s2) __attribute__((__pure__));
# 1643 "/usr/avr/include/avr/pgmspace.h" 3
extern int strncasecmp_PF(const char *s1, uint_farptr_t s2, size_t n) __attribute__((__pure__));
# 1659 "/usr/avr/include/avr/pgmspace.h" 3
extern char *strstr_PF(const char *s1, uint_farptr_t s2);
# 1671 "/usr/avr/include/avr/pgmspace.h" 3
extern size_t strlcpy_PF(char *dst, uint_farptr_t src, size_t siz);
# 1687 "/usr/avr/include/avr/pgmspace.h" 3
extern int memcmp_PF(const void *, uint_farptr_t, size_t) __attribute__((__pure__));
# 1706 "/usr/avr/include/avr/pgmspace.h" 3
extern size_t __strlen_P(const char *) __attribute__((__const__));
__attribute__((__always_inline__)) static __inline__ size_t strlen_P(const char * s);
static __inline__ size_t strlen_P(const char *s) {
  return __builtin_constant_p(__builtin_strlen(s))
     ? __builtin_strlen(s) : __strlen_P(s);
}
# 5 "i2c_test.c" 2
# 1 "img_128rows.c" 1
# 111 "img_128rows.c"

# 111 "img_128rows.c"
const unsigned char bitmap_open [] 
# 111 "img_128rows.c" 3
                                  __attribute__((__progmem__))
# 111 "img_128rows.c"
                                         =
{
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x80, 0x80, 0xC0,
0xC0, 0xC0, 0xC0, 0xE0, 0xE0, 0xE0, 0xE0, 0xF0, 0xF0, 0xF0,
0xF0, 0xF0, 0xF0, 0xF0, 0xF0, 0xB0, 0x10, 0x10, 0x10, 0x10,
0x30, 0x30, 0x20, 0x60, 0xC0, 0xC0, 0xC0, 0xC0, 0xE0, 0xE0,
0xE0, 0xE0, 0xF0, 0xF0, 0xF0, 0xF0, 0x78, 0x78, 0x38, 0xB8,
0x9C, 0x9C, 0x9C, 0xBC, 0xFC, 0xFC, 0xFC, 0xFC, 0xF4, 0xF4,
0xF4, 0xEC, 0xEC, 0x7C, 0x7C, 0x3C, 0x98, 0xF8, 0xF8, 0xF0,
0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80,
0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x80, 0xC0, 0xE0, 0xF0, 0xF8, 0xF8, 0xFC,
0xFE, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFE, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x2F, 0x0F, 0x0F, 0x0F,
0x8F, 0x8F, 0x03, 0x03, 0x03, 0x03, 0x02, 0x02, 0x06, 0x06,
0x06, 0x06, 0x04, 0x04, 0x0C, 0x08, 0x08, 0x18, 0x10, 0x10,
0x20, 0x60, 0x60, 0xC0, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF0, 0xFC,
0xFF, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0x7F, 0x3F, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0x1F, 0x1F, 0x1F, 0x0F, 0x0F, 0x1F, 0x1F,
0x3F, 0x7F, 0xFF, 0xFF, 0x03, 0x03, 0x03, 0x07, 0x0F, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xFE, 0xFE, 0xFE, 0xFF, 0xFF,
0xFF, 0xFF, 0xFE, 0xE6, 0xE0, 0x40, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x01, 0x01, 0x02, 0x06, 0x0C, 0x18, 0x30, 0xC0,
0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x7F, 0xFF, 0xFF, 0xFF,
0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x3F, 0x1F, 0x0F, 0x87,
0xE3, 0xF9, 0xFC, 0x9F, 0x43, 0x03, 0x23, 0x43, 0x03, 0x07,
0x1F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x7F, 0x7F, 0x7F, 0x7F,
0xFF, 0xFF, 0xFF, 0xFF, 0xEF, 0x0F, 0x8F, 0xFF, 0xDF, 0x1F,
0x2F, 0xFC, 0xF8, 0x80, 0x40, 0x60, 0x00, 0x00, 0x80, 0xC1,
0xFB, 0xC3, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x1E,
0xF8, 0xC0, 0x00, 0x00, 0x00, 0x3F, 0x7F, 0xEF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF1, 0x80,
0xC0, 0xE7, 0xC3, 0xC0, 0x80, 0x00, 0x0E, 0xFF, 0xFF, 0x3F,
0x13, 0x01, 0x00, 0x32, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xDF, 0x81, 0x80, 0x80, 0xC0, 0xC1, 0xC1, 0xC1,
0xC1, 0xC1, 0xC1, 0xC1, 0xFD, 0xFD, 0xFD, 0xFC, 0xFA, 0xFA,
0xFF, 0xEF, 0xFF, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xF0, 0xF0, 0xFC, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xC7,
0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x3F,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x03, 0x07, 0x07,
0x0F, 0x0F, 0x1F, 0x3F, 0x7F, 0x7F, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFC, 0xE0, 0xC3, 0xC1, 0xC0, 0xC0, 0xFE,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0x07, 0x83, 0x03, 0x01, 0x01, 0x01,
0x01, 0x01, 0x03, 0x23, 0x63, 0xE3, 0x83, 0x07, 0x0F, 0x0F,
0x1F, 0x3F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xCF, 0x9F, 0x19, 0x98,
0x90, 0x80, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x80, 0xC0, 0x30, 0x1C, 0x07, 0x01, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x03, 0x03, 0x03,
0x07, 0x07, 0x0F, 0x0F, 0x0F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F,
0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x3F, 0x7F, 0x7F, 0x7F,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF0, 0xE8, 0xC8, 0xE0, 0xE0,
0xF0, 0xF0, 0xFE, 0xFF, 0x3F, 0x00, 0x00, 0x00, 0x80, 0xD8,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xFE, 0xF8, 0xF9,
0xF3, 0xF3, 0xE4, 0xE0, 0xE0, 0xE0, 0xE0, 0xE0, 0xE0, 0xE0,
0xE0, 0x70, 0x30, 0x10, 0x18, 0x08, 0x0C, 0x06, 0x03, 0x01,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x03, 0x03, 0x03, 0x07,
0x07, 0x0F, 0x0F, 0x0F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F,
0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F,
0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F,
0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x1F, 0x1F,
0x1F, 0x1F, 0x1F, 0x1F, 0x0F, 0x0F, 0x0F, 0x0F, 0x07, 0x07,
0x07, 0x07, 0x03, 0x03, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
0x00, 0x00, 0x00, 0x00
};
# 249 "img_128rows.c"
const unsigned char eye1 [] 
# 249 "img_128rows.c" 3
                           __attribute__((__progmem__))
# 249 "img_128rows.c"
                                  =
{
0xFF, 0xFF, 0xBF, 0x1F, 0x0F, 0x0F, 0x07, 0x07, 0x07, 0x0F,
0x0F, 0xFF, 0xFC, 0xF8, 0x00, 0x61, 0x7D, 0x60, 0x40, 0x00,
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x17, 0x0F, 0x0F, 0x00
};

const unsigned char eye1_5 [] 
# 256 "img_128rows.c" 3
                             __attribute__((__progmem__))
# 256 "img_128rows.c"
                                    =
{
0xFF, 0xFF, 0xBF, 0x0F, 0xEF, 0xEF, 0x07, 0x07, 0x07, 0x0F,
0x0F, 0xFF, 0xFC, 0xF8, 0x00, 0x61, 0x79, 0x7C, 0x7F, 0x3F,
0x0F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x17, 0x0F, 0x0F, 0x00
};

const unsigned char eye2 [] 
# 263 "img_128rows.c" 3
                           __attribute__((__progmem__))
# 263 "img_128rows.c"
                                  =
{
0xFF, 0xFF, 0xBF, 0x8F, 0xC7, 0xEF, 0xF7, 0x3F, 0x3F, 0x0F,
0x0F, 0xFF, 0xFC, 0xF0, 0x00, 0x61, 0x7D, 0x70, 0x5C, 0x1F,
0x3F, 0x7F, 0x00, 0x00, 0x00, 0x00, 0x17, 0x0F, 0x0F, 0x00
};

const unsigned char eye3 [] 
# 270 "img_128rows.c" 3
                           __attribute__((__progmem__))
# 270 "img_128rows.c"
                                  =
{
0xFF, 0xFF, 0xBF, 0x8F, 0xCF, 0xEF, 0xF7, 0xFF, 0x7F, 0x2F,
0x0F, 0xFF, 0xFC, 0xF8, 0x00, 0x61, 0x7D, 0x70, 0x5C, 0x1F,
0x3F, 0x7F, 0x7F, 0x00, 0x00, 0x7E, 0x17, 0x0F, 0x0F, 0x00
};
# 6 "i2c_test.c" 2

volatile 
# 7 "i2c_test.c" 3 4
        _Bool 
# 7 "i2c_test.c"
             busyflag = 
# 7 "i2c_test.c" 3 4
                        0
# 7 "i2c_test.c"
                             ;

const static uint32_t frequency = 500000;
const static uint16_t delay = 1000;

static void soft_delay(volatile uint16_t N)
{


 volatile uint8_t inner = 0xFF;
 while (N--) {
  while (inner--);
 }
 return;
}

void empty_callback(void)
{
 busyflag = 
# 25 "i2c_test.c" 3 4
           0
# 25 "i2c_test.c"
                ;
}


uint8_t cmd_displayon[] = {0x80, 0xAF};
uint8_t cmd_setbrightness[] = {0x80, 0x81, 0x80, 0xFF};
uint8_t cmd_forceon[] = {0x80, 0xA5};
uint8_t cmd_chargepump[] = {0x80, 0x8D, 0x80, 0x14};
uint8_t cmd_pagemode[] = {0x80, 0x20, 0x80, 0x02};
uint8_t cmd_seqcom[] = {0x80, 0xDA, 0x80, 0x02};
uint8_t cmd_selpage[] = {0x80, 0xB0};
uint8_t cmd_cursor0[] = {0x80, 0x00, 0x80, 0x10};
uint8_t cmd_cursor15[] = {0x80, 0x08, 0x80, 0x13};
uint8_t cmd_invert[] = {0x80, 0xA6};

uint8_t pagebuffer[129] = {0x40, 0};

int main()
{
 
# 44 "i2c_test.c" 3
__asm__ __volatile__ ("sei" ::: "memory")
# 44 "i2c_test.c"
     ;
 ({ _Static_assert(((frequency) > 16000000UL / 32656 + 1) && ((frequency) <= 16000000UL / 16), "I2C hz freq must be in range [1+F_CPU/32656...F_CPU/16]"); __I2C_init((frequency)); });

 busyflag = 
# 47 "i2c_test.c" 3 4
           1
# 47 "i2c_test.c"
               ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 47 "i2c_test.c" 3 4
                 _Bool 
# 47 "i2c_test.c"
                 __ret = __I2C_tx_schedule((0b0111100), (cmd_chargepump), (4), (&empty_callback), (
# 47 "i2c_test.c" 3 4
                 0
# 47 "i2c_test.c"
                 )); __ret; });
 while (busyflag);

 busyflag = 
# 50 "i2c_test.c" 3 4
           1
# 50 "i2c_test.c"
               ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 50 "i2c_test.c" 3 4
                 _Bool 
# 50 "i2c_test.c"
                 __ret = __I2C_tx_schedule((0b0111100), (cmd_displayon), (2), (&empty_callback), (
# 50 "i2c_test.c" 3 4
                 0
# 50 "i2c_test.c"
                 )); __ret; });
 while (busyflag);

 busyflag = 
# 53 "i2c_test.c" 3 4
           1
# 53 "i2c_test.c"
               ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 53 "i2c_test.c" 3 4
                 _Bool 
# 53 "i2c_test.c"
                 __ret = __I2C_tx_schedule((0b0111100), (cmd_setbrightness), (4), (&empty_callback), (
# 53 "i2c_test.c" 3 4
                 0
# 53 "i2c_test.c"
                 )); __ret; });
 while (busyflag);

 busyflag = 
# 56 "i2c_test.c" 3 4
           1
# 56 "i2c_test.c"
               ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 56 "i2c_test.c" 3 4
                 _Bool 
# 56 "i2c_test.c"
                 __ret = __I2C_tx_schedule((0b0111100), (cmd_invert), (2), (&empty_callback), (
# 56 "i2c_test.c" 3 4
                 0
# 56 "i2c_test.c"
                 )); __ret; });
 while (busyflag);

 for (uint32_t pg = 0; pg < 8; pg++) {
  cmd_selpage[1] = 0xB0 | pg;
  busyflag = 
# 61 "i2c_test.c" 3 4
            1
# 61 "i2c_test.c"
                ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 61 "i2c_test.c" 3 4
                  _Bool 
# 61 "i2c_test.c"
                  __ret = __I2C_tx_schedule((0b0111100), (cmd_selpage), (2), (&empty_callback), (
# 61 "i2c_test.c" 3 4
                  0
# 61 "i2c_test.c"
                  )); __ret; });
  while (busyflag);
  busyflag = 
# 63 "i2c_test.c" 3 4
            1
# 63 "i2c_test.c"
                ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 63 "i2c_test.c" 3 4
                  _Bool 
# 63 "i2c_test.c"
                  __ret = __I2C_tx_schedule((0b0111100), (cmd_cursor0), (4), (&empty_callback), (
# 63 "i2c_test.c" 3 4
                  0
# 63 "i2c_test.c"
                  )); __ret; });
  while (busyflag);

  for (uint8_t i = 1; i < 129; i++) {

   pagebuffer[i] = 
# 68 "i2c_test.c" 3
                  (__extension__({ uint16_t __addr16 = (uint16_t)((uint16_t)(
# 68 "i2c_test.c"
                  &bitmap_open[128 * pg + i - 1]
# 68 "i2c_test.c" 3
                  )); uint8_t __result; __asm__ __volatile__ ( "lpm %0, Z" "\n\t" : "=r" (__result) : "z" (__addr16) ); __result; }))
# 68 "i2c_test.c"
                                                               ;
  }

  busyflag = 
# 71 "i2c_test.c" 3 4
            1
# 71 "i2c_test.c"
                ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 71 "i2c_test.c" 3 4
                  _Bool 
# 71 "i2c_test.c"
                  __ret = __I2C_tx_schedule((0b0111100), (pagebuffer), (129), (&empty_callback), (
# 71 "i2c_test.c" 3 4
                  0
# 71 "i2c_test.c"
                  )); __ret; });
  while (busyflag);
 }

 while (1) {

  soft_delay(delay);

  for (uint32_t pg = 2; pg < 4; pg++) {
   cmd_selpage[1] = 0xB0 | pg;
   busyflag = 
# 81 "i2c_test.c" 3 4
             1
# 81 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 81 "i2c_test.c" 3 4
                   _Bool 
# 81 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (cmd_selpage), (2), (&empty_callback), (
# 81 "i2c_test.c" 3 4
                   0
# 81 "i2c_test.c"
                   )); __ret; });
   while (busyflag);
   busyflag = 
# 83 "i2c_test.c" 3 4
             1
# 83 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 83 "i2c_test.c" 3 4
                   _Bool 
# 83 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (cmd_cursor15), (4), (&empty_callback), (
# 83 "i2c_test.c" 3 4
                   0
# 83 "i2c_test.c"
                   )); __ret; });
   while (busyflag);

   for (uint8_t i = 1; i <= 15; i++) {

    pagebuffer[i] = 
# 88 "i2c_test.c" 3
                   (__extension__({ uint16_t __addr16 = (uint16_t)((uint16_t)(
# 88 "i2c_test.c"
                   &eye3[15 * (pg - 2) + i - 1]
# 88 "i2c_test.c" 3
                   )); uint8_t __result; __asm__ __volatile__ ( "lpm %0, Z" "\n\t" : "=r" (__result) : "z" (__addr16) ); __result; }))
# 88 "i2c_test.c"
                                                              ;
   }

   busyflag = 
# 91 "i2c_test.c" 3 4
             1
# 91 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 91 "i2c_test.c" 3 4
                   _Bool 
# 91 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (pagebuffer), (16), (&empty_callback), (
# 91 "i2c_test.c" 3 4
                   0
# 91 "i2c_test.c"
                   )); __ret; });
   while (busyflag);
  }

  soft_delay(delay);

  for (uint32_t pg = 2; pg < 4; pg++) {
   cmd_selpage[1] = 0xB0 | pg;
   busyflag = 
# 99 "i2c_test.c" 3 4
             1
# 99 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 99 "i2c_test.c" 3 4
                   _Bool 
# 99 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (cmd_selpage), (2), (&empty_callback), (
# 99 "i2c_test.c" 3 4
                   0
# 99 "i2c_test.c"
                   )); __ret; });
   while (busyflag);
   busyflag = 
# 101 "i2c_test.c" 3 4
             1
# 101 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 101 "i2c_test.c" 3 4
                   _Bool 
# 101 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (cmd_cursor15), (4), (&empty_callback), (
# 101 "i2c_test.c" 3 4
                   0
# 101 "i2c_test.c"
                   )); __ret; });
   while (busyflag);

   for (uint8_t i = 1; i <= 15; i++) {

    pagebuffer[i] = 
# 106 "i2c_test.c" 3
                   (__extension__({ uint16_t __addr16 = (uint16_t)((uint16_t)(
# 106 "i2c_test.c"
                   &eye2[15 * (pg - 2) + i - 1]
# 106 "i2c_test.c" 3
                   )); uint8_t __result; __asm__ __volatile__ ( "lpm %0, Z" "\n\t" : "=r" (__result) : "z" (__addr16) ); __result; }))
# 106 "i2c_test.c"
                                                              ;
   }

   busyflag = 
# 109 "i2c_test.c" 3 4
             1
# 109 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 109 "i2c_test.c" 3 4
                   _Bool 
# 109 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (pagebuffer), (16), (&empty_callback), (
# 109 "i2c_test.c" 3 4
                   0
# 109 "i2c_test.c"
                   )); __ret; });
   while (busyflag);
  }

  soft_delay(delay);

  for (uint32_t pg = 2; pg < 4; pg++) {
   cmd_selpage[1] = 0xB0 | pg;
   busyflag = 
# 117 "i2c_test.c" 3 4
             1
# 117 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 117 "i2c_test.c" 3 4
                   _Bool 
# 117 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (cmd_selpage), (2), (&empty_callback), (
# 117 "i2c_test.c" 3 4
                   0
# 117 "i2c_test.c"
                   )); __ret; });
   while (busyflag);
   busyflag = 
# 119 "i2c_test.c" 3 4
             1
# 119 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 119 "i2c_test.c" 3 4
                   _Bool 
# 119 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (cmd_cursor15), (4), (&empty_callback), (
# 119 "i2c_test.c" 3 4
                   0
# 119 "i2c_test.c"
                   )); __ret; });
   while (busyflag);

   for (uint8_t i = 1; i <= 15; i++) {

    pagebuffer[i] = 
# 124 "i2c_test.c" 3
                   (__extension__({ uint16_t __addr16 = (uint16_t)((uint16_t)(
# 124 "i2c_test.c"
                   &eye1_5[15 * (pg - 2) + i - 1]
# 124 "i2c_test.c" 3
                   )); uint8_t __result; __asm__ __volatile__ ( "lpm %0, Z" "\n\t" : "=r" (__result) : "z" (__addr16) ); __result; }))
# 124 "i2c_test.c"
                                                                ;
   }

   busyflag = 
# 127 "i2c_test.c" 3 4
             1
# 127 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 127 "i2c_test.c" 3 4
                   _Bool 
# 127 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (pagebuffer), (16), (&empty_callback), (
# 127 "i2c_test.c" 3 4
                   0
# 127 "i2c_test.c"
                   )); __ret; });
   while (busyflag);
  }

  soft_delay(delay);

  for (uint32_t pg = 2; pg < 4; pg++) {
   cmd_selpage[1] = 0xB0 | pg;
   busyflag = 
# 135 "i2c_test.c" 3 4
             1
# 135 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 135 "i2c_test.c" 3 4
                   _Bool 
# 135 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (cmd_selpage), (2), (&empty_callback), (
# 135 "i2c_test.c" 3 4
                   0
# 135 "i2c_test.c"
                   )); __ret; });
   while (busyflag);
   busyflag = 
# 137 "i2c_test.c" 3 4
             1
# 137 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 137 "i2c_test.c" 3 4
                   _Bool 
# 137 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (cmd_cursor15), (4), (&empty_callback), (
# 137 "i2c_test.c" 3 4
                   0
# 137 "i2c_test.c"
                   )); __ret; });
   while (busyflag);

   for (uint8_t i = 1; i <= 15; i++) {

    pagebuffer[i] = 
# 142 "i2c_test.c" 3
                   (__extension__({ uint16_t __addr16 = (uint16_t)((uint16_t)(
# 142 "i2c_test.c"
                   &eye1[15 * (pg - 2) + i - 1]
# 142 "i2c_test.c" 3
                   )); uint8_t __result; __asm__ __volatile__ ( "lpm %0, Z" "\n\t" : "=r" (__result) : "z" (__addr16) ); __result; }))
# 142 "i2c_test.c"
                                                              ;
   }

   busyflag = 
# 145 "i2c_test.c" 3 4
             1
# 145 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 145 "i2c_test.c" 3 4
                   _Bool 
# 145 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (pagebuffer), (16), (&empty_callback), (
# 145 "i2c_test.c" 3 4
                   0
# 145 "i2c_test.c"
                   )); __ret; });
   while (busyflag);
  }

  soft_delay(delay);

  for (uint32_t pg = 2; pg < 4; pg++) {
   cmd_selpage[1] = 0xB0 | pg;
   busyflag = 
# 153 "i2c_test.c" 3 4
             1
# 153 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 153 "i2c_test.c" 3 4
                   _Bool 
# 153 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (cmd_selpage), (2), (&empty_callback), (
# 153 "i2c_test.c" 3 4
                   0
# 153 "i2c_test.c"
                   )); __ret; });
   while (busyflag);
   busyflag = 
# 155 "i2c_test.c" 3 4
             1
# 155 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 155 "i2c_test.c" 3 4
                   _Bool 
# 155 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (cmd_cursor15), (4), (&empty_callback), (
# 155 "i2c_test.c" 3 4
                   0
# 155 "i2c_test.c"
                   )); __ret; });
   while (busyflag);

   for (uint8_t i = 1; i <= 15; i++) {

    pagebuffer[i] = 
# 160 "i2c_test.c" 3
                   (__extension__({ uint16_t __addr16 = (uint16_t)((uint16_t)(
# 160 "i2c_test.c"
                   &eye1_5[15 * (pg - 2) + i - 1]
# 160 "i2c_test.c" 3
                   )); uint8_t __result; __asm__ __volatile__ ( "lpm %0, Z" "\n\t" : "=r" (__result) : "z" (__addr16) ); __result; }))
# 160 "i2c_test.c"
                                                                ;
   }

   busyflag = 
# 163 "i2c_test.c" 3 4
             1
# 163 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 163 "i2c_test.c" 3 4
                   _Bool 
# 163 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (pagebuffer), (16), (&empty_callback), (
# 163 "i2c_test.c" 3 4
                   0
# 163 "i2c_test.c"
                   )); __ret; });
   while (busyflag);
  }

  soft_delay(delay);

  for (uint32_t pg = 2; pg < 4; pg++) {
   cmd_selpage[1] = 0xB0 | pg;
   busyflag = 
# 171 "i2c_test.c" 3 4
             1
# 171 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 171 "i2c_test.c" 3 4
                   _Bool 
# 171 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (cmd_selpage), (2), (&empty_callback), (
# 171 "i2c_test.c" 3 4
                   0
# 171 "i2c_test.c"
                   )); __ret; });
   while (busyflag);
   busyflag = 
# 173 "i2c_test.c" 3 4
             1
# 173 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 173 "i2c_test.c" 3 4
                   _Bool 
# 173 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (cmd_cursor15), (4), (&empty_callback), (
# 173 "i2c_test.c" 3 4
                   0
# 173 "i2c_test.c"
                   )); __ret; });
   while (busyflag);

   for (uint8_t i = 1; i <= 15; i++) {

    pagebuffer[i] = 
# 178 "i2c_test.c" 3
                   (__extension__({ uint16_t __addr16 = (uint16_t)((uint16_t)(
# 178 "i2c_test.c"
                   &eye2[15 * (pg - 2) + i - 1]
# 178 "i2c_test.c" 3
                   )); uint8_t __result; __asm__ __volatile__ ( "lpm %0, Z" "\n\t" : "=r" (__result) : "z" (__addr16) ); __result; }))
# 178 "i2c_test.c"
                                                              ;
   }

   busyflag = 
# 181 "i2c_test.c" 3 4
             1
# 181 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 181 "i2c_test.c" 3 4
                   _Bool 
# 181 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (pagebuffer), (16), (&empty_callback), (
# 181 "i2c_test.c" 3 4
                   0
# 181 "i2c_test.c"
                   )); __ret; });
   while (busyflag);
  }

  soft_delay(delay);

  for (uint32_t pg = 2; pg < 4; pg++) {
   cmd_selpage[1] = 0xB0 | pg;
   busyflag = 
# 189 "i2c_test.c" 3 4
             1
# 189 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 189 "i2c_test.c" 3 4
                   _Bool 
# 189 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (cmd_selpage), (2), (&empty_callback), (
# 189 "i2c_test.c" 3 4
                   0
# 189 "i2c_test.c"
                   )); __ret; });
   while (busyflag);
   busyflag = 
# 191 "i2c_test.c" 3 4
             1
# 191 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 191 "i2c_test.c" 3 4
                   _Bool 
# 191 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (cmd_cursor15), (4), (&empty_callback), (
# 191 "i2c_test.c" 3 4
                   0
# 191 "i2c_test.c"
                   )); __ret; });
   while (busyflag);

   for (uint8_t i = 1; i <= 15; i++) {

    pagebuffer[i] = 
# 196 "i2c_test.c" 3
                   (__extension__({ uint16_t __addr16 = (uint16_t)((uint16_t)(
# 196 "i2c_test.c"
                   &eye3[15 * (pg - 2) + i - 1]
# 196 "i2c_test.c" 3
                   )); uint8_t __result; __asm__ __volatile__ ( "lpm %0, Z" "\n\t" : "=r" (__result) : "z" (__addr16) ); __result; }))
# 196 "i2c_test.c"
                                                              ;
   }

   busyflag = 
# 199 "i2c_test.c" 3 4
             1
# 199 "i2c_test.c"
                 ; ({ _Static_assert( ((0b0111100) & 0x80) == 0, "I2C address must be 7-bit wide"); 
# 199 "i2c_test.c" 3 4
                   _Bool 
# 199 "i2c_test.c"
                   __ret = __I2C_tx_schedule((0b0111100), (pagebuffer), (16), (&empty_callback), (
# 199 "i2c_test.c" 3 4
                   0
# 199 "i2c_test.c"
                   )); __ret; });
   while (busyflag);
  }
 }
}
