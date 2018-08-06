	.file	"lock.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	soft_delay
	.type	soft_delay, @function
soft_delay:
	push r28
	push r29
	rcall .
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 3 */
/* stack size = 5 */
.L__stack_usage = 5
	std Y+3,r25
	std Y+2,r24
	ldi r24,lo8(-1)
	std Y+1,r24
.L2:
	ldd r24,Y+2
	ldd r25,Y+3
	movw r18,r24
	subi r18,1
	sbc r19,__zero_reg__
	std Y+3,r19
	std Y+2,r18
	or r24,r25
	brne .L3
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
.L3:
	ldd r24,Y+1
	ldi r25,lo8(-1)
	add r25,r24
	std Y+1,r25
	cpse r24,__zero_reg__
	rjmp .L3
	rjmp .L2
	.size	soft_delay, .-soft_delay
.global	lock_init
	.type	lock_init, @function
lock_init:
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 8 */
.L__stack_usage = 8
	movw r28,r24
	std Y+13,r23
	std Y+12,r22
	std Y+15,r21
	std Y+14,r20
	std Y+17,r19
	std Y+16,r18
	std Y+19,r17
	std Y+18,r16
	std Y+21,r15
	std Y+20,r14
	std Y+23,r13
	std Y+22,r12
	ldi r25,0
	ldi r24,0
	call eeprom_read_byte
	std Y+24,r24
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	ret
	.size	lock_init, .-lock_init
.global	lock_lock_func_LED
	.type	lock_lock_func_LED, @function
lock_lock_func_LED:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp led_RGB_red
	.size	lock_lock_func_LED, .-lock_lock_func_LED
.global	lock_wait_func_LED
	.type	lock_wait_func_LED, @function
lock_wait_func_LED:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp led_RGB_blue
	.size	lock_wait_func_LED, .-lock_wait_func_LED
.global	lock_unlock_func_LED
	.type	lock_unlock_func_LED, @function
lock_unlock_func_LED:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	jmp led_RGB_green
	.size	lock_unlock_func_LED, .-lock_unlock_func_LED
.global	lock_eeprom_write_byte
	.type	lock_eeprom_write_byte, @function
lock_eeprom_write_byte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r18,r24
	in r25,__SREG__
/* #APP */
 ;  50 "/usr/avr/include/util/atomic.h" 1
	cli
 ;  0 "" 2
/* #NOAPP */
.L11:
	sbic 0x1f,1
	rjmp .L11
	out 0x21+1,r19
	out 0x21,r18
	out 0x20,r22
	sbi 0x1f,2
	sbi 0x1f,1
	out __SREG__,r25
/* epilogue start */
	ret
	.size	lock_eeprom_write_byte, .-lock_eeprom_write_byte
.global	lock_eeprom_write_key
	.type	lock_eeprom_write_key, @function
lock_eeprom_write_key:
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 10 */
.L__stack_usage = 10
	movw r12,r24
	movw r30,r24
	ldd r28,Z+24
	ldi r31,lo8(8)
	mul r28,r31
	movw r28,r0
	clr __zero_reg__
	movw r18,r28
	subi r18,-1
	sbci r19,-1
	movw r24,r28
	adiw r24,9
	cp r24,r18
	cpc r25,r19
	brsh .L14
	clr r10
	inc r10
	mov r11,__zero_reg__
.L15:
	movw r14,r22
	ldi r16,lo8(1)
	ldi r17,0
.L16:
	movw r24,r28
	add r24,r16
	adc r25,r17
	cp r10,r16
	cpc r11,r17
	brne .L17
	movw r30,r12
	ldd r22,Z+24
	subi r22,lo8(-(1))
	std Z+24,r22
	ldi r25,0
	ldi r24,0
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	jmp eeprom_write_byte
.L14:
	ldi r24,lo8(9)
	mov r10,r24
	mov r11,__zero_reg__
	rjmp .L15
.L17:
	movw r30,r14
	ld r22,Z+
	movw r14,r30
	call lock_eeprom_write_byte
	subi r16,-1
	sbci r17,-1
	rjmp .L16
	.size	lock_eeprom_write_key, .-lock_eeprom_write_key
.global	lock_eeprom_read_byte
	.type	lock_eeprom_read_byte, @function
lock_eeprom_read_byte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
.L19:
	sbic 0x1f,1
	rjmp .L19
	out 0x21+1,r25
	out 0x21,r24
	sbi 0x1f,0
	in r24,0x20
/* epilogue start */
	ret
	.size	lock_eeprom_read_byte, .-lock_eeprom_read_byte
.global	lock_eeprom_read_key
	.type	lock_eeprom_read_key, @function
lock_eeprom_read_key:
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 10 */
.L__stack_usage = 10
	mov r28,r22
	movw r16,r20
	cpse r22,__zero_reg__
	rjmp .L22
