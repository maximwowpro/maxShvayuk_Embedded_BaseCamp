	.file	"print_uart.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	__vector_19
	.type	__vector_19, @function
__vector_19:
	__gcc_isr 1
	push r24
	push r25
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 4...8 */
.L__stack_usage = 4 + __gcc_isr.n_pushed
	lds r24,wrind
	mov r30,r24
	ldi r31,0
	subi r30,lo8(-(wrbuff))
	sbci r31,hi8(-(wrbuff))
	ld r25,Z
	tst r25
	breq .L2
	lds r18,txcflag
	tst r18
	breq .L3
.L2:
	lds r24,193
	andi r24,lo8(-33)
	sts 193,r24
	ldi r24,lo8(1)
	sts txcflag,r24
.L1:
/* epilogue start */
	pop r31
	pop r30
	pop r25
	pop r24
	__gcc_isr 2
	reti
.L3:
	subi r24,lo8(-(1))
	sts wrind,r24
	sts 198,r25
	lds r24,wrind
	cpi r24,lo8(64)
	brlo .L1
	sts wrind,__zero_reg__
	rjmp .L1
	__gcc_isr 0,r18
	.size	__vector_19, .-__vector_19
.global	__vector_20
	.type	__vector_20, @function
__vector_20:
	__gcc_isr 1
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 2...6 */
.L__stack_usage = 2 + __gcc_isr.n_pushed
	ldi r30,lo8(-63)
	ldi r31,0
	ld r24,Z
	andi r24,lo8(-65)
	st Z,r24
/* epilogue start */
	pop r31
	pop r30
	__gcc_isr 2
	reti
	__gcc_isr 0,r24
	.size	__vector_20, .-__vector_20
.global	uart_init
	.type	uart_init, @function
uart_init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r30,lo8(100)
	ldi r31,0
	ld r24,Z
	andi r24,lo8(-3)
	st Z,r24
	ldi r24,lo8(51)
	sts 196,r24
	sts 197,__zero_reg__
	ldi r24,lo8(46)
	sts 194,r24
	ldi r24,lo8(-104)
	sts 193,r24
/* epilogue start */
	ret
	.size	uart_init, .-uart_init
.global	uart_put
	.type	uart_put, @function
uart_put:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
.L11:
	lds r18,txcflag
	tst r18
	breq .L12
	in r18,__SREG__
/* #APP */
 ;  50 "/usr/avr/include/util/atomic.h" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r26,lo8(wrbuff)
	ldi r27,hi8(wrbuff)
	movw r30,r24
	subi r24,lo8(-(64))
.L14:
	ld r25,Z+
	st X+,r25
	tst r25
	breq .L13
	cpse r24,r30
	rjmp .L14
.L13:
	sts wrind,__zero_reg__
	sts txcflag,__zero_reg__
	lds r24,193
	ori r24,lo8(96)
	sts 193,r24
	out __SREG__,r18
/* epilogue start */
	ret
.L12:
/* #APP */
 ;  64 "print_uart.c" 1
	sleep
	
 ;  0 "" 2
/* #NOAPP */
	rjmp .L11
	.size	uart_put, .-uart_put
.global	uart_print_str
	.type	uart_print_str, @function
uart_print_str:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp uart_put
	.size	uart_print_str, .-uart_print_str
.global	atomic_str_eq
	.type	atomic_str_eq, @function
atomic_str_eq:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r18,__SREG__
/* #APP */
 ;  50 "/usr/avr/include/util/atomic.h" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	movw r26,r22
	movw r30,r24
	subi r24,lo8(-(64))
.L22:
	ld r25,Z+
	ld r19,X+
	cpse r25,r19
	rjmp .L23
	tst r25
	breq .L24
	cpse r24,r30
	rjmp .L22
.L24:
	ldi r24,lo8(1)
	rjmp .L21
.L23:
	ldi r24,0
.L21:
	out __SREG__,r18
/* epilogue start */
	ret
	.size	atomic_str_eq, .-atomic_str_eq
