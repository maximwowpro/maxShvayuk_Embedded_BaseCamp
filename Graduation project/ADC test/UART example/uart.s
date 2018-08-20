	.file	"uart.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	__vector_18
	.type	__vector_18, @function
__vector_18:
	__gcc_isr 1
	push r25
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 3...7 */
.L__stack_usage = 3 + __gcc_isr.n_pushed
	lds r24,rdind
	mov r30,r24
	ldi r31,0
	lds r25,198
	subi r30,lo8(-(rdbuff))
	sbci r31,hi8(-(rdbuff))
	st Z,r25
	cpi r25,lo8(10)
	brne .L2
	st Z,__zero_reg__
	ldi r24,lo8(1)
	sts rxcflag,r24
.L4:
	sts rdind,__zero_reg__
	rjmp .L1
.L2:
	sts rxcflag,__zero_reg__
	subi r24,lo8(-(1))
	cpi r24,lo8(64)
	brsh .L4
	sts rdind,r24
.L1:
/* epilogue start */
	pop r31
	pop r30
	pop r25
	__gcc_isr 2
	reti
	__gcc_isr 0,r24
	.size	__vector_18, .-__vector_18
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
	breq .L7
	lds r18,txcflag
	tst r18
	breq .L8
.L7:
	lds r24,193
	andi r24,lo8(-33)
	sts 193,r24
	ldi r24,lo8(1)
	sts txcflag,r24
.L6:
/* epilogue start */
	pop r31
	pop r30
	pop r25
	pop r24
	__gcc_isr 2
	reti
.L8:
	subi r24,lo8(-(1))
	sts wrind,r24
	sts 198,r25
	lds r24,wrind
	cpi r24,lo8(64)
	brlo .L6
	sts wrind,__zero_reg__
	rjmp .L6
	__gcc_isr 0,r18
	.size	__vector_19, .-__vector_19
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0x4
	ori r24,lo8(3)
	out 0x4,r24
	sbi 0x5,0
	call uart_init
	ldi r25,0
	ldi r24,0
/* epilogue start */
	ret
	.size	main, .-main
.global	rxcflag
	.section .bss
	.type	rxcflag, @object
	.size	rxcflag, 1
rxcflag:
	.zero	1
.global	txcflag
	.data
	.type	txcflag, @object
	.size	txcflag, 1
txcflag:
	.byte	1
.global	wrind
	.section .bss
	.type	wrind, @object
	.size	wrind, 1
wrind:
	.zero	1
.global	rdind
	.type	rdind, @object
	.size	rdind, 1
rdind:
	.zero	1
.global	wrbuff
	.type	wrbuff, @object
	.size	wrbuff, 64
wrbuff:
	.zero	64
.global	rdbuff
	.type	rdbuff, @object
	.size	rdbuff, 64
rdbuff:
	.zero	64
.global	ubrr_val
	.section	.rodata
	.type	ubrr_val, @object
	.size	ubrr_val, 2
ubrr_val:
	.word	51
.global	uart_baudrate
	.type	uart_baudrate, @object
	.size	uart_baudrate, 4
uart_baudrate:
	.byte	0
	.byte	75
	.byte	0
	.byte	0
	.ident	"GCC: (GNU) 8.2.0"
.global __do_copy_data
.global __do_clear_bss
