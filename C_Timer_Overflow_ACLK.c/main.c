/*
  Timer Overflow using ACLK
*/

#include "intrinsics.h"
#include "msp430g2553.h"
#include <msp430.h>

int main(void)
{
  WDTCTL = WDTPW + WDTHOLD;             // Stop WDT
  // -- Setup Ports
  P1DIR |= BIT0;    // Set P1.0 to Output
  P1OUT &= ~BIT0;   // Clear LED

  // -- Setup Timer
  TA0CTL |= TACLR;    // Reset Timer
  TA0CTL |= TASSEL_1; // Choose ACLK
  TA0CTL |= MC_2;     // Put into Continuous Mode

  // -- Setup Timer Overflow IRQ
  TA0CTL |= TAIE;         // Local Enable for TA0 Overflow
  __enable_interrupt();   // Enable Global Maskable IRQs
  TA0CTL &= ~TAIFG;       // Clear Flag

  while(1){}              // Loop

  return 0;
}

//-- ISRs ------------------//
#pragma vector = TIMER0_A1_VECTOR
__interrupt void ISR_TA0_Overflow(void)
{
  P1OUT ^= BIT0;      // Toggle LED
  TA0CTL &= ~TAIFG;   // Clear Flag
}
