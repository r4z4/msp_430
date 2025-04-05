; Digital IO Instructions. Blink LED.
;******************************************************************************
 .cdecls C,LIST,  "msp430.h"
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.

;------------------------------------------------------------------------------
            .text                           ; Progam Start
;------------------------------------------------------------------------------
RESET       mov.w   #0280h,SP               ; Initialize stackpointer
StopWDT     mov.w   #WDTPW+WDTHOLD,&WDTCTL  ; Stop WDT

init:


            bis.b   #BIT0, &P1DIR           ; Set P1DIR(0) to OUTPUT
                                            ; 8 bit ports, so bitwise ops
            ; bic.b   #LOCKLPM5, &PM5CTL0   ; Takes IO System out of LPM
                                            ; Turns on Digital IO system
main:

            bis.b   #BIT0, &P1OUT           ; Turn on LED1 (P1.0)
            bic.b   #BIT0, &P1OUT           ; Turn off LED1 (P1.0)
            jmp     main
                                    
;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;
            .end
