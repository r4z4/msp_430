; Data Maipulation Instructions. Rotate Operations. (Arithmetic) RLA, RRA.
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
                                            
            mov.b   #00000001b, R4          
            clrc                            ; C=0. Clear carry flag to be sure.
            rla.b   R4
            rla.b   R4
            rla.b   R4
            rla.b   R4
            rla.b   R4
            rla.b   R4
            rla.b   R4
            rla.b   R4
            rla.b   R4

            mov.b   #10000000b, R5          
            clrc                            ; C=0. Clear carry flag to be sure.
            rra.b   R5
            rra.b   R5
            rra.b   R5
            rra.b   R5
            rra.b   R5
            rra.b   R5
            rra.b   R5
            rra.b   R5
            
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
