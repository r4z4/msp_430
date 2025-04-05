/*
  UART. Sending Baud Rate 115200
*/

#include "intrinsics.h"
#include <msp430.h>
int i;
char text[] = "Hey there bud";
void ser_output(char *str);
int main(void)
{
  WDTCTL = WDTPW + WDTHOLD;                 // Stop WDT

  //-- Setup UART
  UCA0CTL0 |= UCSWRST;     // Put into Software Reset

  //-- Setup Clock
  UCA0CTL0 |= UCSSEL2;    // Choose SMCLK
  UCA0BRW = 8;            // Put prescalar value in Baud Rate Word
  UCA0MCTL = UCBRS_7;     // Configure Modulation Settings. Low Freq Mode.
  P1SEL = BIT1 + BIT2;    // P1.1 = RXD, P1.2=TXD
  P1SEL2 = BIT1 + BIT2;
  //-- Setup Ports

  return 0;
}
