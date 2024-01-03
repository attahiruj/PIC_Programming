/*
Led Blink code in both current sourcing and sinking mode.
*/
void main() {
     TRISC5_bit = 0;   //set pin c2 to output   sourcing
     TRISC2_bit = 0;   //set pin c2 to output   sinking
     ANSELC = 0;       //set port C (ANALOGSELECT) to Digital
     while(1){
              LATC.B5 =  0;        //portC.bit5 to low
              LATC.B2 =  0;
              Delay_ms(500);
              LATC.B5 =  1;
              LATC.B2 =  1;
              Delay_ms(500);
     }
}
