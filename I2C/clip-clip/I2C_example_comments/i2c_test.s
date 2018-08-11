	.file	"i2c_test.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	empty_callback
	.type	empty_callback, @function
empty_callback:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts busyflag,__zero_reg__
/* epilogue start */
	ret
	.size	empty_callback, .-empty_callback
	.type	soft_delay.constprop.0, @function
soft_delay.constprop.0:
	push r28
	push r29
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 3 */
.L__stack_usage = 3
	ldi r24,lo8(-24)
	ldi r25,lo8(3)
	ldi r18,lo8(-1)
	std Y+1,r18
.L3:
	movw r18,r24
	sbiw r24,1
	or r18,r19
	brne .L4
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	ret
.L4:
	ldd r18,Y+1
	ldi r19,lo8(-1)
	add r19,r18
	std Y+1,r19
	cpse r18,__zero_reg__
	rjmp .L4
	rjmp .L3
	.size	soft_delay.constprop.0, .-soft_delay.constprop.0
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
/* #APP */
 ;  44 "i2c_test.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	ldi r22,lo8(32)
	ldi r23,lo8(-95)
	ldi r24,lo8(7)
	ldi r25,0
	call __I2C_init
	ldi r24,lo8(1)
	sts busyflag,r24
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(4)
	ldi r21,0
	ldi r22,lo8(cmd_chargepump)
	ldi r23,hi8(cmd_chargepump)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L8:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L8
	ldi r24,lo8(1)
	sts busyflag,r24
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(2)
	ldi r21,0
	ldi r22,lo8(cmd_displayon)
	ldi r23,hi8(cmd_displayon)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L9:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L9
	ldi r24,lo8(1)
	sts busyflag,r24
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(4)
	ldi r21,0
	ldi r22,lo8(cmd_setbrightness)
	ldi r23,hi8(cmd_setbrightness)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L10:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L10
	ldi r24,lo8(1)
	sts busyflag,r24
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(2)
	ldi r21,0
	ldi r22,lo8(cmd_invert)
	ldi r23,hi8(cmd_invert)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L11:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L11
	ldi r20,lo8(bitmap_open)
	mov r14,r20
	ldi r20,hi8(bitmap_open)
	mov r15,r20
	ldi r28,0
	ldi r29,lo8(1)
.L16:
	mov r24,r28
	ori r24,lo8(-80)
	sts cmd_selpage+1,r24
	sts busyflag,r29
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(2)
	ldi r21,0
	ldi r22,lo8(cmd_selpage)
	ldi r23,hi8(cmd_selpage)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L12:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L12
	sts busyflag,r29
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(4)
	ldi r21,0
	ldi r22,lo8(cmd_cursor0)
	ldi r23,hi8(cmd_cursor0)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L13:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L13
	ldi r26,lo8(pagebuffer+1)
	ldi r27,hi8(pagebuffer+1)
	movw r30,r14
.L14:
/* #APP */
 ;  68 "i2c_test.c" 1
	lpm r24, Z
	
 ;  0 "" 2
/* #NOAPP */
	st X+,r24
	adiw r30,1
	ldi r24,hi8(pagebuffer+129)
	cpi r26,lo8(pagebuffer+129)
	cpc r27,r24
	brne .L14
	sts busyflag,r29
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(-127)
	ldi r21,0
	ldi r22,lo8(pagebuffer)
	ldi r23,hi8(pagebuffer)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L15:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L15
	subi r28,lo8(-(1))
	ldi r24,-128
	add r14,r24
	adc r15,__zero_reg__
	cpi r28,lo8(8)
	breq .+2
	rjmp .L16
	ldi r28,lo8(1)
.L52:
	call soft_delay.constprop.0
	ldi r19,lo8(eye3)
	mov r14,r19
	ldi r19,hi8(eye3)
	mov r15,r19
	movw r12,r14
	ldi r29,lo8(2)
