; Data Maipulation Instructions. ALU. AddC - Add with  Carry
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
            
            mov.w   #Var1, R4
            mov.w   #Var2, R5
            mov.w   #Sum12, R6              ; Now we have three address pointers set up, 
                                            ; that we can use to access our block of memory

            mov.w   0(R4), R7               ; This will get FFFF
            mov.w   0(R5), R8               ; This will get 2222
            add.w   R7, R8

                                            ; Need to consider the carry in our higher byte

            mov.w   R8, 0(R6)
            mov.w   2(R4), R7               ; Get E371. The higher bits. @ offset from the start of the 16bit word.
                                            ; The first 8 bits are at 0(R4)
            mov.w   2(R5), R8               ; R5 is holding address of Var2.
            addc.w  R7, R8                  ; Add upper 16 bits with carry
            mov.w   R8, 0(R6)

            jmp     main

;------------------------------------------------------------------------------
;           Meory Allocation
;------------------------------------------------------------------------------
            .data   ".reset"                ; Go to data memory at 0x0200
            .retain                         ; Leave us alone

Var1:       .long   0E371FFFFh              ; .long = 32bit word. 0 b/c cannot start w/ letter
Var2:       .long   11112222h               
Sum12:      .space  4                                      
;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;
            .end
