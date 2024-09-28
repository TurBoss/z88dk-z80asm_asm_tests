#include "ez80f92.inc"


	ASSUME	ADL = 1

    ORG     0x40000

	call	_INIT


_INIT:

    LD		SP,	0BFFFFh

	CALL	_MAIN

	RET


_MAIN:
	DI					; disable interrupts

	CALL	EZ80_INIT

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

