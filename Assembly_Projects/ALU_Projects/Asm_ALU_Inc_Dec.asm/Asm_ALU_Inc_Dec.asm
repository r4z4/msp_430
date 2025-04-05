; Data Maipulation Instructions. INC & DEC (and INCD and DECD)
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
                                            ; Doing this sequentially but often do this in loops for memory access.
            mov.w   #Consts, R5

            mov.b   @R5, R6                 ; Register indirect. "Use R5 as an address pointer". Grabs lower byte first (34 (not 12))
            INC     R5                      ; R5 was 2000, now 2001
            mov.b   @R5, R7
            INC     R5
            mov.w   @R5, R8                 ; Now at 2002, and getting whole 16bit word
            INCD    R5
            mov.w   @R5, R9

            jmp     main

;------------------------------------------------------------------------------
;           Memory Allocation
;------------------------------------------------------------------------------
            .data                           ; Go to data memory at 0x0200
            .retain                         ; Leave us alone

Consts:     .short  1234h
            .short  5678h
            .short  9ABCh
                                    
;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;
            .end
