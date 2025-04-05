; Digital IO Instructions. Inputs & Polling.
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
            bis.b   #BIT0, &P1DIR           ; Set P1DIR(0) to OUTPUT
            bic.b   #BIT0, &P1OUT           ; Set initial value of LED1 = OFF

            bic.b   #BIT3, &P1DIR           ; Set P1.3 as input. P1.3 = S1
            bis.b   #BIT3, &P1REN           ; Enable Up/Down Resistor on P1.3
            bis.b   #BIT3, &P1OUT           ; Configure resistor as Pullup
                                            ; When set to input, the Output pin
                                            ; acts as Up/Down configurer
main:

poll_s1:
            bit.b   #BIT3, &P1IN            ; Will AND the address with a 
                                            ; bitmask. Check Z flag. If 1, means
                                            ; Nobody has pressed button since
                                            ; pullup resistor is pulling it up
            jnz     poll_s1

toggle_led1:
            xor.b   #BIT0, &P1OUT           ; Toggle LED1
            
            mov.w   #0FFFFh, R4             ; Out loop var to dec. a big #
delay:
            dec.w   R4
            jnz     delay                   ; Only exits & goes onto main when 0

            jmp     main
                                    
;------------------------------------------------------------------------------
;           Interrupt Vectors
;------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET                   ;
            .end
