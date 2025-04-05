/*
  Bitwise Logic
*/

#include <msp430.h>

int main(void)
{
  WDTCTL = WDTPW + WDTHOLD;             // Stop WDT
  
  int e = 0b1111111111110000;  // 16 Bit Word
  int f = 0x0001;              // 16 Bit Word

  while(1)
  {
    e = ~e;                     // Invert all bits in e. 0000000000001111
    // e = e | 0b0000000010000000; // Set Bit 7 in e.       0000000010001111. 
    // Showing same as below
    e = e | BIT7;               // Set Bit 7 in e.       0000000010001111

    e = e & ~BIT0;              // Clear Bit 0 in e.     0000000010001110
                                // ~ Takes Bit 0 Mask (0000000000001111) ->
                                //(1111111111111110) which is proper mask
    e = e ^ BIT4;               // Toggle Bit 4.         0000000010011110

    // Now using Shorthand
    e |= BIT6;      // Much easier. Set Bit 6.           0000000011011110
    e &= ~BIT1;     // Clear Bit 1                       0000000011011100
    e ^= BIT3;      // Toggle Bit 3                      0000000011010100

    f = f << 1;
    f = f << 2;
    f = f >> 1;
  }

  return 0;
}

