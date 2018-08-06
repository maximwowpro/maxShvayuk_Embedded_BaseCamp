# 1 "onewire.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "onewire.c"




# 1 "/usr/avr/include/avr/pgmspace.h" 1 3
# 88 "/usr/avr/include/avr/pgmspace.h" 3
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
# 89 "/usr/avr/include/avr/pgmspace.h" 2 3
# 1 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 1 3 4
# 216 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 3 4
typedef unsigned int size_t;
# 90 "/usr/avr/include/avr/pgmspace.h" 2 3
# 1 "/usr/avr/include/avr/io.h" 1 3
# 99 "/usr/avr/include/avr/io.h" 3
# 1 "/usr/avr/include/avr/sfr_defs.h" 1 3
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
# 91 "/usr/avr/include/avr/pgmspace.h" 2 3
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
# 6 "onewire.c" 2





# 1 "onewire.h" 1




# 1 "/usr/lib/gcc/avr/8.2.0/include/stdbool.h" 1 3 4
# 6 "onewire.h" 2
# 1 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 1 3 4
# 149 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 3 4
typedef int ptrdiff_t;
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
# 12 "onewire.c" 2


# 1 "/usr/lib/gcc/avr/8.2.0/include/stddef.h" 1 3 4
# 15 "onewire.c" 2
# 26 "onewire.c"
static const uint8_t ow_maxim_crc_table[] 
# 26 "onewire.c" 3
                                         __attribute__((__progmem__)) 
# 26 "onewire.c"
                                                 = {
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
 *crc_ptr = 
# 49 "onewire.c" 3
           (__extension__({ uint16_t __addr16 = (uint16_t)((uint16_t)(
# 49 "onewire.c"
           &(ow_maxim_crc_table[byte])
# 49 "onewire.c" 3
           )); uint8_t __result; __asm__ __volatile__ ( "lpm %0, Z" "\n\t" : "=r" (__result) : "z" (__addr16) ); __result; }))
# 49 "onewire.c"
                                                     ;
}


uint8_t ow_crc8_fast_arr(uint8_t *array, uint16_t len)
{
 uint8_t crc = 0;
 for (typeof(len) i = 0; i < len; i++)
  ow_crc8_fast(&crc, array[i]);
 return crc;
}


ow_err __ow_Pin_init(ow_Pin *pin, void (*line_low)(void), void (*line_release)(void), 
# 62 "onewire.c" 3 4
                                                                                     _Bool 
# 62 "onewire.c"
                                                                                          (*line_read)(void),
       void (*delay_us)(uint16_t), uint8_t release_step_us, uint16_t release_max_us,
       uint8_t ts_len_us, uint8_t ts_holdlow_us)
{
 if ((release_max_us % release_step_us != 0) || (release_max_us < 15) || (release_max_us > 60))
  return OW_EINIT;
 if ((line_low == 
# 68 "onewire.c" 3 4
                 ((void *)0)
# 68 "onewire.c"
                     ) || (line_release == 
# 68 "onewire.c" 3 4
                                           ((void *)0)
# 68 "onewire.c"
                                               ) || (line_read == 
# 68 "onewire.c" 3 4
                                                                  ((void *)0)
# 68 "onewire.c"
                                                                      ) || (delay_us == 
# 68 "onewire.c" 3 4
                                                                                        ((void *)0)
# 68 "onewire.c"
                                                                                            ))
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

 (*pin->line_low)();
 (*pin->delay_us)(480);
 (*pin->line_release)();


 uint16_t wait = ow_wait_release(pin);
 if (!wait)
  return OW_ELINEBREAK;


 (*pin->delay_us)(60);
 if ((*pin->line_read)())
  return OW_ENORESP;



 uint16_t us_left = 480 - 60 - wait;
 (*pin->delay_us)(us_left);


 if (!(*pin->line_read)())
  return OW_ELINEBREAK;

 return OW_EOK;
}


