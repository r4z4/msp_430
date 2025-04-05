; Interrupts. Port Interrupts
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

init:
            bis.b   #BIT0, &P1DIR           ; Set P1DIR(0) to OUTPUT. LED1.
            bic.b   #BIT0, &P1OUT           ; Set initial value of LED1 = OFF

            bic.b   #BIT3, &P1DIR           ; Set P1.3 as input. P1.3 = S1
            bis.b   #BIT3, &P1REN           ; Enable Up/Down Resistor on P1.3
            bis.b   #BIT3, &P1OUT           ; Configure resistor as Pullup
                                            ; Secondary function of P1OUT
            bis.b   #BIT3, &P1IES           ; Sensativity high -> low

            bic.b   #BIT3, &P1IFG           ; Clear Port1 Interrupt Flag
            bis.b   #BIT3, &P1IE            ; Local enable for P1.3
            bis.w   #GIE, SR                ; Enable global maskables. Could
                                            ; also just use `eint`

main:
            jmp     main

;-----------------------------------------------
; Interrupt Service Routines
;-----------------------------------------------

ISR_S1:
            xor.b   #BIT0, &P1OUT           ; Toggle LED1
            bic.b   #BIT3, &P1IFG           ; Clear flag
            reti

;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;

            .sect   ".int02"                ; Port 1 Vector Address
            .short  ISR_S1
            .end
