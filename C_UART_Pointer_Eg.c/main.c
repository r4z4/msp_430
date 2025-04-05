/*
  UART Pointer Eg
*/

#include "intrinsics.h"
#include "msp430g2553.h"
#include <msp430.h>

int a[5] = {1,2,3,4,5};
int *pnt_a;   // Define pointer
void main(void)
{
  WDTCTL = WDTPW + WDTHOLD;             // Stop WDT
  pnt_a = a;      // Assign memory address of int array a to pointer
  *pnt_a = 2021;  // *pnt_a Means content of memory address. So here
                  // we are updating the memory slot that pnt_a is
                  // referring to w/ integer value 2021
  pnt_a += 3;     // Increase value of pointer itself, not the content
  *pnt_a = 0;     // Update content of that memory address w/ 0
  pnt_a = a;      // Reset pointer address to arrays address once again
  while(1);
}