.global	to_string_uint8
	.type	to_string_uint8, @function
to_string_uint8:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	mov r28,r24
	ldi r24,lo8(4)
	ldi r25,0
	call malloc
	movw r30,r24
	cpi r28,lo8(100)
	brlo .L27
	mov r24,r28
	ldi r22,lo8(100)
	call __udivmodqi4
	subi r24,lo8(-(48))
	st Z,r24
	mov r28,r25
.L28:
	cpi r28,lo8(10)
	brlo .L29
	mov r24,r28
	ldi r22,lo8(10)
	call __udivmodqi4
	subi r24,lo8(-(48))
	std Z+1,r24
	mov r28,r25
.L30:
	subi r28,lo8(-(48))
	std Z+2,r28
	std Z+3,__zero_reg__
	movw r24,r30
/* epilogue start */
	pop r28
	ret
.L27:
	ldi r24,lo8(32)
	st Z,r24
	rjmp .L28
.L29:
	ldi r24,lo8(32)
	std Z+1,r24
	rjmp .L30
	.size	to_string_uint8, .-to_string_uint8
.global	uart_print_uint8
	.type	uart_print_uint8, @function
uart_print_uint8:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call to_string_uint8
	jmp uart_put
	.size	uart_print_uint8, .-uart_print_uint8
.global	to_string_uint16
	.type	to_string_uint16, @function
to_string_uint16:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r24
	ldi r24,lo8(15)
	ldi r25,0
	call malloc
	movw r30,r24
	cpi r28,16
	ldi r24,39
	cpc r29,r24
	brlo .L33
	movw r24,r28
	ldi r22,lo8(16)
	ldi r23,lo8(39)
	call __udivmodhi4
	subi r22,lo8(-(48))
	st Z,r22
	movw r28,r24
.L34:
	cpi r28,-24
	ldi r24,3
	cpc r29,r24
	brlo .L35
	movw r24,r28
	ldi r22,lo8(-24)
	ldi r23,lo8(3)
	call __udivmodhi4
	subi r22,lo8(-(48))
	std Z+1,r22
	movw r28,r24
.L36:
	cpi r28,100
	cpc r29,__zero_reg__
	brlo .L37
	movw r24,r28
	ldi r22,lo8(100)
	ldi r23,0
	call __udivmodhi4
	subi r22,lo8(-(48))
	std Z+2,r22
	movw r28,r24
.L38:
	cpi r28,10
	cpc r29,__zero_reg__
	brlo .L39
	movw r24,r28
	ldi r22,lo8(10)
	ldi r23,0
	call __udivmodhi4
	subi r22,lo8(-(48))
	std Z+3,r22
	movw r28,r24
.L40:
	subi r28,lo8(-(48))
	std Z+4,r28
	std Z+5,__zero_reg__
	movw r24,r30
/* epilogue start */
	pop r29
	pop r28
	ret
.L33:
	ldi r24,lo8(32)
	st Z,r24
	rjmp .L34
.L35:
	ldi r24,lo8(32)
	std Z+1,r24
	rjmp .L36
.L37:
	ldi r24,lo8(32)
	std Z+2,r24
	rjmp .L38
.L39:
	ldi r24,lo8(32)
	std Z+3,r24
	rjmp .L40
	.size	to_string_uint16, .-to_string_uint16
.global	uart_print_uint16
	.type	uart_print_uint16, @function
uart_print_uint16:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call to_string_uint16
	jmp uart_put
	.size	uart_print_uint16, .-uart_print_uint16
.global	rxcflag
	.section .bss
	.type	rxcflag, @object
	.size	rxcflag, 1
rxcflag:
	.zero	1
	.data
	.type	txcflag, @object
	.size	txcflag, 1
txcflag:
	.byte	1
	.local	wrind
	.comm	wrind,1,1
	.local	wrbuff
	.comm	wrbuff,64,1
	.ident	"GCC: (GNU) 8.2.0"
.global __do_copy_data
.global __do_clear_bss
