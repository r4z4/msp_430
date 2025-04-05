/*
  Arithmetic
*/

#include <msp430.h>

int main(void)
{
  WDTCTL = WDTPW + WDTHOLD;             // Stop WDT
  
  int a = 2; 
  int b = 3; 
  int c = 4; 
  int d = 5;                        

  while(1)
  {
    b = a + b;      // ADD.w  a, b
    d = c - d;

    b = b + 1;
    b++;

    d = d - 1;
    d--;
  }

  return 0;
}

