; MOV instructions using Indexed Mode (Using an Offset)
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
            
            mov.w   #Block1, R4             ; Address of where start accessing memory into register.
            mov.w   0(R4), 8(R4)            ; 0(R4) is the src. We have no offset here. Then copying to 8 address away from R4 
            mov.w   2(R4), 10(R4)
            mov.w   4(R4), 12(R4)
            mov.w   6(R4), 14(R4)

            jmp     main

;--------------------
; Memory Allocation
;--------------------

            .data                           ; Go to data memory
            .retain                         ; Don't optimize this, we're learning.

                                            ; These happen at download. These are not instructions.
                                            ; Now create a block of memory. Can do this on one line. Comma delimit sequence of #s
                                            ; Puts immediately after the prior in data memory

Block1:     .short      0AAAAh, 0BBBBh, 0CCCCh, 0DDDDh   ; Create a block of constants       
                                            ; Also need to reserve 4 words to copy into
Block2:     .space      8

                           
;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;
            .end
