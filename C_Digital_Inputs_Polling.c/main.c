/*
  Digital Inputs & Polling.
*/

#include <msp430.h>

int main(void)
{
  WDTCTL = WDTPW + WDTHOLD;             // Stop WDT
  // & to clear, | to set
  // Setup Ports
  P1DIR |= BIT0;  // Set P1.0 to an Output
  P1OUT &= ~BIT0; // Clear LED. Need to ~ to Invert.

  P1DIR &= ~BIT3; // Clear Bit 3 of Port 1. Switch.
  P1REN |= BIT3;  // Enable Resistor
  P1OUT |= BIT3;  // Set Resistor to Pull Up

  int s1;

  while(1)
  {
    s1 = P1IN;  // Read Port 1
    // Clear all bits but bit 1
    s1 &= BIT3; 

    if (s1 == 0)
    {
      P1OUT |= BIT0;  // Turn on LED1
    }
    else 
    {
      P1OUT &= ~BIT0; // Turn off LED1
    }
  }

  return 0;
}

