	.file	"main.c"
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
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 0...4 */
.L__stack_usage = 0 + __gcc_isr.n_pushed
	lds r24,198
	cpi r24,lo8(10)
	brne .L2
	ldi r24,lo8(1)
	sts rxcflag,r24
.L4:
	sts rdind,__zero_reg__
	rjmp .L1
.L2:
	lds r24,rdind
	sts rxcflag,__zero_reg__
	subi r24,lo8(-(1))
	cpi r24,lo8(64)
	brsh .L4
	sts rdind,r24
.L1:
/* epilogue start */
	__gcc_isr 2
	reti
	__gcc_isr 0,r24
	.size	__vector_18, .-__vector_18
.global	ADC_Init
	.type	ADC_Init, @function
ADC_Init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r30,lo8(122)
	ldi r31,0
	ld r24,Z
	ori r24,lo8(-125)
	st Z,r24
	ldi r30,lo8(124)
	ldi r31,0
	ld r24,Z
	ori r24,lo8(64)
	st Z,r24
/* epilogue start */
	ret
	.size	ADC_Init, .-ADC_Init
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"\n\nHello from avr\n\n"
.LC1:
	.string	"\n"
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call ADC_Init
	ldi r24,lo8(32)
	out 0x4,r24
	out 0x5,__zero_reg__
	in r24,0x4
	ori r24,lo8(3)
	out 0x4,r24
	sbi 0x5,0
	call uart_init
	in r24,0x33
	andi r24,lo8(-15)
	out 0x33,r24
	in r24,0x33
	ori r24,lo8(1)
	out 0x33,r24
/* #APP */
 ;  54 "main.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
.L13:
	call uart_put
.L7:
	lds r24,122
	ori r24,lo8(64)
	sts 122,r24
	lds r24,122
	sbrs r24,4
	rjmp .L7
	lds r24,120
	lds r25,121
	cpi r24,-23
	ldi r18,3
	cpc r25,r18
	brlo .L8
	sbi 0x5,5
.L9:
	ldi r23,0
	ldi r22,0
	call to_string_uint16
	call uart_put
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	rjmp .L13
.L8:
	cbi 0x5,5
	rjmp .L9
	.size	main, .-main
	.data
	.type	txcflag, @object
	.size	txcflag, 1
txcflag:
	.byte	1
	.local	rdind
	.comm	rdind,1,1
	.ident	"GCC: (GNU) 8.2.0"
.global __do_copy_data
.global __do_clear_bss