ow_err ow_tx_bit(ow_Pin *pin, 
# 133 "onewire.c" 3 4
                             _Bool 
# 133 "onewire.c"
                                  bit)
{


 (*pin->line_low)();
 uint16_t wait;

 if (!bit) {
  (*pin->delay_us)(pin->ts_len_us);
  (*pin->line_release)();
  if (!ow_wait_release(pin))
   return OW_ELINEBREAK;
 } else {
  (*pin->delay_us)(pin->ts_holdlow_us);
  (*pin->line_release)();
  wait = ow_wait_release(pin);
  if (!wait)
   return OW_ELINEBREAK;

  (*pin->delay_us)(pin->ts_len_us - pin->ts_holdlow_us - wait);
 }
 return OW_EOK;
}


ow_err __ow_rx_bit(ow_Pin *pin, 
# 158 "onewire.c" 3 4
                               _Bool 
# 158 "onewire.c"
                                    *bit, 
# 158 "onewire.c" 3 4
                                          _Bool 
# 158 "onewire.c"
                                               fastfail)
{



 (*pin->line_low)();
 (*pin->delay_us)(pin->ts_holdlow_us);
 (*pin->line_release)();
 (*pin->delay_us)(15 - pin->ts_holdlow_us);


 uint8_t arb = 0, cnt = 0;
 for (uint8_t i = 0; i < 8; i++) {
  arb |= (*pin->line_read)() << i;
 }
 for (uint8_t i = 0; i < 8; i++) {
  if (arb & (1 << i))
   cnt++;
 }




 *bit = (cnt >= 5);
 
# 182 "onewire.c" 3 4
_Bool 
# 182 "onewire.c"
     err = (cnt >= 2) && (cnt <= 7);


 if (!err || !fastfail) {
  (*pin->delay_us)(pin->ts_len_us - 15);



 }

 if (err)
  return OW_ENOISESIG;

 return OW_EOK;
}


ow_err __ow_tx_byte(ow_Pin *pin, uint8_t byte, 
# 199 "onewire.c" 3 4
                                              _Bool 
# 199 "onewire.c"
                                                   fastfail)
{
 ow_err err = OW_EOK;
 for (uint8_t i = 0; i < 8; i++) {
  
# 203 "onewire.c" 3 4
 _Bool 
# 203 "onewire.c"
      bit = (byte & (1 << i)) >> i;
  err = ow_tx_bit(pin, bit);
  if ((err != OW_EOK) && fastfail)
   break;
 }
 return err;
}


ow_err __ow_rx_byte(ow_Pin *pin, uint8_t *byte, 
# 212 "onewire.c" 3 4
                                               _Bool 
# 212 "onewire.c"
                                                    fastfail)
{
 ow_err err = OW_EOK;
 *byte = 0;
 for (uint8_t i = 0; i < 8; i++) {
  
# 217 "onewire.c" 3 4
 _Bool 
# 217 "onewire.c"
      bit;
  err = ({ ow_err __ret = __ow_rx_bit(pin, &bit, fastfail); __ret; });
  *byte |= bit << i;
  if ((err != OW_EOK) && fastfail)
   break;
 }
 return err;
}


ow_err __ow_cmd_readrom(ow_Pin *pin, uint8_t *rombytes, uint8_t *devcrc, 
# 227 "onewire.c" 3 4
                                                                        _Bool 
# 227 "onewire.c"
                                                                             resetfirst, 
# 227 "onewire.c" 3 4
                                                                                         _Bool 
# 227 "onewire.c"
                                                                                              fastfail)
{


 ow_err err = OW_EOK;

 if (resetfirst)
  err = ow_tx_reset(pin);

 if (err != OW_EOK)
  return err;


 err = ({ ow_err __ret = __ow_tx_byte(pin, 0x33, fastfail); __ret; });
 if ((err != OW_EOK) && fastfail)
  return err;


 for (uint8_t i = 0; i < 7; i++) {
  err = ({ ow_err __ret = __ow_rx_byte(pin, &rombytes[i], fastfail); __ret; });
  if ((err != OW_EOK) && fastfail)
   return err;
 }


 uint8_t readcrc = 0;
 err = ({ ow_err __ret = __ow_rx_byte(pin, &readcrc, fastfail); __ret; });
 if ((err != OW_EOK) && fastfail)
  return err;

 if (
# 257 "onewire.c" 3 4
    ((void *)0) 
# 257 "onewire.c"
         != devcrc)
  *devcrc = readcrc;


 uint8_t calccrc = ow_crc8_fast_arr(rombytes, 7);
 if (readcrc != calccrc)
  return OW_ECRC;

 return OW_EOK;
}
