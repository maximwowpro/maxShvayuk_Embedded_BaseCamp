	.file	"onewire.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	ow_crc8_fast
	.type	ow_crc8_fast, @function
ow_crc8_fast:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	movw r26,r24
	ld r30,X
	eor r22,r30
	mov r30,r22
	ldi r31,0
	subi r30,lo8(-(ow_maxim_crc_table))
	sbci r31,hi8(-(ow_maxim_crc_table))
/* #APP */
 ;  49 "onewire.c" 1
	lpm r30, Z
	
 ;  0 "" 2
/* #NOAPP */
	st X,r30
/* epilogue start */
	ret
	.size	ow_crc8_fast, .-ow_crc8_fast
.global	ow_crc8_fast_arr
	.type	ow_crc8_fast_arr, @function
ow_crc8_fast_arr:
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 7 */
.L__stack_usage = 7
	std Y+1,__zero_reg__
	movw r16,r24
	movw r14,r24
	add r14,r22
	adc r15,r23
.L3:
	cp r16,r14
	cpc r17,r15
	brne .L4
	ldd r24,Y+1
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
.L4:
	movw r30,r16
	ld r22,Z+
	movw r16,r30
	movw r24,r28
	adiw r24,1
	call ow_crc8_fast
	rjmp .L3
	.size	ow_crc8_fast_arr, .-ow_crc8_fast_arr
.global	__ow_Pin_init
	.type	__ow_Pin_init, @function
__ow_Pin_init:
	push r4
	push r5
	push r6
	push r7
	push r8
	push r10
	push r12
	push r13
	push r14
	push r16
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 0 */
/* stack size = 13 */
.L__stack_usage = 13
	movw r30,r24
	movw r4,r22
	movw r6,r20
	mov r22,r14
	ldi r23,0
	movw r24,r12
	call __udivmodhi4
	or r24,r25
	brne .L14
	ldi r24,15
	sub r12,r24
	sbc r13,__zero_reg__
	ldi r24,46
	cp r12,r24
	cpc r13,__zero_reg__
	brsh .L14
	cp r4,__zero_reg__
	cpc r5,__zero_reg__
	breq .L14
	cp r6,__zero_reg__
	cpc r7,__zero_reg__
	breq .L14
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	breq .L14
	cp r16,__zero_reg__
	cpc r17,__zero_reg__
	breq .L14
	ldi r24,lo8(-60)
	add r24,r10
	cpi r24,lo8(61)
	brsh .L14
	ldi r24,lo8(-1)
	add r24,r8
	cpi r24,lo8(15)
	brsh .L14
	std Z+1,r5
	st Z,r4
	std Z+3,r7
	std Z+2,r6
	std Z+5,r19
	std Z+4,r18
	std Z+7,r17
	std Z+6,r16
	std Z+8,r22
	std Z+9,r14
	std Z+10,r10
	std Z+11,r8
	ldi r25,0
	ldi r24,0
.L5:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r14
	pop r13
	pop r12
	pop r10
	pop r8
	pop r7
	pop r6
	pop r5
	pop r4
	ret
.L14:
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L5
	.size	__ow_Pin_init, .-__ow_Pin_init
.global	ow_wait_release
	.type	ow_wait_release, @function
ow_wait_release:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	movw r16,r24
	movw r26,r24
	adiw r26,8
	ld r28,X
	ldi r29,0
.L16:
	sbiw r28,0
	brne .L18
.L17:
	movw r26,r16
	adiw r26,9
	ld r24,X
	mov r27,r24
	mul r27,r28
	movw r24,r0
	mul r27,r29
	add r25,r0
	clr __zero_reg__
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L18:
	movw r26,r16
	adiw r26,4
	ld r30,X+
	ld r31,X
	icall
	cpse r24,__zero_reg__
	rjmp .L17
	movw r30,r16
	ldd r24,Z+9
	ldd __tmp_reg__,Z+6
	ldd r31,Z+7
	mov r30,__tmp_reg__
	ldi r25,0
	icall
	sbiw r28,1
	rjmp .L16
	.size	ow_wait_release, .-ow_wait_release
.global	ow_tx_reset
	.type	ow_tx_reset, @function