.L21:
	mov r24,r29
	ori r24,lo8(-80)
	sts cmd_selpage+1,r24
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(2)
	ldi r21,0
	ldi r22,lo8(cmd_selpage)
	ldi r23,hi8(cmd_selpage)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L17:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L17
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(4)
	ldi r21,0
	ldi r22,lo8(cmd_cursor15)
	ldi r23,hi8(cmd_cursor15)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L18:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L18
	ldi r26,lo8(pagebuffer+1)
	ldi r27,hi8(pagebuffer+1)
	movw r30,r12
.L19:
/* #APP */
 ;  88 "i2c_test.c" 1
	lpm r24, Z
	
 ;  0 "" 2
/* #NOAPP */
	st X+,r24
	adiw r30,1
	ldi r24,hi8(pagebuffer+16)
	cpi r26,lo8(pagebuffer+16)
	cpc r27,r24
	brne .L19
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(16)
	ldi r21,0
	ldi r22,lo8(pagebuffer)
	ldi r23,hi8(pagebuffer)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L20:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L20
	ldi r24,15
	add r12,r24
	adc r13,__zero_reg__
	cpi r29,lo8(3)
	breq .+2
	rjmp .L53
	call soft_delay.constprop.0
	ldi r18,lo8(eye2)
	mov r12,r18
	ldi r18,hi8(eye2)
	mov r13,r18
	movw r10,r12
	ldi r29,lo8(2)
.L26:
	mov r24,r29
	ori r24,lo8(-80)
	sts cmd_selpage+1,r24
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(2)
	ldi r21,0
	ldi r22,lo8(cmd_selpage)
	ldi r23,hi8(cmd_selpage)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L22:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L22
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(4)
	ldi r21,0
	ldi r22,lo8(cmd_cursor15)
	ldi r23,hi8(cmd_cursor15)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L23:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L23
	ldi r26,lo8(pagebuffer+1)
	ldi r27,hi8(pagebuffer+1)
	movw r30,r10
.L24:
/* #APP */
 ;  106 "i2c_test.c" 1
	lpm r24, Z
	
 ;  0 "" 2
/* #NOAPP */
	st X+,r24
	adiw r30,1
	ldi r24,hi8(pagebuffer+16)
	cpi r26,lo8(pagebuffer+16)
	cpc r27,r24
	brne .L24
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(16)
	ldi r21,0
	ldi r22,lo8(pagebuffer)
	ldi r23,hi8(pagebuffer)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L25:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L25
	ldi r24,15
	add r10,r24
	adc r11,__zero_reg__
	cpi r29,lo8(3)
	breq .+2
	rjmp .L54
	call soft_delay.constprop.0
	ldi r25,lo8(eye1_5)
	mov r10,r25
	ldi r25,hi8(eye1_5)
	mov r11,r25
	movw r8,r10
	ldi r29,lo8(2)
.L31:
	mov r24,r29
	ori r24,lo8(-80)
	sts cmd_selpage+1,r24
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(2)
	ldi r21,0
	ldi r22,lo8(cmd_selpage)
	ldi r23,hi8(cmd_selpage)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L27:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L27
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(4)
	ldi r21,0
	ldi r22,lo8(cmd_cursor15)
	ldi r23,hi8(cmd_cursor15)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L28:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L28
	ldi r26,lo8(pagebuffer+1)
	ldi r27,hi8(pagebuffer+1)
	movw r30,r8
.L29:
/* #APP */
 ;  124 "i2c_test.c" 1
	lpm r24, Z
	
 ;  0 "" 2
/* #NOAPP */
	st X+,r24
	adiw r30,1
	ldi r24,hi8(pagebuffer+16)
	cpi r26,lo8(pagebuffer+16)
	cpc r27,r24
	brne .L29
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(16)
	ldi r21,0
	ldi r22,lo8(pagebuffer)
	ldi r23,hi8(pagebuffer)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L30:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L30
	ldi r24,15
	add r8,r24
	adc r9,__zero_reg__
	cpi r29,lo8(3)
	breq .+2
	rjmp .L55
	call soft_delay.constprop.0
	ldi r24,lo8(eye1)
	mov r8,r24
	ldi r24,hi8(eye1)
	mov r9,r24
	ldi r29,lo8(2)
