	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	line_low
	.type	line_low, @function
line_low:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cbi 0x5,0
	sbi 0x4,0
/* epilogue start */
	ret
	.size	line_low, .-line_low
.global	line_release
	.type	line_release, @function
line_release:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cbi 0x4,0
	sbi 0x5,0
/* epilogue start */
	ret
	.size	line_release, .-line_release
.global	line_read
	.type	line_read, @function
line_read:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0x3
	andi r24,lo8(1)
/* epilogue start */
	ret
	.size	line_read, .-line_read
.global	soft_delay_us
	.type	soft_delay_us, @function
soft_delay_us:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
.L5:
	sbiw r24,1
	brcc .L6
/* epilogue start */
	ret
.L6:
	ldi r18,lo8(5)
1:	dec r18
	brne 1b
	nop
	rjmp .L5
	.size	soft_delay_us, .-soft_delay_us
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
	brne .L8
	ldi r24,lo8(1)
	sts rxcflag,r24
.L10:
	sts rdind,__zero_reg__
	rjmp .L7
.L8:
	lds r24,rdind
	sts rxcflag,__zero_reg__
	subi r24,lo8(-(1))
	cpi r24,lo8(64)
	brsh .L10
	sts rdind,r24
.L7:
/* epilogue start */
	__gcc_isr 2
	reti
	__gcc_isr 0,r24
	.size	__vector_18, .-__vector_18
.global	put
	.type	put, @function
put:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	mov r16,r24
	sbi 0x5,3
	ldi r24,lo8(20)
	ldi r25,0
	call soft_delay_us
	cbi 0x5,3
	ldi r29,0
	ldi r28,0
	ldi r17,0
.L14:
	movw r24,r16
	mov r0,r28
	rjmp 2f
	1:
	asr r25
	ror r24
	2:
	dec r0
	brpl 1b
	sbrs r24,0
	rjmp .L12
	sbi 0x5,3
.L13:
	ldi r24,lo8(20)
	ldi r25,0
	call soft_delay_us
	adiw r28,1
	cpi r28,8
	cpc r29,__zero_reg__
	brne .L14
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L12:
	cbi 0x5,3
	rjmp .L13
	.size	put, .-put
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"\n\nHello from avr_lock\n\n"
.LC3:
	.string	"\n\nclear EEPROM:\n"
.LC4:
	.string	"\n\nparse EEPROM0:\n"
.LC5:
	.string	" "
.LC6:
	.string	"\ntest EEPROM1 = "
.LC7:
	.string	"\nnum keys1 = "
.LC8:
	.string	"\n\nparse EEPROM1:\n"
.LC9:
	.string	"\n\nparse EEPROM2:\n"
	.section	.rodata
.LC1:
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,54
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 54 */
/* stack size = 54 */
.L__stack_usage = 54
	mov r13,__zero_reg__
	mov r12,__zero_reg__
	ldi r24,lo8(3)
	mov r14,r24
	ldi r16,lo8(2)
	ldi r18,lo8(1)
	ldi r20,lo8(36)
	ldi r21,0
	ldi r22,lo8(37)
	ldi r23,0
	movw r24,r28
	adiw r24,26
	call led_RGB_init
	in r12,0x9
	in r14,0xb
	in r16,0xa
	mov r13,__zero_reg__
	mov r15,__zero_reg__
	ldi r17,0
	ldi r18,lo8(gs(lock_unlock_func_LED))
	ldi r19,hi8(gs(lock_unlock_func_LED))
	ldi r20,lo8(gs(lock_wait_func_LED))
	ldi r21,hi8(gs(lock_wait_func_LED))
	ldi r22,lo8(gs(lock_lock_func_LED))
	ldi r23,hi8(gs(lock_lock_func_LED))
	movw r24,r28
	adiw r24,1
	call lock_init
	ldi r25,lo8(5)
	mov r8,r25
	ldi r18,lo8(60)
	mov r10,r18
	ldi r19,lo8(60)
	mov r12,r19
	mov r13,__zero_reg__
	ldi r20,lo8(5)
	mov r14,r20
	ldi r16,lo8(gs(soft_delay_us))
	ldi r17,hi8(gs(soft_delay_us))
	ldi r18,lo8(gs(line_read))
	ldi r19,hi8(gs(line_read))
	ldi r20,lo8(gs(line_release))
	ldi r21,hi8(gs(line_release))
	ldi r22,lo8(gs(line_low))
	ldi r23,hi8(gs(line_low))
	movw r24,r28
	adiw r24,1
	call __ow_Pin_init
	call lock_interrupt_INT0_init
	call uart_init
	in r24,0x33
	andi r24,lo8(-15)
	out 0x33,r24
	in r24,0x33
	ori r24,lo8(1)
	out 0x33,r24
