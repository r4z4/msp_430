; MOV instructions using Immediate Addressing Mode
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
            
            mov.w   #Block1, R4             ; Set up initial address pointer. Immedate addressing on Block1.
            mov.w   @R4+, R5                ; Will use address that is in R4 as an address pointer. 
                                            ; After it gets it, it will incrememt. Inc by 2 since we did .w
            mov.w   @R4+, R6
            mov.w   @R4+, R7

            jmp     main

;--------------------
; Memory Allocation
;--------------------

            .data                           ; Go to data memory
            .retain                         ; Don't optimize this, we're learning.

                                            ; These happen at download. These are not instructions.
                                            ; Now create a block of memory. Can do this on one line. Comma delimit sequence of #s
                                            ; Puts immediately after the prior in data memory
Block1:     .short      1122h, 3344h, 5566h, 7788h, 99AAh   ; Create a block of constants         

                           
;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;
            .end
