#line 1 "C:/Users/Attahiru Jibril/Documents/Design/Electronics_Circuits-Embedded_System/mikroC/PIC_Grind/Interrupts/Exterrnal_Interrupt.c"
#line 16 "C:/Users/Attahiru Jibril/Documents/Design/Electronics_Circuits-Embedded_System/mikroC/PIC_Grind/Interrupts/Exterrnal_Interrupt.c"
char recievedData;
int x;

void interrupt(){

 for (x=1; x<=4; x++){
  LATD3_bit  = ~ LATD3_bit ;
 delay_ms(200);
 }


 UART1_Read();
}
#line 59 "C:/Users/Attahiru Jibril/Documents/Design/Electronics_Circuits-Embedded_System/mikroC/PIC_Grind/Interrupts/Exterrnal_Interrupt.c"
void main(){
 INTCON = 0b11000000;
 PIE1 = 0b00100000;

 ANSELD = 0;
 ANSELB = 0;
 TRISD = 0;
 ANSELC = 0;

 UART1_Init(19200);
 delay_ms(500);

 UART1_Write_Text("Start typing to cause an Interrupt \r\n");
 delay_ms(500);

 while(1){

  LATD0_bit  = ~ LATD0_bit ;
 delay_ms(200);
  LATD1_bit  = ~ LATD1_bit ;
 delay_ms(200);
  LATD2_bit  = ~ LATD2_bit ;
 delay_ms(200);

 }

}
