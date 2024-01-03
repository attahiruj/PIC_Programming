#line 1 "C:/Users/Attahiru Jibril/Documents/Design/Electronics_Circuits-Embedded_System/mikroC/PIC_Grind/Serial_Communicatio_RS232/Serial_Comm_RS232.c"
#line 17 "C:/Users/Attahiru Jibril/Documents/Design/Electronics_Circuits-Embedded_System/mikroC/PIC_Grind/Serial_Communicatio_RS232/Serial_Comm_RS232.c"
char read_uart;

void main() {
 TRISB = 0;
 ANSELB = 0;
 ANSELC = 0;
 OSCCON = 0x66;

 UART1_Init(9600);
 Delay_ms(100);
 UART1_Write_Text("2MJ \r\n");
 Delay_ms(500);
 UART1_Write_Text(" Press 1 for Red \r\n Press 2 for Green \r\n Press 3 for Blue \r\n");

  LATB0_bit  =  1 ;
  LATB1_bit  =  1 ;
  LATB2_bit  =  1 ;
 Delay_ms(500);
  LATB0_bit  =  0 ;
  LATB1_bit  =  0 ;
  LATB2_bit  =  0 ;


 while(1){

 if(UART1_Data_Ready() == 1){
 UART1_Write_Text("\r\n data ready \r\n");

 read_uart = UART1_Read();
 switch(read_uart){
 case '1':
  LATB0_bit  =  1 ;
  LATB1_bit  =  0 ;
  LATB2_bit  =  0 ;
 break;

 case '2':
  LATB0_bit  =  0 ;
  LATB1_bit  =  1 ;
  LATB2_bit  =  0 ;
 break;

 case '3':
  LATB0_bit  =  0 ;
  LATB1_bit  =  0 ;
  LATB2_bit  =  1 ;
 break;

 default:
  LATB0_bit  =  0 ;
  LATB1_bit  =  0 ;
  LATB2_bit  =  0 ;
 break;
 }
 }
 }
}
