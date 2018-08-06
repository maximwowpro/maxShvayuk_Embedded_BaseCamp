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
.global	uart_print_uint16_hex
	.type	uart_print_uint16_hex, @function
uart_print_uint16_hex:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r25,0
	ldi r24,0
	jmp uart_put
	.size	uart_print_uint16_hex, .-uart_print_uint16_hex
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
.L23:
	ld r25,Z+
	ld r19,X+
	cpse r25,r19
	rjmp .L24
	tst r25
	breq .L25
	cpse r24,r30
	rjmp .L23
.L25:
	ldi r24,lo8(1)
	rjmp .L22
.L24:
	ldi r24,0
.L22:
	out __SREG__,r18
/* epilogue start */
	ret
	.size	atomic_str_eq, .-atomic_str_eq
.global	to_string_uint8_dec
	.type	to_string_uint8_dec, @function
to_string_uint8_dec:
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
	brlo .L28
	mov r24,r28
	ldi r22,lo8(100)
	call __udivmodqi4
	subi r24,lo8(-(48))
	st Z,r24
	mov r28,r25
.L29:
	cpi r28,lo8(10)
	brlo .L30
	mov r24,r28
	ldi r22,lo8(10)
	call __udivmodqi4
	subi r24,lo8(-(48))
	std Z+1,r24
	mov r28,r25
.L31:
	subi r28,lo8(-(48))
	std Z+2,r28
	std Z+3,__zero_reg__
	movw r24,r30
/* epilogue start */
	pop r28
	ret
.L28:
	ldi r24,lo8(32)
	st Z,r24
	rjmp .L29
.L30:
	ldi r24,lo8(32)
	std Z+1,r24
	rjmp .L31
	.size	to_string_uint8_dec, .-to_string_uint8_dec
.global	uart_print_uint8_dec
	.type	uart_print_uint8_dec, @function
uart_print_uint8_dec:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call to_string_uint8_dec
	jmp uart_put
	.size	uart_print_uint8_dec, .-uart_print_uint8_dec
.global	to_string_uint16_dec
	.type	to_string_uint16_dec, @function
to_string_uint16_dec:
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
	brlo .L34
	movw r24,r28
	ldi r22,lo8(16)
	ldi r23,lo8(39)
	call __udivmodhi4
	subi r22,lo8(-(48))
	st Z,r22
	movw r28,r24
.L35:
	cpi r28,-24
	ldi r24,3
	cpc r29,r24
	brlo .L36
	movw r24,r28
	ldi r22,lo8(-24)
	ldi r23,lo8(3)
	call __udivmodhi4
	subi r22,lo8(-(48))
	std Z+1,r22
	movw r28,r24
.L37:
	cpi r28,100
	cpc r29,__zero_reg__
	brlo .L38
	movw r24,r28
	ldi r22,lo8(100)
	ldi r23,0
	call __udivmodhi4
	subi r22,lo8(-(48))
	std Z+2,r22
	movw r28,r24
.L39:
	cpi r28,10
	cpc r29,__zero_reg__
	brlo .L40
	movw r24,r28
	ldi r22,lo8(10)
	ldi r23,0
	call __udivmodhi4
	subi r22,lo8(-(48))
	std Z+3,r22
	movw r28,r24
.L41:
	subi r28,lo8(-(48))
	std Z+4,r28
	std Z+5,__zero_reg__
	movw r24,r30
/* epilogue start */
	pop r29
	pop r28
	ret
.L34:
	ldi r24,lo8(32)
	st Z,r24
	rjmp .L35
.L36:
	ldi r24,lo8(32)
	std Z+1,r24
	rjmp .L37
.L38:
	ldi r24,lo8(32)
	std Z+2,r24
	rjmp .L39
.L40:
	ldi r24,lo8(32)
	std Z+3,r24
	rjmp .L41
	.size	to_string_uint16_dec, .-to_string_uint16_dec
.global	uart_print_uint16_dec
	.type	uart_print_uint16_dec, @function
uart_print_uint16_dec:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call to_string_uint16_dec
	jmp uart_put
	.size	uart_print_uint16_dec, .-uart_print_uint16_dec
	.section	.rodata
