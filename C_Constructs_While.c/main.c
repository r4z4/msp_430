/*
  While Loops
*/

#include <msp430.h>

int main(void)
{
  WDTCTL = WDTPW + WDTHOLD;             // Stop WDT
  
  int count = 0;                        // Like .short. Compiler choose where

  while(1) // Infinite Loop. Nice because we are an MCU.
  {
    count = count + 1;
  }

  return 0;
}

