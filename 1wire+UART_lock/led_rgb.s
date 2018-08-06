	.file	"led_rgb.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	led_RGB_init
	.type	led_RGB_init, @function
led_RGB_init:
	push r12
	push r13
	push r14
	push r16
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 6 */
.L__stack_usage = 6
	movw r30,r24
	st Z,__zero_reg__
	std Z+1,__zero_reg__
	std Z+2,__zero_reg__
	std Z+3,r18
	std Z+4,r16
	std Z+5,r14
	std Z+7,r23
	std Z+6,r22
	std Z+9,r21
	std Z+8,r20
	movw r26,r20
	ld r24,X
	ldi r22,lo8(1)
	ldi r23,0
	movw r26,r22
	rjmp 2f
	1:
	lsl r26
	rol r27
	2:
	dec r18
	brpl 1b
	movw r18,r26
	movw r28,r22
	rjmp 2f
	1:
	lsl r28
	2:
	dec r16
	brpl 1b
	rjmp 2f
	1:
	lsl r22
	2:
	dec r14
	brpl 1b
	or r24,r22
	or r24,r28
	or r24,r18
	movw r26,r20
	st X,r24
	ldd r26,Z+6
	ldd r27,Z+7
	ld r24,X
	and r22,r28
	and r22,r18
	com r22
	and r22,r24
	st X,r22
	std Z+11,r13
	std Z+10,r12
/* epilogue start */
	pop r29
	pop r28
	pop r16
	pop r14
	pop r13
	pop r12
	ret
	.size	led_RGB_init, .-led_RGB_init
.global	led_RGB_red
	.type	led_RGB_red, @function
led_RGB_red:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	ldi r24,lo8(-1)
	st Z,r24
	std Z+1,__zero_reg__
	std Z+2,__zero_reg__
	ldd r26,Z+6
	ldd r27,Z+7
	ld r24,X
	ldd r25,Z+3
	ldi r18,lo8(1)
	ldi r19,0
	movw r20,r18
	rjmp 2f
	1:
	lsl r20
	2:
	dec r25
	brpl 1b
	or r24,r20
	st X,r24
	ldd r26,Z+6
	ldd r27,Z+7
	ld r20,X
	ldd r24,Z+4
	movw r22,r18
	rjmp 2f
	1:
	lsl r22
	rol r23
	2:
	dec r24
	brpl 1b
	movw r24,r22
	ldd r25,Z+5
	rjmp 2f
	1:
	lsl r18
	2:
	dec r25
	brpl 1b
	or r24,r18
	com r24
	and r24,r20
	st X,r24
/* epilogue start */
	ret
	.size	led_RGB_red, .-led_RGB_red
.global	led_RGB_green
	.type	led_RGB_green, @function
led_RGB_green:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	st Z,__zero_reg__
	ldi r24,lo8(-1)
	std Z+1,r24
	std Z+2,__zero_reg__
	ldd r26,Z+6
	ldd r27,Z+7
	ld r24,X
	ldd r25,Z+4
	ldi r18,lo8(1)
	ldi r19,0
	movw r20,r18
	rjmp 2f
	1:
	lsl r20
	2:
	dec r25
	brpl 1b
	or r24,r20
	st X,r24
	ldd r26,Z+6
	ldd r27,Z+7
	ld r20,X
	ldd r24,Z+3
	movw r22,r18
	rjmp 2f
	1:
	lsl r22
	rol r23
	2:
	dec r24
	brpl 1b
	movw r24,r22
	ldd r25,Z+5
	rjmp 2f
	1:
	lsl r18
	2:
	dec r25
	brpl 1b
	or r24,r18
	com r24
	and r24,r20
	st X,r24
/* epilogue start */
	ret
	.size	led_RGB_green, .-led_RGB_green
.global	led_RGB_blue
	.type	led_RGB_blue, @function
led_RGB_blue:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r30,r24
	st Z,__zero_reg__
	std Z+1,__zero_reg__
	ldi r24,lo8(-1)
	std Z+2,r24
	ldd r26,Z+6
	ldd r27,Z+7
	ld r24,X
	ldd r25,Z+5
	ldi r18,lo8(1)
	ldi r19,0
	movw r20,r18
	rjmp 2f
	1:
	lsl r20
	2:
	dec r25
	brpl 1b
	or r24,r20
	st X,r24
	ldd r26,Z+6
	ldd r27,Z+7
	ld r20,X
	ldd r24,Z+3
	movw r22,r18
	rjmp 2f
	1:
	lsl r22
	rol r23
	2:
	dec r24
	brpl 1b
	movw r24,r22
	ldd r25,Z+4
	rjmp 2f
	1:
	lsl r18
	2:
	dec r25
	brpl 1b
	or r24,r18
	com r24
	and r24,r20
	st X,r24
/* epilogue start */
	ret
	.size	led_RGB_blue, .-led_RGB_blue
	.ident	"GCC: (GNU) 8.2.0"
