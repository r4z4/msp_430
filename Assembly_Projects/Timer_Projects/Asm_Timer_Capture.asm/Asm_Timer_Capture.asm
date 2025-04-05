; Timers. Capture.
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
;--- Setup Ports
            bis.b   #BIT0, &P1DIR           ; LED
            bic.b   #BIT0, &P1OUT           ; Set it (Want it to start at 1)

            bic.b   #BIT3, &P1DIR           ; P1.3 to Input (S1)
            bis.b   #BIT3, &P1REN           ; Enable Resistor
            bis.b   #BIT3, &P1OUT           ; Pull Up-Secondary Fn of P4OUT
            bis.b   #BIT3, &P1IES           ; IRQ Sensativity High->Low

;--- Setup IRQ for S1
            bis.w   #BIT3, &P1IE            ; Local enable
            eint                            ; Global Enable
            bic.b   #BIT3, &P1IFG           ; Clear Flag

;--- Setup Timer
            bis.w   #TACLR, &TA0CTL         ; Clear Timer A0
            bis.w   #TASSEL_1, &TA0CTL      ; Choose ACLK
            bis.w   #ID_3, &TA0CTL          ; Divide by 8 in 1st Stage
            bis.w   #MC_2, &TA0CTL          ; Put into Cont Mode 

;--- Setup Capture
            bis.w   #CAP, &TA0CCTL0         ; Put into Capture Mode
            bis.w   #CM_3, &TA0CCTL0        ; Both Edge Sensativity - When
                                            ; to do the capture.
            bis.w   #CCIS_2, &TA0CCTL0      ; Input signal = GND
;--- Init R4
            mov.w   #0, R4
main:   

            jmp     main

;-----------------------------------------------
; Interrupt Service Routines
;-----------------------------------------------
;--- ISR for the Switch, not the capture. We press switch, and it manually
; in software, cause transition on signal that triggers the interrupt.
ISR_S1:
            xor.b   #BIT0, &P1OUT           ; LED1 = 1
            xor.w   #CCIS_0, &TA0CCTL0      ; Toggle between GND/VCC
                                            ; CCIS_0 = LSB of CCIS
            mov.w   &TA0CCR0, R4            ; Store off value
            bic.b   #BIT3, &P1IFG           ; Clear Flag
            reti


;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;

            .sect   ".int02"                ; For Port 1
            .short  ISR_S1

            .end
