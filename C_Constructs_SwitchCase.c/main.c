/*
  Switch/Case
*/

#include <msp430.h>

int main(void)
{
  WDTCTL = WDTPW + WDTHOLD;             // Stop WDT

  int i = 0;  // Need to declare loop var outside.
  int it_is_ONE = 0; // Assert when == 1
  int it_is_TWO = 0; // Assert when == 2

  while(1) 
  {
    for(i=0; i<5; i++)
    {
      switch(i) 
      {
        case 1:   it_is_ONE = 1;
                  it_is_TWO = 0;
                  break;
        case 2:   it_is_ONE = 0;
                  it_is_TWO = 1;
                  break;
        default:  it_is_ONE = 0;
                  it_is_TWO = 0;
                  break;
      }
    }
  }

  return 0;
}

