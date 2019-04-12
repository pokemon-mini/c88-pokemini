/*
 * ISO/IEC 9899:1999  7.18 Integer types <stdint.h>
 */

#ifndef _STDINT_H
#define _STDINT_H

/* Fixed integer types */
typedef signed char int8_t;
typedef unsigned char uint8_t;
typedef signed int int16_t;
typedef unsigned int uint16_t;
typedef signed long int int32_t;
typedef unsigned long int uint32_t;

/* Integers capable of holding a pointer */
typedef int16_t intptr_t;
typedef uint16_t uintptr_t;

/* Minimum integer types */
typedef int8_t   int_least8_t;
typedef uint8_t  uint_least8_t;
typedef int16_t  int_least16_t;
typedef uint16_t uint_least16_t;
typedef int32_t  int_least32_t;
typedef uint32_t uint_least32_t;

/* Fast integer types */
typedef int8_t int_fast8_t;
typedef uint8_t uint_fast8_t;
typedef int16_t int_fast16_t;
typedef uint16_t uint_fast16_t;
typedef int32_t int_fast32_t;
typedef uint32_t uint_fast32_t;

/* Maximum width integer types */
typedef int32_t intmax_t;
typedef uint32_t uintmax_t;

#define	CHAR_BIT	(8)
#define	INT8_MAX	(127)
#define	INT8_MIN	(-SCHAR_MAX-1)
#define	UINT8_MAX	(0xFFU)

#define	INT16_MAX	(32767)
#define	INT16_MIN	(-SHRT_MAX-1)
#define	UINT16_MAX	(0xFFFFU)

#define INT32_MAX	(2147483647)
#define	INT32_MIN	(-LONG_MAX-1)
#define	UINT32_MAX	(0xFFFFFFFFUL)

#define INT_LEAST8_MAX INT8_MAX
#define INT_LEAST8_MIN INT8_MIN
#define UINT_LEAST8_MAX UINT8_MAX
#define INT_LEAST16_MAX INT16_MAX
#define INT_LEAST16_MIN INT16_MIN
#define UINT_LEAST16_MAX UINT16_MAX
#define INT_LEAST32_MAX INT32_MAX
#define INT_LEAST32_MIN INT32_MIN
#define UINT_LEAST32_MAX UINT32_MAX
#define INT_LEAST64_MAX INT64_MAX
#define INT_LEAST64_MIN INT64_MIN
#define UINT_LEAST64_MAX UINT64_MAX

#define INT_FAST8_MAX INT8_MAX
#define INT_FAST8_MIN INT8_MIN
#define UINT_FAST8_MAX UINT8_MAX
#define INT_FAST16_MAX INT16_MAX
#define INT_FAST16_MIN INT16_MIN
#define UINT_FAST16_MAX UINT16_MAX
#define INT_FAST32_MAX INT32_MAX
#define INT_FAST32_MIN INT32_MIN
#define UINT_FAST32_MAX UINT32_MAX
#define INT_FAST64_MAX INT64_MAX
#define INT_FAST64_MIN INT64_MIN
#define UINT_FAST64_MAX UINT64_MAX

#define INTPTR_MAX INT16_MAX
#define INTPTR_MIN INT16_MIN
#define UINTPTR_MAX UINT16_MAX


#define INTMAX_MAX INT32_MAX
#define INTMAX_MIN INT32_MIN
#define UINTMAX_MAX UINT32_MAX


#define PTRDIFF_MAX INT16_MAX
#define PTRDIFF_MIN INT16_MIN


#define SIG_ATOMIC_MAX INT8_MAX
#define SIG_ATOMIC_MIN INT8_MIN

#define SIZE_MAX UINT16_MAX

/* Signed.  */
# define INT8_C(c)	c
# define INT16_C(c)	c
# define INT32_C(c)	c ## L


/* Unsigned.  */
# define UINT8_C(c)	c
# define UINT16_C(c)	c
# define UINT32_C(c)	c ## UL


/* Maximal type.  */
# define INTMAX_C(c)	c ## L
# define UINTMAX_C(c)	c ## UL

#endif /* _STDINT_H */
