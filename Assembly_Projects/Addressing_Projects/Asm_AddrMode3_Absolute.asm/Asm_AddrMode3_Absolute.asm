; MOV instructions using Indriect Auto Increment Mode
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
            
            mov.w   #0200h, R4              ; Using IMMEDIATE addressing.
            mov.w   @R4, R5                 ; @R4 == "R4 contains address of info I want to use as the src". 
                                            ;Telling assembler to use R4 as an address pointer.

            jmp     main

;--------------------
; Memory Allocation
;--------------------

            .data                           ; Go to data memory
            .retain                         ; Don't optimize this, we're learning.

                                            ; These happen at download. These are not instructions.
                                            ; .short sets up a 16 bit constant downloaded to addr (here 0200h) when download program
Const1:     .short      0DEADh              ; Setup constant DEADh. This will be at 0200. We said go to data memory which is 0200 hex.
Const2:     .short      0BEEFh              ; Setup constant BEEF

                                            
;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;
            .end