ow_tx_reset:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	movw r28,r24
	ld r30,Y
	ldd r31,Y+1
	icall
	ldd r30,Y+6
	ldd r31,Y+7
	ldi r24,lo8(-32)
	ldi r25,lo8(1)
	icall
	ldd r30,Y+2
	ldd r31,Y+3
	icall
	movw r24,r28
	call ow_wait_release
	movw r16,r24
	or r24,r25
	breq .L20
	ldd r30,Y+6
	ldd r31,Y+7
	ldi r24,lo8(60)
	ldi r25,0
	icall
	ldd r30,Y+4
	ldd r31,Y+5
	icall
	cpse r24,__zero_reg__
	rjmp .L22
	ldd r30,Y+6
	ldd r31,Y+7
	ldi r24,lo8(-92)
	ldi r25,lo8(1)
	sub r24,r16
	sbc r25,r17
	icall
	ldd r30,Y+4
	ldd r31,Y+5
	icall
	cpse r24,__zero_reg__
	rjmp .L23
.L20:
	ldi r24,lo8(2)
	ldi r25,0
.L19:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
.L22:
	ldi r24,lo8(3)
	ldi r25,0
	rjmp .L19
.L23:
	ldi r25,0
	ldi r24,0
	rjmp .L19
	.size	ow_tx_reset, .-ow_tx_reset
.global	ow_tx_bit
	.type	ow_tx_bit, @function
ow_tx_bit:
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	movw r28,r24
	mov r17,r22
	ld r30,Y
	ldd r31,Y+1
	icall
	ldd r30,Y+6
	ldd r31,Y+7
	cpse r17,__zero_reg__
	rjmp .L28
	ldd r24,Y+10
	ldi r25,0
	icall
	ldd r30,Y+2
	ldd r31,Y+3
	icall
	movw r24,r28
	call ow_wait_release
	or r24,r25
	brne .L31
.L30:
	ldi r24,lo8(2)
	ldi r25,0
.L27:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	ret
.L28:
	ldd r24,Y+11
	ldi r25,0
	icall
	ldd r30,Y+2
	ldd r31,Y+3
	icall
	movw r24,r28
	call ow_wait_release
	sbiw r24,0
	breq .L30
	ldd r18,Y+10
	ldd r19,Y+11
	sub r18,r19
	sbc r19,r19
	ldd r30,Y+6
	ldd r31,Y+7
	movw r20,r18
	sub r20,r24
	sbc r21,r25
	movw r24,r20
	icall
.L31:
	ldi r25,0
	ldi r24,0
	rjmp .L27
	.size	ow_tx_bit, .-ow_tx_bit
.global	__ow_rx_bit
	.type	__ow_rx_bit, @function
__ow_rx_bit:
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
	movw r14,r22
	mov r16,r20
	ld r30,Y
	ldd r31,Y+1
	icall
	ldd r24,Y+11
	ldd r30,Y+6
	ldd r31,Y+7
	ldi r25,0
	icall
	ldd r30,Y+2
	ldd r31,Y+3
	icall
	ldd r25,Y+11
	ldd r30,Y+6
	ldd r31,Y+7
	ldi r18,lo8(15)
	ldi r19,0
	movw r20,r18
	sub r20,r25
	sbc r21,__zero_reg__
	movw r24,r20
	icall
	mov r13,__zero_reg__
	mov r12,__zero_reg__
	ldi r17,0
.L36:
	ldd r30,Y+4
	ldd r31,Y+5
	icall
	mov r0,r12
	rjmp 2f
	1:
	lsl r24
	2:
	dec r0
	brpl 1b
	or r17,r24
	ldi r21,-1
	sub r12,r21
	sbc r13,r21
	ldi r24,8
	cp r12,r24
	cpc r13,__zero_reg__
	brne .L36
	ldi r21,0
	ldi r20,0
	ldi r24,0
	mov r18,r17
	ldi r19,0
.L38:
	movw r22,r18
	mov r0,r20
	rjmp 2f
	1:
	asr r23
	ror r22
	2:
	dec r0
	brpl 1b
	sbrc r22,0
	subi r24,lo8(-(1))
.L37:
	subi r20,-1
	sbci r21,-1
	cpi r20,8
	cpc r21,__zero_reg__
	brne .L38
	ldi r25,lo8(1)
	cpi r24,lo8(5)
	brsh .L39
	ldi r25,0
.L39:
	movw r30,r14
	st Z,r25
	ldi r17,lo8(-2)
	add r17,r24
	cpi r17,lo8(6)
	brsh .L40
	cpse r16,__zero_reg__
	rjmp .L41
.L40:
	ldd r24,Y+10
	ldd r30,Y+6
	ldd r31,Y+7
	subi r24,15
	sbc r25,r25
	icall
	ldi r25,0
	ldi r24,0
	cpi r17,lo8(6)
	brsh .L35
.L41:
	ldi r24,lo8(4)
	ldi r25,0
.L35:
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
	.size	__ow_rx_bit, .-__ow_rx_bit
.global	__ow_tx_byte
	.type	__ow_tx_byte, @function
