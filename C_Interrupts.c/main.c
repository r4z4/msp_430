/*
  Interrupts. IRQ - Interrupt Request
*/

#include <msp430.h>

int main(void)
{
  WDTCTL = WDTPW + WDTHOLD;             // Stop WDT
  // & to clear, | to set
  // Setup Ports
  P1DIR |= BIT0;  // LED1. Port 1 Direction Register. Bitwise OR to Set.
  P1OUT &= ~BIT0;

  P1DIR &= ~BIT3; // Congif P1.3 (s1) as Input. Bitwise AND to clear. 
                  //  w/ Inverted Mask
  P1REN |= BIT3;  // Turn on Resistor
  P1OUT |= BIT3;  // Make it a PullUp Resistor.
                  // Secondary Function for P1OUT.
  P1IES |= BIT3;  // Interrupt Edge Sensativity from High -> Low

  // Setup IRQ
  P1IE |= BIT3;   // Enable P1.3 - Local Enable
  __enable_interrupt(); // == eint. Enable Maskable IRQ.
  P1IFG &= ~BIT3;       // Clear P1.3 IRQ Flag

  while(1){}            // Loop forever

  return 0;
}

//-- ISRs ---------------------//
#pragma vector = PORT1_VECTOR
__interrupt void ISR_Port1_S1(void)
{
  P1OUT ^= BIT0;  // Toggle LED1
  P1IFG &= ~BIT3; // Clear Flag
}