.L36:
	mov r24,r29
	ori r24,lo8(-80)
	sts cmd_selpage+1,r24
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(2)
	ldi r21,0
	ldi r22,lo8(cmd_selpage)
	ldi r23,hi8(cmd_selpage)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L32:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L32
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(4)
	ldi r21,0
	ldi r22,lo8(cmd_cursor15)
	ldi r23,hi8(cmd_cursor15)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L33:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L33
	ldi r26,lo8(pagebuffer+1)
	ldi r27,hi8(pagebuffer+1)
	movw r30,r8
.L34:
/* #APP */
 ;  142 "i2c_test.c" 1
	lpm r24, Z
	
 ;  0 "" 2
/* #NOAPP */
	st X+,r24
	adiw r30,1
	ldi r24,hi8(pagebuffer+16)
	cpi r26,lo8(pagebuffer+16)
	cpc r27,r24
	brne .L34
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(16)
	ldi r21,0
	ldi r22,lo8(pagebuffer)
	ldi r23,hi8(pagebuffer)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L35:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L35
	ldi r24,15
	add r8,r24
	adc r9,__zero_reg__
	cpi r29,lo8(3)
	breq .+2
	rjmp .L56
	call soft_delay.constprop.0
	ldi r29,lo8(2)
.L41:
	mov r24,r29
	ori r24,lo8(-80)
	sts cmd_selpage+1,r24
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(2)
	ldi r21,0
	ldi r22,lo8(cmd_selpage)
	ldi r23,hi8(cmd_selpage)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L37:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L37
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(4)
	ldi r21,0
	ldi r22,lo8(cmd_cursor15)
	ldi r23,hi8(cmd_cursor15)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L38:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L38
	ldi r26,lo8(pagebuffer+1)
	ldi r27,hi8(pagebuffer+1)
	movw r30,r10
.L39:
/* #APP */
 ;  160 "i2c_test.c" 1
	lpm r24, Z
	
 ;  0 "" 2
/* #NOAPP */
	st X+,r24
	adiw r30,1
	ldi r24,hi8(pagebuffer+16)
	cpi r26,lo8(pagebuffer+16)
	cpc r27,r24
	brne .L39
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(16)
	ldi r21,0
	ldi r22,lo8(pagebuffer)
	ldi r23,hi8(pagebuffer)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L40:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L40
	ldi r24,15
	add r10,r24
	adc r11,__zero_reg__
	cpi r29,lo8(3)
	breq .+2
	rjmp .L57
	call soft_delay.constprop.0
	ldi r29,lo8(2)
.L46:
	mov r24,r29
	ori r24,lo8(-80)
	sts cmd_selpage+1,r24
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(2)
	ldi r21,0
	ldi r22,lo8(cmd_selpage)
	ldi r23,hi8(cmd_selpage)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L42:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L42
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(4)
	ldi r21,0
	ldi r22,lo8(cmd_cursor15)
	ldi r23,hi8(cmd_cursor15)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L43:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L43
	ldi r26,lo8(pagebuffer+1)
	ldi r27,hi8(pagebuffer+1)
	movw r30,r12
.L44:
/* #APP */
 ;  178 "i2c_test.c" 1
	lpm r24, Z
	
 ;  0 "" 2
/* #NOAPP */
	st X+,r24
	adiw r30,1
	ldi r24,hi8(pagebuffer+16)
	cpi r26,lo8(pagebuffer+16)
	cpc r27,r24
	brne .L44
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(16)
	ldi r21,0
	ldi r22,lo8(pagebuffer)
	ldi r23,hi8(pagebuffer)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L45:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L45
	ldi r24,15
	add r12,r24
	adc r13,__zero_reg__
	cpi r29,lo8(3)
	breq .+2
	rjmp .L58
	call soft_delay.constprop.0
	ldi r29,lo8(2)
