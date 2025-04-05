/*
  Digital Outputs
*/

#include <msp430.h>

int main(void)
{
  WDTCTL = WDTPW + WDTHOLD;             // Stop WDT
  // Setup Ports
  P1DIR |= BIT0;            
  /*
  Configure P1.0 As Output. Bit 0 is a mask. 0000000000000001. Use that Mask and perform a BitWise OR (|) on P1DIR and assign it back to P1DIR
  */       
  P1OUT &= ~BIT0;   // Turn LED1 Off. (Need to use ~ to Invert)

  int i = 0;

  while(1)
  {
    P1OUT ^= BIT0;    // Turn LED1 On. Set Bit0 in P1OUT
    for (i = 0; i < 0xFFFF; i++) 
    {
      // Do nothing. Just count then exit.
    }
  }

  return 0;
}