__ow_tx_byte:
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
/* stack size = 9 */
.L__stack_usage = 9
	movw r14,r24
	mov r11,r20
	ldi r29,0
	ldi r28,0
	clr r12
	inc r12
	mov r13,__zero_reg__
	mov r16,r22
	ldi r17,0
.L53:
	movw r24,r12
	mov r0,r28
	rjmp 2f
	1:
	lsl r24
	rol r25
	2:
	dec r0
	brpl 1b
	and r24,r16
	and r25,r17
	mov r0,r28
	rjmp 2f
	1:
	asr r25
	ror r24
	2:
	dec r0
	brpl 1b
	ldi r22,lo8(1)
	or r24,r25
	brne .L50
	ldi r22,0
.L50:
	movw r24,r14
	call ow_tx_bit
	sbiw r24,0
	breq .L51
	cpse r11,__zero_reg__
	rjmp .L49
.L51:
	adiw r28,1
	cpi r28,8
	cpc r29,__zero_reg__
	brne .L53
.L49:
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
	ret
	.size	__ow_tx_byte, .-__ow_tx_byte
.global	__ow_rx_byte
	.type	__ow_rx_byte, @function
__ow_rx_byte:
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 10 */
.L__stack_usage = 10
	movw r14,r24
	movw r16,r22
	mov r11,r20
	movw r30,r22
	st Z,__zero_reg__
	mov r13,__zero_reg__
	mov r12,__zero_reg__
.L61:
	mov r20,r11
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	movw r24,r14
	call __ow_rx_bit
	ldd r18,Y+1
	mov r0,r12
	rjmp 2f
	1:
	lsl r18
	2:
	dec r0
	brpl 1b
	movw r30,r16
	ld r19,Z
	or r18,r19
	st Z,r18
	sbiw r24,0
	breq .L59
	cpse r11,__zero_reg__
	rjmp .L58
.L59:
	ldi r31,-1
	sub r12,r31
	sbc r13,r31
	ldi r18,8
	cp r12,r18
	cpc r13,__zero_reg__
	brne .L61
.L58:
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	ret
	.size	__ow_rx_byte, .-__ow_rx_byte
.global	__ow_cmd_readrom
	.type	__ow_cmd_readrom, @function
__ow_cmd_readrom:
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
	push __tmp_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 13 */
.L__stack_usage = 13
	movw r12,r24
	mov r17,r22
	mov r9,r23
	movw r10,r20
	cpse r18,__zero_reg__
	rjmp .L68
.L72:
	mov r20,r16
	ldi r22,lo8(51)
	movw r24,r12
	call __ow_tx_byte
	sbiw r24,0
	breq .+2
	rjmp .L69
.L70:
	mov r14,r17
	mov r15,r9
	ldi r24,lo8(7)
	mov r8,r24
	add r8,r17
.L74:
	mov r20,r16
	movw r22,r14
	movw r24,r12
	call __ow_rx_byte
	sbiw r24,0
	breq .L73
	cpse r16,__zero_reg__
	rjmp .L67
.L73:
	ldi r24,-1
	sub r14,r24
	sbc r15,r24
	cpse r8,r14
	rjmp .L74
	std Y+1,__zero_reg__
	mov r20,r16
	movw r22,r28
	subi r22,-1
	sbci r23,-1
	movw r24,r12
	call __ow_rx_byte
	sbiw r24,0
	breq .L75
	cpse r16,__zero_reg__
	rjmp .L67
.L75:
	cp r10,__zero_reg__
	cpc r11,__zero_reg__
	breq .L76
	ldd r24,Y+1
	movw r30,r10
	st Z,r24
.L76:
	ldi r22,lo8(7)
	ldi r23,0
	mov r24,r17
	mov r25,r9
	call ow_crc8_fast_arr
	ldd r25,Y+1
	cp r25,r24
	breq .L77
	ldi r24,lo8(5)
	ldi r25,0
	rjmp .L67
.L68:
	call ow_tx_reset
	sbiw r24,0
	breq .L72
.L67:
/* epilogue start */
	pop __tmp_reg__
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
	ret
.L69:
	tst r16
	brne .+2
	rjmp .L70
	rjmp .L67
.L77:
	ldi r25,0
	ldi r24,0
	rjmp .L67
	.size	__ow_cmd_readrom, .-__ow_cmd_readrom
	.section	.progmem.data,"a",@progbits
	.type	ow_maxim_crc_table, @object
	.size	ow_maxim_crc_table, 256
