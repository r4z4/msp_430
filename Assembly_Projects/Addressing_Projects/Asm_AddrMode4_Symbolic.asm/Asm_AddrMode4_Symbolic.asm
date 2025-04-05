; MOV instructions using Symbolic Mode
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
            
            mov.w   Const1, R4              ; We can put it in directly, but we go into R4 so we can watch it
            mov.w   R4, Var1                ; Copy R4 into addr 2004

            mov.w   Const2, R5
            mov.w   R5, Var2                ; Copy R5 into addr 2006

            jmp     main

;--------------------
; Memory Allocation
;--------------------

            .data                           ; Go to data memory
            .retain                         ; Don't optimize this, we're learning.

                                            ; These happen at download. These are not instructions.
Const1:     .short      1234h               ; Setup constant 1234h. This will be at 2000. We said go to data memory which is 2000 hex.
                                            ; .short sets up a 16 bit constant downloaded to addr (here 2000h) when download program
Const2:     .short      0CAFEh              ; Setup constant CAFE
                                            ; Now lets reserve two words of memory at 2004/6
Var1:       .space      2                   ; Issue here is we needed to know the addr. We look at data sheet and data memory starts at 2000.
                                            ; We are needing to keep track of it and know how we are allocating it. We just know its 2004h.
Var2:       .space      2                   ; Reserve 2 Bytes. We know its 2006h because its 2004h + 2
                                            
;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;
            .end
