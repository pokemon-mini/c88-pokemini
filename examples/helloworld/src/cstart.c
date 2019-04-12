 /*
  *	@(#)cstart.c	1.20
  *	SMC88 Startup code
  *	Default, exit code will loop forever.
  *
  *	DEFINES to tune this startup code:
  *
  *		COPY (default)	-> produce code to clear 'CLEAR' sections AND initialize 'INIT' sections,
  *				   'CLEAR' and 'INIT' segments do not have to be consecutive
  *
  *	On exit the program will fall into an endless loop.
  */

void			_exit	( int );
void			_start	( void );
extern int		main	( void );
extern void		_copytable( void );

#pragma asm
DEFSECT ".min_header", CODE
    SECT ".min_header"
    ASCII "MN"
    LD NB,#0
    JRL __START
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    LD NB,#0
    JRL __BAD_IRQ
    ASCII "NINTENDO"
    ASCII "HELO"
    ASCII "HELLO WORLD!"
    ASCII "2P"
    DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
__BAD_IRQ:
    JR __BAD_IRQ
#pragma endasm

_interrupt( 0x0000 )	/* Startup vector */
void _start_cpt( void )
{
	#pragma asm

	GLOBAL	__START
	__START:

	;==========================================================================
	;===================  system initialization  ==============================
	;==========================================================================
	LD	SP,#02000h			; stack pointer initialize
	LD	BR,#020h			; BR register initialize to I/O area
	LD	[BR:21h],#0Ch
	LD	[BR:25h],#080h
	LD	[BR:80h],#08h
	LD	[BR:81h],#08h
	;LD	[BR:81h],#09h

    LD SC, #0h

	LD	[BR:27h],#0FFh
	LD	[BR:28h],#0FFh
	LD	[BR:29h],#0FFh
	LD	[BR:2Ah],#0FFh

    ;EXTERN  (DATA,TINY)__lc_b_.tbss		;BR is used for tiny data
    ;LD	BR,#(@DOFF(__lc_b_.tbss) >> 8)

	#pragma endasm

	/* Use copy table to clear memory and intialize data */
    _copytable();		/* routine is found in library */

    _exit( main() );	/* Stops program in an endless loop */
    //main();
}

_interrupt (30)
void power_button(void) 
{
	#pragma asm
	LD	[BR:029h],#080h
	BIT	[BR:052h],#080h
	JRL	NZ, power_out
	INT	[048H]
power_out:
	#pragma endasm
}

void
_exit( int i )	/* 'i' is parameter in BA */
{
    i = 0;
    #pragma asm
    INT	[048H]
    #pragma endasm
}


#pragma asm
	DEFSECT	".tbss", DATA, TINY, CLEAR
	SECT	".tbss"
#pragma endasm
