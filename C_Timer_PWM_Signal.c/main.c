/*
  Timer - PWM Signals. Used to control motors. Pulse w/ Modulated Signal.
*/

#include "intrinsics.h"
#include "msp430g2553.h"
#include <msp430.h>

int main(void)
{
  WDTCTL = WDTPW + WDTHOLD;             // Stop WDT
  //-- Setup Ports
  P1DIR |= BIT0;  // LED1
  P1OUT |= BIT0;  // Set to 1. We want it on.

  //--Setup Timers
  TA0CTL |= TACLR;      //Clear
  TA0CTL |= TASSEL_1;   //Choose ACLK
  TA0CTL |= MC_3;       //Put into UP Mode
  TA0CCR0 = 32768;      // Set PWM Period. Capture/Compare Regsiter 0
  TA0CCR1 = 1638;       // Set PWM Duty Cycle. Captuer/Compare Register 1.
  
  //--Setup Compare IRQs
  TA0CCTL0 |= CCIE;     // Local Enable for CCR0
  TA0CCTL1 |= CCIE;     // Local Enable for CCR1 
  __enable_interrupt(); // Global Enable
  TA0CCTL0 &= ~CCIFG;   // Clear Flag for CCR0
  TA0CCTL1 &= ~CCIFG;   // Clear Flag for CCR1

  while(1){};           // Loop

  return 0;
}

//-- ISRs ------------------------------------------------------
// CCR0
#pragma vector = TIMER0_A0_VECTOR
__interrupt void ISR_TA0_CCR0(void)
{
  P1OUT |= BIT0;        // Turn LED on
  TA0CCTL0 &= ~CCIFG;   // Clear Flag
}

// Duty Cycle
#pragma vector = TIMER0_A1_VECTOR
__interrupt void ISR_TA0_CCR1(void)
{
  P1OUT &= ~BIT0;     // Clear. Turn off.
  TA0CCTL1 &= ~CCIFG;  // Clear Flag
}
