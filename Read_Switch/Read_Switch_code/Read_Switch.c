void main() {
     ADCON1= 0x0F;   //switch of ADC on all pins
     TRISB0_bit = 0;  //configure portB as output
     TRISC0_bit = 1;  //configure portC as input
     
     while(1){
          if(PORTC.RC0 == 0){
               Delay_ms(1);
               if(PORTC.RC0 == 0){
                            LATB.B0 = 1;
               }
          }
          else{
               LATB.B0 = 0;
          }
     }

}