.L24:
	ldi r17,0
	ldi r16,0
.L23:
	movw r24,r16
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	ret
.L22:
	movw r30,r24
	ldd r24,Z+24
	cp r24,r22
	brlo .L24
	or r20,r21
	brne .L25
	ldi r24,lo8(8)
	ldi r25,0
	call malloc
	movw r16,r24
	or r24,r25
	breq .L24
.L25:
	subi r28,1
	sbc r29,r29
	ldi r19,3
	1:
	lsl r28
	rol r29
	dec r19
	brne 1b
	movw r18,r28
	subi r18,-1
	sbci r19,-1
	movw r24,r28
	adiw r24,9
	cp r24,r18
	cpc r25,r19
	brsh .L26
	clr r12
	inc r12
	mov r13,__zero_reg__
.L27:
	movw r10,r16
	clr r14
	inc r14
	mov r15,__zero_reg__
.L28:
	movw r24,r28
	add r24,r14
	adc r25,r15
	cp r12,r14
	cpc r13,r15
	breq .L23
	call lock_eeprom_read_byte
	movw r30,r10
	st Z+,r24
	movw r10,r30
	ldi r31,-1
	sub r14,r31
	sbc r15,r31
	rjmp .L28
.L26:
	ldi r25,lo8(9)
	mov r12,r25
	mov r13,__zero_reg__
	rjmp .L27
	.size	lock_eeprom_read_key, .-lock_eeprom_read_key
.global	lock_search_key
	.type	lock_search_key, @function
lock_search_key:
	push r6
	push r7
	push r8
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 14 */
.L__stack_usage = 14
	movw r12,r24
	movw r14,r22
	mov r7,r20
	ldi r29,0
	ldi r28,0
.L34:
	movw r30,r12
	ldd r24,Z+24
	cp r29,r24
	brlo .L39
	ldi r24,0
.L33:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	pop r7
	pop r6
	ret
.L39:
	ldi r24,lo8(8)
	mul r29,r24
	movw r8,r0
	clr __zero_reg__
	movw r16,r14
	add r16,r28
	adc r17,__zero_reg__
	movw r10,r8
	sub r10,r14
	sbc r11,r15
.L35:
	cpi r28,lo8(7)
	brlo .L37
	movw r24,r8
	adiw r24,8
	call lock_eeprom_read_byte
	cpse r24,r7
	rjmp .L36
	ldi r24,lo8(1)
	rjmp .L33
.L37:
	movw r30,r16
	ld r6,Z+
	movw r16,r30
	movw r24,r10
	add r24,r30
	adc r25,r31
	call lock_eeprom_read_byte
	cpse r6,r24
	rjmp .L41
	subi r28,lo8(-(1))
	rjmp .L35
.L41:
	ldi r28,0
.L36:
	subi r29,lo8(-(1))
	rjmp .L34
	.size	lock_search_key, .-lock_search_key
.global	__vector_9
	.type	__vector_9, @function
__vector_9:
	__gcc_isr 1
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 2...6 */
.L__stack_usage = 2 + __gcc_isr.n_pushed
	ldi r30,lo8(-79)
	ldi r31,0
	ld r24,Z
	andi r24,lo8(-8)
	st Z,r24
/* epilogue start */
	pop r31
	pop r30
	__gcc_isr 2
	reti
	__gcc_isr 0,r24
	.size	__vector_9, .-__vector_9
.global	sleep_ms
	.type	sleep_ms, @function
sleep_ms:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r18,0x33
	andi r18,lo8(-15)
	out 0x33,r18
/* #APP */
 ;  262 "lock.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	in r18,0x33
	ori r18,lo8(1)
	out 0x33,r18
/* #APP */
 ;  264 "lock.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	lds r18,112
	ori r18,lo8(1)
	sts 112,r18
	ldi r18,lo8(-126)
	ldi r19,lo8(5)
.L46:
	sbiw r24,1
	brcc .L47
	in r24,0x33
	andi r24,lo8(-2)
	out 0x33,r24
/* epilogue start */
	ret
.L47:
	sts 178,r18
	sts 177,r19
/* #APP */
 ;  273 "lock.c" 1
	sleep
	
 ;  0 "" 2
/* #NOAPP */
	rjmp .L46
	.size	sleep_ms, .-sleep_ms
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"\nYou added new key: "
	.text
.global	lock_add_key_by_button
	.type	lock_add_key_by_button, @function
