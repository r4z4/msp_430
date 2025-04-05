; Program Flow Instructions. Conditional Negative-Based Jumps.
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
            mov.b   #0, R4                  ; R4 will contain value based on if

main:
            mov.b   #-1, R5
            tst.b   R5                      ; Subtracts 0 from operand. -1 - 0
                                            ; Will update status flag.
            jn      ItIsNegative
            jmp     ItIsPositive

ItIsNegative:
            mov     #1, R4
            jmp     main

ItIsPositive:
            mov     #1, R4
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
