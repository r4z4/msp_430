/*
  Timer Capture.
*/
#include "intrinsics.h"
#include "msp430g2553.h"
#include <msp430.h>

int whatWeCaptured = 0;

int main(void)
{
  WDTCTL = WDTPW + WDTHOLD;             // Stop WDT

  //-- Setup Ports
  P1DIR |= BIT0;    // LED as Output
  P1OUT &= ~BIT0;   // Clear LED
  P1DIR &= ~BIT3;   // S1 As Input. S1 = P1.3
  P1REN |= BIT3;    // Resistor Enable Pull Up/Down
  P1OUT |= BIT3;    // Choose UP Resistor
  P1IES |= BIT3;    // Set IRQ Sensativity to High->Low

  //-- Setup Port IRQ
  P1IE |= BIT3;         // Local Enable for P1.3 (S1)
  __enable_interrupt(); // Global Enable
  P1IFG &= ~BIT3;       // Clear Flag

  //-- Setup Timer
  TA0CTL |= TACLR;      // Clear Timer
  TA0CTL |= MC_2;       // Continuous Mode
  TA0CTL |= TASSEL_1;   // Choose ACLK
  TA0CTL |= ID_3;       // Divide by 8

  //-- Setup Capture
  TA0CCTL0 |= CAP;      // Put CCR0 into Capture Mode
  TA0CCTL0 |= CM_3;     // Sensativity to Both Edges
  TA0CCTL0 |= CCIS_2;   // Set initial signal to GND

  while(1){};

  return 0;
}

//-- ISRs --------------------
#pragma vector = PORT1_VECTOR
__interrupt void IS_Port1_S1(void)
{
  P1OUT ^= BIT0;            // Toggle LED
  TA0CCTL0 ^= CCIS_0;       // Toggle between GND and VCC
  whatWeCaptured = TA0CCR0; // Can see it in regsiter, and here too :)
  P1IFG &= ~BIT3;           // Clear P1.3 Flag
}
