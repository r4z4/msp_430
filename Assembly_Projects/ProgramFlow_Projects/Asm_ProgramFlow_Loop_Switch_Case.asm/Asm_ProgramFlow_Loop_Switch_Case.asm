; Program Flow Instructions. Switch/Case.
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

            mov.w   #0, R14                 ; R14 = VarIn
            mov.w   #0, R15                 ; R15 = VarOut

while:

switch:
            cmp.w   #0, R14                 ; if R14 == 0
            jz      Case0
            cmp.w   #1, R14
            jz      Case1
            cmp.w   #2, R14
            jz      Case2
            cmp.w   #3, R14
            jz      Case3
            jmp     Default
Case0:
            mov.w   #1, R15                 ; VarOut = 1
            jmp     end_swtich
Case1:
            mov.w   #2, R15
            jmp     end_switch
Case2:
            mov.w   #4, R15
            jmp     end_switch
Case3:
            mov.w   #8, R15
            jmp     end_switch
Default:
            mov.w   #0, R15
end_switch:

end_while:
            jmp while

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
