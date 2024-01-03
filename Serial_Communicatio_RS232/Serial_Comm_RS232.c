/*
Title: RS232 UART communication
Written by: Attahiru Jibril
Written on: 05/22/2023
IDE: MikroC Pro
MCU: PIC18F445k22
FOC: internal 8MHz
MCLR pin: enabled
*/

#define Led_Red LATB0_bit
#define Led_Green LATB1_bit
#define Led_Blue LATB2_bit
#define ON 1
#define OFF 0

char read_uart;

void main() {
  TRISB = 0;       //set port B as output
  ANSELB = 0;      //Set PORT B as Digital Pins
  ANSELC = 0;      //Set PORT B as Digital Pins ***UART1 wont read if not set
  OSCCON = 0x66;   //configure OSCON Register for internal oscillator : datasheet
  
  UART1_Init(9600);      //initialize UART module
  Delay_ms(100);         //wait
  UART1_Write_Text("2MJ \r\n");
  Delay_ms(500);         //wait
  UART1_Write_Text(" Press 1 for Red \r\n Press 2 for Green \r\n Press 3 for Blue \r\n");
  
  Led_Red = ON;
  Led_Green = ON;
  Led_Blue = ON;
  Delay_ms(500);
  Led_Red = OFF;
  Led_Green = OFF;
  Led_Blue = OFF;
  
  
  while(1){

      if(UART1_Data_Ready() == 1){
      UART1_Write_Text("\r\n data ready \r\n");

          read_uart = UART1_Read();
          switch(read_uart){
              case '1':
                   Led_Red = ON;
                   Led_Green = OFF;
                   Led_Blue = OFF;
              break;
              
              case '2':
                   Led_Red = OFF;
                   Led_Green = ON;
                   Led_Blue = OFF;
              break;
              
              case '3':
                   Led_Red = OFF;
                   Led_Green = OFF;
                   Led_Blue = ON;
              break;
              
              default:
                   Led_Red = OFF;
                   Led_Green = OFF;
                   Led_Blue = OFF;
              break;
          }
      }
  }
}