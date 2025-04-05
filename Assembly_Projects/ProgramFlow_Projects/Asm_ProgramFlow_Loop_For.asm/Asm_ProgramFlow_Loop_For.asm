; Program Flow Instructions. For Loops.
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

            mov.w   #0, R4                  ; this is our i. i=0
for1:
            mov.w   R4, Var1

            inc     R4
            cmp.w   #4, R4
            jnz     for1

; ----------------------------------------------------------------
            mov.w   #10, R4
for2:
            mov.w   R4, Var1

            decd    R4
            tst.w   R4                      ; Could also do `cmp.w #0, R4`
            jge     for2
                                     
            jmp     main

;------------------------------------------------------------------------------
;           Memory Allocation
;------------------------------------------------------------------------------
            .data                           ; Go to data memory at 0x0200
            .retain                         ; Leave us alone

Var2:       .space  2                       ; Reserve 2 bytes - 16 bits
                                            ; Will be at starting addr of data
                                    
;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;
            .end
