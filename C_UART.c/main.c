/*
  UART
*/

#include "intrinsics.h"
#include <msp430.h>
int i;
char text[] = "Hey there bud";
void ser_output(char *str);
int main(void)
{
  WDTCTL = WDTPW + WDTHOLD;                 // Stop WDT
  if (CALBC1_1MHZ==0xFF)					// If calibration constant erased
  {											
    while(1);                               // do not load, trap CPU!!	
  }
  DCOCTL = 0;                               // Select lowest DCOx and MODx settings
  BCSCTL1 = CALBC1_1MHZ;                    // Set DCO
  DCOCTL = CALDCO_1MHZ;
  P1SEL = BIT1 + BIT2 ;                     // P1.1 = RXD, P1.2=TXD
  P1SEL2 = BIT1 + BIT2 ;                    // P1.1 = RXD, P1.2=TXD
  UCA0CTL1 |= UCSSEL_2;                     // SMCLK
  UCA0BR0 = 104;                            // 1MHz 9600
  UCA0BR1 = 0;                              // 1MHz 9600
  UCA0MCTL = UCBRS0;                        // Modulation UCBRSx = 1
  UCA0CTL1 &= ~UCSWRST;                     // **Initialize USCI state machine**
  IE2 |= UCA0RXIE;                          // Enable USCI_A0 RX interrupt

  // __bis_SR_register(LPM0_bits + GIE);       // Enter LPM0, interrupts enabled

  while(1){
    ser_output(text);
  }
}

void ser_output(char *str) {
  for (i==1; i<5; i++) {
    while(!(IFG2&UCA0TXIFG));
    UCA0TXBUF = *str++;
  }
}

// //  Echo back RXed character, confirm TX buffer is ready first
// #pragma vector=USCIAB0RX_VECTOR
// __interrupt void USCI0RX_ISR(void)
// {
//   while (!(IFG2&UCA0TXIFG));                // USCI_A0 TX buffer ready?
//   UCA0TXBUF = UCA0RXBUF;                    // TX -> RXed character
// }