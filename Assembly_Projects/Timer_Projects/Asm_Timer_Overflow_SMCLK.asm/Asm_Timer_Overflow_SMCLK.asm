; Timers. Toggling LED1 on TA0 Overflow Using SMCLK.
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

init:
;--- Setup LED
            bis.b   #BIT0, &P1DIR           ; LED1
            bic.b   #BIT0, &P1OUT           ; Clear LED1

;--- Setup Timer. 16Bit Control Registers = 16Bit Operations.
            bis.w   #TACLR, &TA0CTL         ; Reset Timer
            bis.w   #TASSEL_2, &TA0CTL      ; Choose SMCLK. 1 MHz.
            bis.w   #MC_2, &TA0CTL          ; Set to Coninuous Mode

;--- Setup IRQ
            bis.w   #TAIE, &TA0CTL          ; Local enable for overflow IRQ
            eint                            ; Global enable for maskable IRQs
            bic.w   #TAIFG, &TA0CTL         ; Clear Flag

main:

            jmp     main

;--------------------------
; Interrupt Service Routine
;--------------------------

ISR_TAO_Overflow:
            xor.b   #BIT0, &P1OUT           ; Toggle LED
            bic.w   #TAIFG, &TA0CTL         ; Clear Flag
            reti

;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;

            .sect  ".int08"                      ; TimerA0 Overflow Vector
            .short ISR_TAO_Overflow

            .end