.L51:
	mov r24,r29
	ori r24,lo8(-80)
	sts cmd_selpage+1,r24
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(2)
	ldi r21,0
	ldi r22,lo8(cmd_selpage)
	ldi r23,hi8(cmd_selpage)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L47:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L47
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(4)
	ldi r21,0
	ldi r22,lo8(cmd_cursor15)
	ldi r23,hi8(cmd_cursor15)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L48:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L48
	ldi r26,lo8(pagebuffer+1)
	ldi r27,hi8(pagebuffer+1)
	movw r30,r14
.L49:
/* #APP */
 ;  196 "i2c_test.c" 1
	lpm r24, Z
	
 ;  0 "" 2
/* #NOAPP */
	st X+,r24
	adiw r30,1
	ldi r24,hi8(pagebuffer+16)
	cpi r26,lo8(pagebuffer+16)
	cpc r27,r24
	brne .L49
	sts busyflag,r28
	ldi r16,0
	ldi r18,lo8(gs(empty_callback))
	ldi r19,hi8(gs(empty_callback))
	ldi r20,lo8(16)
	ldi r21,0
	ldi r22,lo8(pagebuffer)
	ldi r23,hi8(pagebuffer)
	ldi r24,lo8(60)
	call __I2C_tx_schedule
.L50:
	lds r24,busyflag
	cpse r24,__zero_reg__
	rjmp .L50
	ldi r24,15
	add r14,r24
	adc r15,__zero_reg__
	cpi r29,lo8(3)
	brne .+2
	rjmp .L52
	ldi r29,lo8(3)
	rjmp .L51
.L53:
	ldi r29,lo8(3)
	rjmp .L21
.L54:
	ldi r29,lo8(3)
	rjmp .L26
.L55:
	ldi r29,lo8(3)
	rjmp .L31
.L56:
	ldi r29,lo8(3)
	rjmp .L36
.L57:
	ldi r29,lo8(3)
	rjmp .L41
.L58:
	ldi r29,lo8(3)
	rjmp .L46
	.size	main, .-main
.global	pagebuffer
	.data
	.type	pagebuffer, @object
	.size	pagebuffer, 129
pagebuffer:
	.byte	64
	.byte	0
	.zero	127
.global	cmd_invert
	.type	cmd_invert, @object
	.size	cmd_invert, 2
cmd_invert:
	.byte	-128
	.byte	-90
.global	cmd_cursor15
	.type	cmd_cursor15, @object
	.size	cmd_cursor15, 4
cmd_cursor15:
	.byte	-128
	.byte	8
	.byte	-128
	.byte	19
.global	cmd_cursor0
	.type	cmd_cursor0, @object
	.size	cmd_cursor0, 4
cmd_cursor0:
	.byte	-128
	.byte	0
	.byte	-128
	.byte	16
.global	cmd_selpage
	.type	cmd_selpage, @object
	.size	cmd_selpage, 2
cmd_selpage:
	.byte	-128
	.byte	-80
.global	cmd_seqcom
	.type	cmd_seqcom, @object
	.size	cmd_seqcom, 4
cmd_seqcom:
	.byte	-128
	.byte	-38
	.byte	-128
	.byte	2
.global	cmd_pagemode
	.type	cmd_pagemode, @object
	.size	cmd_pagemode, 4
cmd_pagemode:
	.byte	-128
	.byte	32
	.byte	-128
	.byte	2
.global	cmd_chargepump
	.type	cmd_chargepump, @object
	.size	cmd_chargepump, 4
cmd_chargepump:
	.byte	-128
	.byte	-115
	.byte	-128
	.byte	20
.global	cmd_forceon
	.type	cmd_forceon, @object
	.size	cmd_forceon, 2
cmd_forceon:
	.byte	-128
	.byte	-91
.global	cmd_setbrightness
	.type	cmd_setbrightness, @object
	.size	cmd_setbrightness, 4
cmd_setbrightness:
	.byte	-128
	.byte	-127
	.byte	-128
	.byte	-1
.global	cmd_displayon
	.type	cmd_displayon, @object
	.size	cmd_displayon, 2
cmd_displayon:
	.byte	-128
	.byte	-81
.global	busyflag
	.section .bss
	.type	busyflag, @object
	.size	busyflag, 1
busyflag:
	.zero	1
