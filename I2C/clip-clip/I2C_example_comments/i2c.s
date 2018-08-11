	.file	"i2c.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	__I2C_init
	.type	__I2C_init, @function
__I2C_init:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sts I2C_state+1,__zero_reg__
	sts I2C_state,__zero_reg__
	lds r18,100
	andi r18,lo8(127)
	sts 100,r18
	movw r18,r22
	movw r20,r24
	lsl r18
	rol r19
	rol r20
	rol r21
	ldi r22,0
	ldi r23,lo8(36)
	ldi r24,lo8(-12)
	ldi r25,0
	call __udivmodsi4
	movw r22,r20
	movw r20,r18
	subi r20,8
	sbc r21,__zero_reg__
	sbc r22,__zero_reg__
	sbc r23,__zero_reg__
	ldi r24,0
.L3:
	cpi r20,-1
	cpc r21,__zero_reg__
	cpc r22,__zero_reg__
	cpc r23,__zero_reg__
	breq .L2
	brlo .L2
	ldi r25,2
	1:
	lsr r23
	ror r22
	ror r21
	ror r20
	dec r25
	brne 1b
	subi r24,lo8(-(1))
	cpi r24,lo8(4)
	brne .L3
.L2:
	sts 184,r20
	lds r25,185
	andi r25,lo8(-4)
	andi r24,lo8(3)
	or r24,r25
	sts 185,r24
	ldi r24,lo8(5)
	sts 188,r24
/* epilogue start */
	ret
	.size	__I2C_init, .-__I2C_init
.global	__I2C_tx_schedule
	.type	__I2C_tx_schedule, @function
__I2C_tx_schedule:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r25,__SREG__
/* #APP */
 ;  50 "/usr/avr/include/util/atomic.h" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	lds r30,I2C_state
	lds r31,I2C_state+1
	or r30,r31
	brne .L7
	sts dataptr+1,r23
	sts dataptr,r22
	sts datacount+1,r21
	sts datacount,r20
	sts callback+1,r19
	sts callback,r18
	ldi r18,lo8(2)
	ldi r19,0
	sts I2C_state+1,r19
	sts I2C_state,r18
	lsl r24
	sts devaddr,r24
	lds r24,188
	ori r24,lo8(-96)
	sts 188,r24
	ldi r24,lo8(1)
.L6:
	out __SREG__,r25
/* epilogue start */
	ret
.L7:
	ldi r24,0
	rjmp .L6
	.size	__I2C_tx_schedule, .-__I2C_tx_schedule
.global	__vector_24
	.type	__vector_24, @function
__vector_24:
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
	lds r24,I2C_state
	lds r25,I2C_state+1
	cpi r24,2
	cpc r25,__zero_reg__
	breq .L9
	brlo .L10
	sbiw r24,3
	breq .L11
.L8:
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
.L10:
	lds r24,188
	ori r24,lo8(-112)
	sts 188,r24
	sts I2C_state+1,__zero_reg__
	sts I2C_state,__zero_reg__
	lds r30,callback
	lds r31,callback+1
	icall
	rjmp .L8
.L9:
	lds r24,devaddr
	sts 187,r24
	lds r24,188
	andi r24,lo8(95)
	ori r24,lo8(-128)
	sts 188,r24
	ldi r24,lo8(3)
	ldi r25,0
	sts I2C_state+1,r25
	sts I2C_state,r24
	rjmp .L8
.L11:
	lds r30,dataptr
	lds r31,dataptr+1
	movw r24,r30
	adiw r24,1
	sts dataptr+1,r25
	sts dataptr,r24
	ld r24,Z
	sts 187,r24
	lds r24,datacount
	lds r25,datacount+1
	sbiw r24,1
	sts datacount+1,r25
	sts datacount,r24
	or r24,r25
	brne .L13
	ldi r24,lo8(1)
	ldi r25,0
	sts I2C_state+1,r25
	sts I2C_state,r24
.L13:
	lds r24,188
	ori r24,lo8(-128)
	sts 188,r24
	rjmp .L8
	.size	__vector_24, .-__vector_24
	.local	I2C_state
	.comm	I2C_state,2,1
	.local	callback
	.comm	callback,2,1
	.local	devaddr
	.comm	devaddr,1,1
	.local	datacount
	.comm	datacount,2,1
	.local	dataptr
	.comm	dataptr,2,1
.global	I2C_lasterror
	.section .bss
	.type	I2C_lasterror, @object
	.size	I2C_lasterror, 2
I2C_lasterror:
	.zero	2
	.ident	"GCC: (GNU) 8.2.0"
.global __do_clear_bss
