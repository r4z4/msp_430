; Data Maipulation Instructions. Logic Instructions - INV, OR, AND, XOR
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
                                            
            mov.b   #10101010b, R4          ; Binary # into R4
            inv.b   R4                      ; Invert it

            mov.b   #11110000b, R5
            and.b   #00111111b, R5          ; Clear bits 6 and 7 (0 indexed)

            mov.b   #00010000b, R6          
            and.b   #10000000b, R6          ; Is bit 7 a 1 or a 0? Our Mask

            mov.b   #00010000b, R7          
            and.b   #00010000b, R7          ; Is bit 4 a 1 or a 0? Our Mask

            mov.b   #11000001b, R8          
            or.b    #00011111b, R8          ; Set lower 5 bits leave top 3 alone

            mov.b   #01010101b, R9          
            xor.b   #11110000b, R9          ; Toggle upper 4 bits
            xor.b   #00001111b, R9          ; Toggle lower 4 bits


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