.global	eye3
	.section	.progmem.data,"a",@progbits
	.type	eye3, @object
	.size	eye3, 30
eye3:
	.byte	-1
	.byte	-1
	.byte	-65
	.byte	-113
	.byte	-49
	.byte	-17
	.byte	-9
	.byte	-1
	.byte	127
	.byte	47
	.byte	15
	.byte	-1
	.byte	-4
	.byte	-8
	.byte	0
	.byte	97
	.byte	125
	.byte	112
	.byte	92
	.byte	31
	.byte	63
	.byte	127
	.byte	127
	.byte	0
	.byte	0
	.byte	126
	.byte	23
	.byte	15
	.byte	15
	.byte	0
.global	eye2
	.type	eye2, @object
	.size	eye2, 30
eye2:
	.byte	-1
	.byte	-1
	.byte	-65
	.byte	-113
	.byte	-57
	.byte	-17
	.byte	-9
	.byte	63
	.byte	63
	.byte	15
	.byte	15
	.byte	-1
	.byte	-4
	.byte	-16
	.byte	0
	.byte	97
	.byte	125
	.byte	112
	.byte	92
	.byte	31
	.byte	63
	.byte	127
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	23
	.byte	15
	.byte	15
	.byte	0
.global	eye1_5
	.type	eye1_5, @object
	.size	eye1_5, 30
eye1_5:
	.byte	-1
	.byte	-1
	.byte	-65
	.byte	15
	.byte	-17
	.byte	-17
	.byte	7
	.byte	7
	.byte	7
	.byte	15
	.byte	15
	.byte	-1
	.byte	-4
	.byte	-8
	.byte	0
	.byte	97
	.byte	121
	.byte	124
	.byte	127
	.byte	63
	.byte	15
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	23
	.byte	15
	.byte	15
	.byte	0
.global	eye1
	.type	eye1, @object
	.size	eye1, 30
eye1:
	.byte	-1
	.byte	-1
	.byte	-65
	.byte	31
	.byte	15
	.byte	15
	.byte	7
	.byte	7
	.byte	7
	.byte	15
	.byte	15
	.byte	-1
	.byte	-4
	.byte	-8
	.byte	0
	.byte	97
	.byte	125
	.byte	96
	.byte	64
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	23
	.byte	15
	.byte	15
	.byte	0
.global	bitmap_open
	.type	bitmap_open, @object
	.size	bitmap_open, 1024
