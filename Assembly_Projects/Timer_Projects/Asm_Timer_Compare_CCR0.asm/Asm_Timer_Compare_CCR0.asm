; Timers. Toggling LED1 on TA0 using Compare Registers.
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
            bic.b   #BIT0, &P1OUT           ; LED Off to Start

;--- Setup Timer
            bis.w   #TACLR, &TA0CTL         ; Clear Timer
            bis.w   #TASSEL_1, &TA0CTL      ; Choose ACLK
            bis.w   #MC_3, &TA0CTL          ; Put into UP Mode (Up/Down)

;--- Setup Compare. Put 16384 so that it counts up to that.
            mov.w   #16384, &TA0CCR0        ; Setup Compare Value.
            bis.w   #CCIE,  &TA0CCTL0       ; Config Reg for Capture Reg
                                            ; This is the local enable
            eint                            ; Global Enable
            bic.w   #CCIFG, &TA0CCTL0       ; Clear CCIFG Flag

main:

            jmp     main

;-----------------------------------------------
; Interrupt Service Routines
;-----------------------------------------------

ISR_TA0_CCR0:
            xor.b   #BIT0, &P1OUT           ; Toggle LED1
            bic.w   #CCIFG, &TA0CCTL0       ; Clear CCIFG Flag
            reti

;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;

            .sect   ".int09"
            .short  ISR_TA0_CCR0

            .end
