/*
  Timer Compares.
*/

#include "intrinsics.h"
#include "msp430g2553.h"
#include <msp430.h>

int main(void)
{
  WDTCTL = WDTPW + WDTHOLD;             // Stop WDT
  //-- Setup Ports
  P1DIR |= BIT0;  // LED
  P1OUT &= ~BIT0; // Clear P1.0

  //-- Setup Timers
  TA0CTL |= TACLR;      // Reset TA0
  TA0CTL |= MC_3;       // Put into UP Mode
  TA0CTL |= TASSEL_1;   // Choose ACLK
  TA0CCR0 = 16384;      // Set CCR0
  
  //-- Setup Timer Compare IRQ
  TA0CCTL0 |= CCIE;       // Local Enable
  __enable_interrupt();   // Global Enable
  TA0CCTL0 &= ~CCIFG;     // Clear Flag

  while(1){}              // Loop

  return 0;
}
#pragma vector = TIMER0_A0_VECTOR      // ".int09"
__interrupt void ISR_TA0_CCRO(void)
{
  P1OUT ^= BIT0;      // Toggle LED
  TA0CCTL0 &= ~CCIFG; // Clear Flag
}

