; Program Flow Instructions. If/Else.
;******************************************************************************
 .cdecls C,LIST,  "msp430.h", "msp430g2553.h"
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.

;------------------------------------------------------------------------------
            .text                           ; Progam Start
;------------------------------------------------------------------------------
RESET       mov.w   #0280h,SP               ; Initialize stackpointer
StopWDT     mov.w   #WDTPW+WDTHOLD,&WDTCTL  ; Stop WDT

            mov.w   #0, R15                 ; R15 = Cnt1
while:

if:
            cmp.w   #10, R15                ; If these equal Z flag asserted
            jnz     else                    ; So if so, we jump to else

            mov.w   #0, R15
            jmp     end_if
else:
            inc.w   R15                     ; Dont need to jump to end_if
                                            ; b/c we get there anywhere as
                                            ; it is next instruction
end_if:

end_while:
            jmp     while

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
