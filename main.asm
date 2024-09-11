#include "ez80f92.inc"


	.ASSUME	ADL = 1

    ORG     0x00000

	JP		_MOS_INIT

	ALIGN	64			; The executable header is from byte 64 onwards

	DB		"MOS"		; Flag for MOS - to confirm this is LD valid MOS command
	DB		0x00		; MOS header version 0
	DB		0x01		; Flag for run mode (0: Z80, 1: ADL)


_MOS_INIT:

	LD 		SP,	0xBFFFF	; Initialize the stack pointer

	PUSH	AF			; Preserve registers
	PUSH	BC
	PUSH	DE
	PUSH	IX
	PUSH	IY			; Need to preserve IY for MOS

	LD		A,	MB		; Save MB
	PUSH 	AF
	XOR 	A
	LD 		MB,	A		; Clear to zero so MOS API calls know how to use 24-bit addresses.

	CALL	_MAIN

	POP 	AF
	LD		MB,	A

	POP		IY			; Restore registers
	POP		IX
	POP		DE
	POP 	BC
	POP		AF
	RET


_MAIN:
	;DI					; disable interrupts

	CALL	UART0_INIT
	CALL	UART1_INIT


_LOOP:

	LD		HL, s_HELLORD
	CALL	SER_PRINT

	LD		HL, s_HELLORD
	CALL	VDP_PRINT


	;RET
	JP _LOOP


#include	"ez80.inc"
#include	"uart.inc"
#include	"print.inc"


s_HELLORD:	DB 	" HELLORD!!!\r\n", 0
h_RESULT:	DB	0,	0


_END:	JP	_END

