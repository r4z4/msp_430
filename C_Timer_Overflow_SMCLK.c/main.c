/*
  Timer Overflow using SMCLK.
*/

#include "intrinsics.h"
#include "msp430g2553.h"
#include <msp430.h>

int main(void)
{
  WDTCTL = WDTPW + WDTHOLD;             // Stop WDT

  // -- Setup Ports
  P1DIR |= BIT0;
  P1OUT &= ~BIT0;

  // -- Setup Timers
  TA0CTL |= TACLR;      // Reset TA0
  TA0CTL |= TASSEL_2;   // Choose SMCLK
  TA0CTL |= MC_2;       // Continuous Mode
  
  // -- Setup Overflow IRQ
  TA0CTL |= TAIE;       // Local Interrupt
  __enable_interrupt(); // Global Interrupt
  TA0CTL &= ~TAIFG;     // Clear Flag
  
  while(1){}
  
  return 0;
}

//-- ISRs-------------------------//
#pragma vector = TIMER0_A1_VECTOR
__interrupt void ISR_A0_Overflow(void)
{
  P1OUT ^= BIT0;
  TA0CTL &= ~TAIFG;
}
