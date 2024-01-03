/*
Title: External Interrupt
Written by: Attahiru Jibril
Written on: 05/22/2023
IDE: MikroC Pro
MCU: PIC18F445k22
FOC: internal 8MHz
MCLR pin: enabled
*/

#define LED_Red LATD0_bit
#define LED_Green LATD1_bit
#define LED_Blue LATD2_bit
#define SOS LATD3_bit

char recievedData;
int x;

void interrupt(){

     for (x=1; x<=4; x++){
         SOS = ~SOS;
         delay_ms(200);
     }
     
     //INT0IF_bit = 0;                //INT0 Interrupt flag cleared
     UART1_Read();                        //PIR1.b5 or RC1IF only clears if you read the buffer uart rx
}


                                          //External Intterupt code
//=========================================================================================
/*
void main() {
     ANSELD = 0;                //disable analog in port D
     ANSELB = 0;                //disable analog in port B
     TRISD = 0;                 //Set port D as output
     TRISB = 0x01;                 //Set port B0 as intput
     
     INTCON = 0b11011000;       //0x68   //set intcon registers - check Datasheet

     while(1){
     // Led chase routine
       LED_Red = ~LED_Red;
       delay_ms(200);
       LED_Green = ~LED_Green;
       delay_ms(200);
       LED_Blue = ~LED_Blue;
       delay_ms(200);

     }

}

*/

                                         //Pheripheral interupt code using USART
//=======================================================================================
void main(){
     INTCON = 0b11000000;       //set INtcon to use pheripheral interrupt
     PIE1 = 0b00100000;
     
     ANSELD = 0;                //disable analog in port D
     ANSELB = 0;                //disable analog in port B
     TRISD = 0;                 //Set port D as output
     ANSELC = 0;
     
     UART1_Init(19200);
     delay_ms(500);
     
     UART1_Write_Text("Start typing to cause an Interrupt \r\n");
     delay_ms(500);
     
     while(1){
     // Led chase routine
       LED_Red = ~LED_Red;
       delay_ms(200);
       LED_Green = ~LED_Green;
       delay_ms(200);
       LED_Blue = ~LED_Blue;
       delay_ms(200);

     }
     
}