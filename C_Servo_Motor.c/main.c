/*
  Servo Motor
*/

#include "intrinsics.h"
#include "msp430g2553.h"
#include <msp430.h>

int main(void)
{
  WDTCTL = WDTPW + WDTHOLD;                 // Stop WDT
  BCSCTL1 = CALBC1_1MHZ;
  DCOCTL = CALDCO_1MHZ;
  // PWM
  P2DIR |= BIT6;
  P2SEL |= BIT6;
  while(1){
    TACCR0 = 20000; // PWM Period
    TACCR1 = 350;   // CCR1 PWM Duty Cycle
    TACCTL1 = OUTMOD_7; //CCR1 Selection Reset-Set
    TACTL = TASSEL_2|MC_1; //SMCLK, UP Mode
    __delay_cycles(1500000);
    TACCR1 = 2350;
    TACCTL1 = OUTMOD_7; // CCR1 Selection Reset-Set
    TACTL = TASSEL_2|MC_1;
    __delay_cycles(1500000);
  }
}

