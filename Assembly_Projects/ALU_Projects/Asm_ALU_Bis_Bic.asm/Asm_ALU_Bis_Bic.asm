; Data Maipulation Instructions. Test Instructions. BIT, CMP, TST
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
                                            
            mov.b   #00010000b, R4          ; Initialize R4 w/ value
            bit.b   #10000000b, R4          ; "Is bit 7 a 1?".
                                            ; Result here is 00000000
                                            ; So Z flag will be asserted
            bit.b   #00010000b, R4          ; "Is bit 4 a 1?"
                                            ; Result in 00010000,
                                            : Z flag is not asserted

            mov.b   #99, R5
            cmp.b   #99, R5                 ; CMP subtracts. Z will = 1
            cmp.b   #77, R5                 ; Z will = 0. 99 - 73 is not 0.
                                            ; Z flag not asserted.

            mov.b   #-99, R6                
            tst.b   R6                      ; Will subtract 0 from R6 and
                                            ; Update status flags. Z & N is
                                            ; What we care about here.
            

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
