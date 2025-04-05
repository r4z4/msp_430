; Stack Instructions. Subroutines.
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

main:
            mov.w   #0AAAAh, R4
            call    #compliment_it

            mov.w   #0BBBBh, R4
            call    #compliment_it

            mov.w   #0CCCCh, R4
            call    #compliment_it

            jmp     main

;-------------------------------------------
;           Subroutines
;--------------------------------------------
compliment_it:
                inv.w   R4
                ret
;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;
            .end