ow_maxim_crc_table:
	.byte	0
	.byte	94
	.byte	-68
	.byte	-30
	.byte	97
	.byte	63
	.byte	-35
	.byte	-125
	.byte	-62
	.byte	-100
	.byte	126
	.byte	32
	.byte	-93
	.byte	-3
	.byte	31
	.byte	65
	.byte	-99
	.byte	-61
	.byte	33
	.byte	127
	.byte	-4
	.byte	-94
	.byte	64
	.byte	30
	.byte	95
	.byte	1
	.byte	-29
	.byte	-67
	.byte	62
	.byte	96
	.byte	-126
	.byte	-36
	.byte	35
	.byte	125
	.byte	-97
	.byte	-63
	.byte	66
	.byte	28
	.byte	-2
	.byte	-96
	.byte	-31
	.byte	-65
	.byte	93
	.byte	3
	.byte	-128
	.byte	-34
	.byte	60
	.byte	98
	.byte	-66
	.byte	-32
	.byte	2
	.byte	92
	.byte	-33
	.byte	-127
	.byte	99
	.byte	61
	.byte	124
	.byte	34
	.byte	-64
	.byte	-98
	.byte	29
	.byte	67
	.byte	-95
	.byte	-1
	.byte	70
	.byte	24
	.byte	-6
	.byte	-92
	.byte	39
	.byte	121
	.byte	-101
	.byte	-59
	.byte	-124
	.byte	-38
	.byte	56
	.byte	102
	.byte	-27
	.byte	-69
	.byte	89
	.byte	7
	.byte	-37
	.byte	-123
	.byte	103
	.byte	57
	.byte	-70
	.byte	-28
	.byte	6
	.byte	88
	.byte	25
	.byte	71
	.byte	-91
	.byte	-5
	.byte	120
	.byte	38
	.byte	-60
	.byte	-102
	.byte	101
	.byte	59
	.byte	-39
	.byte	-121
	.byte	4
	.byte	90
	.byte	-72
	.byte	-26
	.byte	-89
	.byte	-7
	.byte	27
	.byte	69
	.byte	-58
	.byte	-104
	.byte	122
	.byte	36
	.byte	-8
	.byte	-90
	.byte	68
	.byte	26
	.byte	-103
	.byte	-57
	.byte	37
	.byte	123
	.byte	58
	.byte	100
	.byte	-122
	.byte	-40
	.byte	91
	.byte	5
	.byte	-25
	.byte	-71
	.byte	-116
	.byte	-46
	.byte	48
	.byte	110
	.byte	-19
	.byte	-77
	.byte	81
	.byte	15
	.byte	78
	.byte	16
	.byte	-14
	.byte	-84
	.byte	47
	.byte	113
	.byte	-109
	.byte	-51
	.byte	17
	.byte	79
	.byte	-83
	.byte	-13
	.byte	112
	.byte	46
	.byte	-52
	.byte	-110
	.byte	-45
	.byte	-115
	.byte	111
	.byte	49
	.byte	-78
	.byte	-20
	.byte	14
	.byte	80
	.byte	-81
	.byte	-15
	.byte	19
	.byte	77
	.byte	-50
	.byte	-112
	.byte	114
	.byte	44
	.byte	109
	.byte	51
	.byte	-47
	.byte	-113
	.byte	12
	.byte	82
	.byte	-80
	.byte	-18
	.byte	50
	.byte	108
	.byte	-114
	.byte	-48
	.byte	83
	.byte	13
	.byte	-17
	.byte	-79
	.byte	-16
	.byte	-82
	.byte	76
	.byte	18
	.byte	-111
	.byte	-49
	.byte	45
	.byte	115
	.byte	-54
	.byte	-108
	.byte	118
	.byte	40
	.byte	-85
	.byte	-11
	.byte	23
	.byte	73
	.byte	8
	.byte	86
	.byte	-76
	.byte	-22
	.byte	105
	.byte	55
	.byte	-43
	.byte	-117
	.byte	87
	.byte	9
	.byte	-21
	.byte	-75
	.byte	54
	.byte	104
	.byte	-118
	.byte	-44
	.byte	-107
	.byte	-53
	.byte	41
	.byte	119
	.byte	-12
	.byte	-86
	.byte	72
	.byte	22
	.byte	-23
	.byte	-73
	.byte	85
	.byte	11
	.byte	-120
	.byte	-42
	.byte	52
	.byte	106
	.byte	43
	.byte	117
	.byte	-105
	.byte	-55
	.byte	74
	.byte	20
	.byte	-10
	.byte	-88
	.byte	116
	.byte	42
	.byte	-56
	.byte	-106
	.byte	21
	.byte	75
	.byte	-87
	.byte	-9
	.byte	-74
	.byte	-24
	.byte	10
	.byte	84
	.byte	-41
	.byte	-119
	.byte	107
	.byte	53
	.ident	"GCC: (GNU) 8.2.0"
