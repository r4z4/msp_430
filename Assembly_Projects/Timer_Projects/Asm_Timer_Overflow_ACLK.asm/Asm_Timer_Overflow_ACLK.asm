; Timers. Toggling LED1 on TA0 Overflow Using ACLK
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
            bis.b   #BIT0, &P1DIR           ; Set P1DIR(0) to OUTPUT. LED1.
            bic.b   #BIT0, &P1OUT           ; Set initial value of LED1 = OFF

;--- Setup Timer A0. 16-Bit registers for 16-bit operations.
            bis.w   #TACLR, &TA0CTL             ; Clear TBO
            bis.w   #TASSEL_1, &TA0CTL          ; Choose A Clock
            bis.w   #MC_2, &TA0CTL              ; Put into Continuous Mode

;--- Setup Overflow IRQs
            bis.w   #TAIE, &TA0CTL          ; Local enable for TAx overflow
            eint                            ; Enable global maskables
            bic.w   #TAIFG, &TA0CTL         ; Clear flag for first use
main:
            jmp     main

;-----------------------------------------------
; Interrupt Service Routines
;-----------------------------------------------

ISR_TA0_Overflow:
            xor.b   #BIT0, &P1OUT           ; Toggle LED1
            bic.w   #TAIFG, &TA0CTL         ; Clear flag
            reti

;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;

            .sect   ".int08"                ; TIMER0_A0 Vector Address
            .short  ISR_TA0_Overflow
            .end