/* #APP */
 ;  95 "main.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
	call uart_put
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
	call uart_put
	ldi r17,0
	ldi r16,0
.L17:
	ldi r22,lo8(-1)
	movw r24,r16
	call lock_eeprom_write_byte
	subi r16,-1
	sbci r17,-1
	cpi r16,24
	cpc r17,__zero_reg__
	brne .L17
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	call uart_put
	ldi r17,0
	ldi r16,0
.L18:
	movw r24,r16
	call lock_eeprom_read_byte
	ldi r23,0
	ldi r22,0
	call uart_print_uint8_hex
	ldi r24,lo8(.LC5)
	ldi r25,hi8(.LC5)
	call uart_put
	subi r16,-1
	sbci r17,-1
	cpi r16,24
	cpc r17,__zero_reg__
	brne .L18
	std Y+25,__zero_reg__
	ldi r24,lo8(8)
	ldi r25,0
	call malloc
	movw r16,r24
	ldi r24,lo8(8)
	ldi r30,lo8(.LC1)
	ldi r31,hi8(.LC1)
	movw r26,r28
	adiw r26,38
	0:
	ld r0,Z+
	st X+,r0
	dec r24
	brne 0b
	movw r22,r28
	subi r22,-38
	sbci r23,-1
	movw r24,r28
	adiw r24,1
	call lock_eeprom_write_key
	movw r20,r16
	ldi r22,lo8(1)
	movw r24,r28
	adiw r24,1
	call lock_eeprom_read_key
	movw r16,r24
	ldi r24,lo8(.LC6)
	ldi r25,hi8(.LC6)
	call uart_put
	movw r24,r16
	call uart_print_1wire_id_hex
	ldi r24,lo8(.LC7)
	ldi r25,hi8(.LC7)
	call uart_put
	ldi r23,0
	ldi r22,0
	ldd r24,Y+25
	call uart_print_uint8_dec
	ldi r24,lo8(.LC8)
	ldi r25,hi8(.LC8)
	call uart_put
	ldi r17,0
	ldi r16,0
.L19:
	movw r24,r16
	call lock_eeprom_read_byte
	ldi r23,0
	ldi r22,0
	call uart_print_uint8_hex
	ldi r24,lo8(.LC5)
	ldi r25,hi8(.LC5)
	call uart_put
	subi r16,-1
	sbci r17,-1
	cpi r16,24
	cpc r17,__zero_reg__
	brne .L19
	ldi r24,lo8(.LC9)
	ldi r25,hi8(.LC9)
	call uart_put
	ldi r17,0
	ldi r16,0
.L20:
	movw r24,r16
	call lock_eeprom_read_byte
	ldi r23,0
	ldi r22,0
	call uart_print_uint8_hex
	ldi r24,lo8(.LC5)
	ldi r25,hi8(.LC5)
	call uart_put
	subi r16,-1
	sbci r17,-1
	cpi r16,24
	cpc r17,__zero_reg__
	brne .L20
.L21:
	movw r22,r28
	subi r22,-26
	sbci r23,-1
	movw r24,r28
	adiw r24,1
	call lock_add_key_by_button
	mov r14,__zero_reg__
	ldi r16,lo8(1)
	movw r18,r28
	subi r18,-54
	sbci r19,-1
	movw r20,r28
	subi r20,-46
	sbci r21,-1
	movw r22,r28
	subi r22,-26
	sbci r23,-1
	movw r24,r28
	adiw r24,1
	call lock_try_unlock_LED
	rjmp .L21
	.size	main, .-main
	.local	rxcflag
	.comm	rxcflag,1,1
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
