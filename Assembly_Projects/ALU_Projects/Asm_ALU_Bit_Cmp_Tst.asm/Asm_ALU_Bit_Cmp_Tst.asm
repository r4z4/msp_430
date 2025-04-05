; Data Maipulation Instructions. BitSet and BitClear. BIS & BIC.
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
                                            
            mov.b   #00000000b, R4          ; R4 = 0
            bis.b   #10000001b, R4          ; This is the mask.
                                            ; Set the outer bits (0,7).
            bis.b   #01000010b, R4
            bis.b   #00100100b, R4
            bis.b   #00011000b, R4          ; At this point, asserted all bits.
                                            ; Now clear them. Start w/ inner.
            bic.b   #00011000b, R4
            bic.b   #00100100b, R4
            bic.b   #01000010b, R4
            bic.b   #10000001b, R4

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
