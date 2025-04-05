; MOV instructions using Register Addressing Mode
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
            mov.w   PC, R4                  ; Copy PC into R4
            mov.w   R4, R5                  ; Copy R4 into R5
            mov.w   R5, R6                  ; Copy R5 into R6

            mov.b   PC, R7                  ; Copy LSB of PC into R7
            mov.b   R7, R8                  ; Copy LSB of R7 into R8
            mov.b   R8, R9                  ; Copy LSB of R8 into R9

            mov.w   SP, R10                 ; Copy SP into R10
            mov.w   R10, R11                ; Copy SP into R10
            mov.w   R11, R12                ; Copy SP into R10

            mov.b   SP, R13                 ; Copy SP into R10
            mov.b   R13, R14                ; Copy SP into R10
            mov.b   R14, R15                ; Copy SP into R10

            jmp     main
                                            ;
;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;
            .end
