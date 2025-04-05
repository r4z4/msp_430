; Timers. Toggling LED1 on TA0 Overflow Using SMCLK. Divide the Clock by 4.
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
;--- Setup LEDs
            bis.b   #BIT0, &P1DIR       ; LED1
            bis.b   #BIT6, &P1DIR       ; LED2 (P1.3)
            bic.b   #BIT0, &P1OUT       ; Clear LED1
            bis.b   #BIT6, &P1OUT       ; Set LED2

;--- Setup Timer
            bis.w   #TACLR, &TA0CTL     ; Clear Timer A0
            bis.w   #TASSEL_2, &TA0CTL  ; Choose SMCLK
            bis.w   #ID_2, &TA0CTL      ; Div 4 in First Divider Stage
            bis.w   #MC_2, &TA0CTL      ; Put into Continuous Mode

;--- Setup IRQ
            bis.w   #TAIE, &TA0CTL      ; Local Enable for Overflow
            eint                        ; Global Enable Maskable Interrupts
            bic.w   #TAIFG, &TA0CTL     ; Clear Flag

main:

            jmp     main

;--------------------------
; Interrupt Service Routine
;--------------------------

ISR_TAO_Overflow:
            xor.b   #BIT0, &P1OUT           ; Toggle LED1
            xor.b   #BIT6, &P1OUT           ; Toggle LED2
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
