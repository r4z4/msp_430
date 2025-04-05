/*
  For Loops
*/

#include <msp430.h>

int main(void)
{
  WDTCTL = WDTPW + WDTHOLD;             // Stop WDT

  int i = 0;  // Need to declare loop var outside.
  int count = 0;

  while(1) 
  {
    for(i=0; i<10; i++)
    {
      count = i;
    }
  }

  return 0;
}

