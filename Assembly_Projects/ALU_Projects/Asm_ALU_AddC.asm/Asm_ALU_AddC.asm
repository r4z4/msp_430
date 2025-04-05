; Data Maipulation Instructions. ALU. Add.
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
            
            mov.w   #371, R4                ; Put 371 into R4
            mov.w   #465, R5                ; Put 465 into R5
            add.w   R4, R5                  ; R5 = R4 + R5. We will blow away value in R5.

            mov.w   #0FFFEh, R6             ; Put FFFE into R6
            add.w   #0001h, R6              ; R6 gets 1 + R6

            mov.w   #0FFFFh, R7             ; Put FFFFh into R7
            add.w   #1h, R7                 ; #1h is same as #0001h. R7 = 1 + R7

            mov.b   #255, R8
            mov.b   #1, R9
            add.b   R8, R9

            mov.b   #-1, R10
            add.b   #1, R10

            mov.b   #127, R11
            add.b   #127, R11
            
            jmp     main

                                            
;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;
            .end
