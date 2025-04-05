; Program Flow Instructions. Conditional Carry-Based Jumps.
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
                                            ; Jump taken or not. Our tracker 
main:
            mov.b   #254, R5                ; MOV does not alter status flags,
                                            : but ADD instructions do.
            add.b   #1, R5                  ; 254 + 1 = 255, and C = 0
            jc      CarrySet                ; Jump if Carry set
                                            ; If condition not met, just marches
            jnc     CarryClear
CarrySet:
            mov.b   #1, R4                  ; Put 1 in R4 if Carry set
            jmp     main
CarryClear:
            mov.b   #2, R4           
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