lock_add_key_by_button:
	push r12
	push r13
	push r14
	push r15
	push r16
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,9
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 9 */
/* stack size = 16 */
.L__stack_usage = 16
	movw r14,r24
	movw r12,r22
	lds r24,key_add_flag
	tst r24
	breq .L48
	ldi r16,0
	ldi r18,lo8(1)
	movw r20,r28
	subi r20,-9
	sbci r21,-1
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	movw r24,r14
	call __ow_cmd_readrom
	cpse r24,__zero_reg__
	rjmp .L48
	ldd r24,Y+9
	std Y+8,r24
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	movw r24,r14
	call lock_eeprom_write_key
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	call uart_put
	movw r24,r28
	adiw r24,1
	call uart_print_1wire_id_hex
	sts key_add_flag,__zero_reg__
	movw r26,r14
	adiw r26,12
	ld r30,X+
	ld r31,X
	movw r24,r12
	icall
	ldi r24,lo8(-24)
	ldi r25,lo8(3)
	call sleep_ms
.L48:
/* epilogue start */
	adiw r28,9
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	ret
	.size	lock_add_key_by_button, .-lock_add_key_by_button
	.section	.rodata.str1.1
.LC1:
	.string	"\nlock_try_unlock_LED:  "
.LC2:
	.string	"\nCRC = "
.LC3:
	.string	"\nUnlocking success!\n"
.LC4:
	.string	"\nUnlocking failed! Your devise isn't suitable key\n"
	.text
.global	lock_try_unlock_LED
	.type	lock_try_unlock_LED, @function
lock_try_unlock_LED:
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 11 */
.L__stack_usage = 11
	movw r28,r24
	movw r12,r22
	mov r15,r20
	mov r17,r21
	movw r10,r18
	mov r9,r16
	mov r16,r14
	ldd r30,Y+14
	ldd r31,Y+15
	movw r24,r22
	icall
	mov r18,r9
	movw r20,r10
	mov r22,r15
	mov r23,r17
	movw r24,r28
	call __ow_cmd_readrom
	cpse r24,__zero_reg__
	rjmp .L54
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	call uart_put
	mov r24,r15
	mov r25,r17
	call uart_print_1wire_id_hex
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
	call uart_put
	ldi r23,0
	ldi r22,0
	movw r30,r10
	ld r24,Z
	call uart_print_uint8_hex
	movw r30,r10
	ld r20,Z
	mov r22,r15
	mov r23,r17
	movw r24,r28
	call lock_search_key
	tst r24
	breq .L56
	ldd r30,Y+16
	ldd r31,Y+17
	movw r24,r12
	icall
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
	call uart_put
	ldi r24,lo8(-48)
	ldi r25,lo8(7)
	call sleep_ms
	mov r30,r15
	mov r31,r17
	movw r24,r30
	adiw r24,8
.L57:
	st Z+,__zero_reg__
	cp r30,r24
	cpc r31,r25
	brne .L57
.L59:
	ldd r30,Y+14
	ldd r31,Y+15
	movw r24,r12
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	ijmp
.L56:
	ldd r30,Y+12
	ldd r31,Y+13
	movw r24,r12
	icall
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	call uart_put
	ldi r24,lo8(-24)
	ldi r25,lo8(3)
	call sleep_ms
	rjmp .L59
.L54:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	ret
	.size	lock_try_unlock_LED, .-lock_try_unlock_LED
	.section	.rodata.str1.1
.LC5:
	.string	"\nPlease, add new key:\n"
	.text
.global	__vector_1
	.type	__vector_1, @function
__vector_1:
	push r1
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 15 */
.L__stack_usage = 15
	sbis 0x9,2
	rjmp .L60
	ldi r24,lo8(30)
	ldi r25,0
	call soft_delay
	sbis 0x9,2
	rjmp .L60
	ldi r24,lo8(1)
	sts key_add_flag,r24
	ldi r24,lo8(.LC5)
	ldi r25,hi8(.LC5)
	call uart_put
.L60:
/* epilogue start */
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
	.size	__vector_1, .-__vector_1
.global	lock_interrupt_INT0_init
	.type	lock_interrupt_INT0_init, @function
lock_interrupt_INT0_init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cbi 0xa,2
	cbi 0xb,2
	ldi r30,lo8(105)
	ldi r31,0
	ld r24,Z
	andi r24,lo8(-3)
	st Z,r24
	ld r24,Z
	ori r24,lo8(1)
	st Z,r24
	sbi 0x1d,0
/* #APP */
 ;  305 "lock.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
/* epilogue start */
	ret
	.size	lock_interrupt_INT0_init, .-lock_interrupt_INT0_init
	.local	key_add_flag
	.comm	key_add_flag,1,1
	.local	rxcflag
	.comm	rxcflag,1,1
	.data
	.type	txcflag, @object
	.size	txcflag, 1
txcflag:
	.byte	1
	.ident	"GCC: (GNU) 8.2.0"
.global __do_copy_data
.global __do_clear_bss