bitmap_open:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-64
	.byte	-64
	.byte	-64
	.byte	-64
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-16
	.byte	-16
	.byte	-16
	.byte	-16
	.byte	-16
	.byte	-16
	.byte	-16
	.byte	-16
	.byte	-80
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	48
	.byte	48
	.byte	32
	.byte	96
	.byte	-64
	.byte	-64
	.byte	-64
	.byte	-64
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-16
	.byte	-16
	.byte	-16
	.byte	-16
	.byte	120
	.byte	120
	.byte	56
	.byte	-72
	.byte	-100
	.byte	-100
	.byte	-100
	.byte	-68
	.byte	-4
	.byte	-4
	.byte	-4
	.byte	-4
	.byte	-12
	.byte	-12
	.byte	-12
	.byte	-20
	.byte	-20
	.byte	124
	.byte	124
	.byte	60
	.byte	-104
	.byte	-8
	.byte	-8
	.byte	-16
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-128
	.byte	-64
	.byte	-32
	.byte	-16
	.byte	-8
	.byte	-8
	.byte	-4
	.byte	-2
	.byte	-2
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-2
	.byte	-2
	.byte	-2
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	47
	.byte	15
	.byte	15
	.byte	15
	.byte	-113
	.byte	-113
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	2
	.byte	2
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	4
	.byte	4
	.byte	12
	.byte	8
	.byte	8
	.byte	24
	.byte	16
	.byte	16
	.byte	32
	.byte	96
	.byte	96
	.byte	-64
	.byte	-128
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-16
	.byte	-4
	.byte	-1
	.byte	127
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	127
	.byte	63
	.byte	127
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	31
	.byte	31
	.byte	31
	.byte	15
	.byte	15
	.byte	31
	.byte	31
	.byte	63
	.byte	127
	.byte	-1
	.byte	-1
	.byte	3
	.byte	3
	.byte	3
	.byte	7
	.byte	15
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-2
	.byte	-2
	.byte	-2
	.byte	-2
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-2
	.byte	-26
	.byte	-32
	.byte	64
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	1
	.byte	2
	.byte	6
	.byte	12
	.byte	24
	.byte	48
	.byte	-64
	.byte	-128
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	127
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-2
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	63
	.byte	31
	.byte	15
	.byte	-121
	.byte	-29
	.byte	-7
	.byte	-4
	.byte	-97
	.byte	67
	.byte	3
	.byte	35
	.byte	67
	.byte	3
	.byte	7
	.byte	31
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	127
	.byte	127
	.byte	127
	.byte	127
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-17
	.byte	15
	.byte	-113
	.byte	-1
	.byte	-33
	.byte	31
	.byte	47
	.byte	-4
	.byte	-8
	.byte	-128
	.byte	64
	.byte	96
	.byte	0
	.byte	0
	.byte	-128
	.byte	-63
	.byte	-5
	.byte	-61
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-64
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	3
	.byte	30
	.byte	-8
	.byte	-64
	.byte	0
	.byte	0
	.byte	0
	.byte	63
	.byte	127
	.byte	-17
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-15
	.byte	-128
	.byte	-64
	.byte	-25
	.byte	-61
	.byte	-64
	.byte	-128
	.byte	0
	.byte	14
	.byte	-1
	.byte	-1
	.byte	63
	.byte	19
	.byte	1
	.byte	0
	.byte	50
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-33
	.byte	-127
	.byte	-128
	.byte	-128
	.byte	-64
	.byte	-63
	.byte	-63
	.byte	-63
	.byte	-63
	.byte	-63
	.byte	-63
	.byte	-63
	.byte	-3
	.byte	-3
	.byte	-3
	.byte	-4
	.byte	-6
	.byte	-6
	.byte	-1
	.byte	-17
	.byte	-1
	.byte	-2
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-16
	.byte	-16
	.byte	-4
	.byte	-2
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-57
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	63
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	3
	.byte	7
	.byte	7
	.byte	15
	.byte	15
	.byte	31
	.byte	63
	.byte	127
	.byte	127
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-4
	.byte	-32
	.byte	-61
	.byte	-63
	.byte	-64
	.byte	-64
	.byte	-2
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	7
	.byte	-125
	.byte	3
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	3
	.byte	35
	.byte	99
	.byte	-29
	.byte	-125
	.byte	7
	.byte	15
	.byte	15
	.byte	31
	.byte	63
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-2
	.byte	-49
	.byte	-97
	.byte	25
	.byte	-104
	.byte	-112
	.byte	-128
	.byte	-128
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-128
	.byte	-64
	.byte	48
	.byte	28
	.byte	7
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	1
	.byte	3
	.byte	3
	.byte	3
	.byte	7
	.byte	7
	.byte	15
	.byte	15
	.byte	15
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	63
	.byte	127
	.byte	127
	.byte	127
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-16
	.byte	-24
	.byte	-56
	.byte	-32
	.byte	-32
	.byte	-16
	.byte	-16
	.byte	-2
	.byte	-1
	.byte	63
	.byte	0
	.byte	0
	.byte	0
	.byte	-128
	.byte	-40
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-2
	.byte	-2
	.byte	-8
	.byte	-7
	.byte	-13
	.byte	-13
	.byte	-28
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	-32
	.byte	112
	.byte	48
	.byte	16
	.byte	24
	.byte	8
	.byte	12
	.byte	6
	.byte	3
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	3
	.byte	3
	.byte	3
	.byte	7
	.byte	7
	.byte	15
	.byte	15
	.byte	15
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	31
	.byte	15
	.byte	15
	.byte	15
	.byte	15
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	3
	.byte	3
	.byte	1
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.ident	"GCC: (GNU) 8.2.0"
.global __do_copy_data
.global __do_clear_bss