.LC0:
	.byte	48
	.byte	49
	.byte	50
	.byte	51
	.byte	52
	.byte	53
	.byte	54
	.byte	55
	.byte	56
	.byte	57
	.byte	65
	.byte	66
	.byte	67
	.byte	68
	.byte	69
	.byte	70
	.text
.global	to_string_uint8_hex
	.type	to_string_uint8_hex, @function
to_string_uint8_hex:
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,16
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 16 */
/* stack size = 19 */
.L__stack_usage = 19
	mov r17,r24
	ldi r24,lo8(3)
	ldi r25,0
	call malloc
	ldi r18,lo8(16)
	ldi r30,lo8(.LC0)
	ldi r31,hi8(.LC0)
	movw r26,r28
	adiw r26,1
	0:
	ld r0,Z+
	st X+,r0
	dec r18
	brne 0b
	cpi r17,lo8(16)
	brlo .L44
	mov r30,r17
	swap r30
	andi r30,lo8(15)
	ldi r18,lo8(1)
	ldi r19,0
	add r18,r28
	adc r19,r29
	add r18,r30
	adc r19,__zero_reg__
	movw r30,r18
	ld r18,Z
	movw r30,r24
	st Z,r18
	andi r17,lo8(15)
.L45:
	ldi r30,lo8(1)
	ldi r31,0
	add r30,r28
	adc r31,r29
	add r30,r17
	adc r31,__zero_reg__
	ld r18,Z
	movw r30,r24
	std Z+1,r18
	std Z+2,__zero_reg__
/* epilogue start */
	adiw r28,16
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	ret
.L44:
	ldi r18,lo8(48)
	movw r30,r24
	st Z,r18
	rjmp .L45
	.size	to_string_uint8_hex, .-to_string_uint8_hex
.global	uart_print_uint8_hex
	.type	uart_print_uint8_hex, @function
uart_print_uint8_hex:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	call to_string_uint8_hex
	jmp uart_put
	.size	uart_print_uint8_hex, .-uart_print_uint8_hex
.global	to_string_uint16_hex
	.type	to_string_uint16_hex, @function
to_string_uint16_hex:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
/* epilogue start */
	ret
	.size	to_string_uint16_hex, .-to_string_uint16_hex
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"\nFamily = "
.LC2:
	.string	"  id = "
.LC3:
	.string	"  CRC = "
	.text
.global	uart_print_1wire_id_dec
	.type	uart_print_1wire_id_dec, @function
uart_print_1wire_id_dec:
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 6 */
.L__stack_usage = 6
	movw r16,r24
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	call uart_put
	ldi r23,0
	ldi r22,0
	movw r28,r16
	ld r24,Y+
	call uart_print_uint8_dec
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
	call uart_put
	movw r14,r16
	ldi r24,7
	add r14,r24
	adc r15,__zero_reg__
.L49:
	ldi r23,0
	ldi r22,0
	ld r24,Y+
	call uart_print_uint8_dec
	cp r28,r14
	cpc r29,r15
	brne .L49
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
	call uart_put
	ldi r23,0
	ldi r22,0
	movw r30,r16
	ldd r24,Z+7
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	jmp uart_print_uint8_dec
	.size	uart_print_1wire_id_dec, .-uart_print_1wire_id_dec
	.section	.rodata.str1.1
.LC4:
	.string	"Family = "
	.text
.global	uart_print_1wire_id_hex
	.type	uart_print_1wire_id_hex, @function
uart_print_1wire_id_hex:
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 6 */
.L__stack_usage = 6
	movw r16,r24
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	call uart_put
	ldi r23,0
	ldi r22,0
	movw r28,r16
	ld r24,Y+
	call uart_print_uint8_hex
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
	call uart_put
	movw r14,r16
	ldi r24,7
	add r14,r24
	adc r15,__zero_reg__
.L52:
	ldi r23,0
	ldi r22,0
	ld r24,Y+
	call uart_print_uint8_hex
	cp r28,r14
	cpc r29,r15
	brne .L52
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
	call uart_put
	ldi r23,0
	ldi r22,0
	movw r30,r16
	ldd r24,Z+7
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	jmp uart_print_uint8_hex
	.size	uart_print_1wire_id_hex, .-uart_print_1wire_id_hex
	.local	rxcflag
	.comm	rxcflag,1,1
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
