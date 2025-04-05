/*
  If/Else
*/

#include <msp430.h>

int main(void)
{
  WDTCTL = WDTPW + WDTHOLD;             // Stop WDT

  int i = 0;  // Need to declare loop var outside.
  int it_is_TWO = 0;

  while(1) 
  {
    for(i=0; i<5; i++)
    {
      if(i == 2)
      {
        it_is_TWO = 1;
      } 
      else
      {
        it_is_TWO = 0;
      }
    }
  }

  return 0;
}

