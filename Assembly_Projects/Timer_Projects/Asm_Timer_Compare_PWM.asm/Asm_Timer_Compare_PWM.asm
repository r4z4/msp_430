; Timers. Toggling LED1 on TA0 using PWM Signal w/ 5% Duty Cycle
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
            bis.b   #BIT0, &P1DIR           ; LED
            bis.b   #BIT0, &P1OUT           ; Set it (Want it to start at 1)

;--- Setup Timer
            bis.w   #TACLR, &TA0CTL         ; Clear Timer A0
            bis.w   #TASSEL_1, &TA0CTL      ; Choose ACLK       
            bis.w   #MC_3, &TA0CTL          ; Put into UP Mode (Up/Down)

;--- Setup Compares
            mov.w   #32768, &TA0CCR0        ; Rollover Count
            mov.w   #1638, &TA0CCR1         ; Register that Will NOT rollover

;--- Setup IRQs
            bis.w   #CCIE, &TA0CCTL0        ; Local enable
            bic.w   #CCIFG, &TA0CCTL0       ; Clear CC
; Same bitmasks, but control registers change.
            bis.w   #CCIE, &TA0CCTL1        ; Local enable
            bic.w   #CCIFG, &TA0CCTL1       ; Clear CC

            eint                            ; Global Enable
main:

            jmp     main

;-----------------------------------------------
; Interrupt Service Routines
;-----------------------------------------------

ISR_TA0_CCR0:
            bis.b   #BIT0, &P1OUT           ; LED1 = 1
            bic.w   #CCIFG, &TA0CCTL0       ; Clear CCIFG Flag --IN CCR0--
            reti

ISR_TA0_CCR1: ;-- The one that flips it down to a 0
            bic.b   #BIT0, &P1OUT           ; LED1 = 0
            bic.w   #CCIFG, &TA0CCTL1       ; Clear CCIFG Flag --IN CCR1--
            reti

;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;

            .sect   ".int09"
            .short  ISR_TA0_CCR0

            .sect   ".int08"
            .short  ISR_TA0_CCR1

            .end
