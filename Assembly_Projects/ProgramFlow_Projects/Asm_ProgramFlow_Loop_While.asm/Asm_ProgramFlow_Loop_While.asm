; Program Flow Instructions. While Loops.
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

while1:                                     ; While(Var1 == 3)
            cmp.w   #3, Var1                ; If Var1 == 3, stay in loop
                                            ; Var is label of where info resides
                                            ; Will take that value - 3
            jnz     end_while1              ; This is if result !== 3
                                            ; and we get out of loop

            mov.w   #1, Var2
            jmp     while1                  ; jump always back to while1, where
                                            ; we do boolean check for condition
end_while1:

while2:
            mov.w   #2, Var2
            jmp     while2
end_while2:

;------------------------------------------------------------------------------
;           Memory Allocation
;------------------------------------------------------------------------------
            .data                           ; Go to data memory at 0x0200
            .retain                         ; Leave us alone

Var1:       .short  3                       ; .short = 16bit word. Goes into
                                            ; memory (hex) as 0003h - 16bits.
                                            ; Or in binary its binary 3
                                            ; w/ rest of bits being 0.
Var2:       .space  2                       ; Reserve 2 bytes - 16 bits
                                    
;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;
            .end
