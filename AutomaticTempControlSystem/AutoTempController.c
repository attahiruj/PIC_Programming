/*
Title: Automatic Temperature control system
Written by: Attahiru Jibril
Written on: 05/19/2023
IDE: MikroC Pro
MCU: PIC18F445k22
FOC: external 8MHz with 4xPLL
MCLR pin: enabled
*/

// Lcd pinout settings
sbit LCD_RS at RC4_bit;
sbit LCD_EN at RC5_bit;
sbit LCD_D7 at RC3_bit;
sbit LCD_D6 at RC2_bit;
sbit LCD_D5 at RC1_bit;
sbit LCD_D4 at RC0_bit;

//LCD Pin direction
sbit LCD_RS_Direction at TRISC4_bit;
sbit LCD_EN_Direction at TRISC5_bit;
sbit LCD_D7_Direction at TRISC3_bit;
sbit LCD_D6_Direction at TRISC2_bit;
sbit LCD_D5_Direction at TRISC1_bit;
sbit LCD_D4_Direction at TRISC0_bit;

//keypad connection
char keypadPort at PORTB;   //configure port B for keypad library

//PIN definitions
#define heater PORTD.RD0
#define fan PORTD.RD1
#define enter 15
#define clear 13
#define ON 1
#define OFF 0

void main() {
  unsigned short kp, text[14];
  unsigned short Temp_Ref;            //Reference temperature to be inputed by user
  unsigned char Temp_Input;           //saved user temperature input
  unsigned int Temp;                  //Temperature value from sensor (raw analog data)
  float mV, Temp_Actual;              // temp in mV, and realtemperature in °C

  ANSELC = 0;                         //Configure PORTC as digital i/o
  ANSELB = 0;                         //Configure PORTB as digital i/o
  ANSELD = 0;                         //Configure PORTD as digital i/o
  TRISA0_bit = 1;                     //Configure RA0/AN0 as input
  TRISC = 0;                          //Configure PORTC as ouotput (lcd)
  TRISD0_bit = 0;                     //Configure RD0 as output    (heater)
  TRISD1_bit = 0;                     //Configure RD1 as output    (fan)
  
  Keypad_Init();                      //initialize keypad
  Lcd_Init();                         //initialize lcd library

  Lcd_Cmd(_LCD_CLEAR);                //clear LCD
  Lcd_Cmd(_LCD_CURSOR_OFF);           //remove lcd cursor
  Lcd_Out(1,4, "Automatic");          //Print out Automatic on row 1 column 4
  Lcd_Out(2,4, "Temp Control");

  delay_ms(2000);                     //2 seconds delay
  heater = OFF;                       //initialise heater and fan OFF
  fan = OFF;
  
  START:                              //jump point for goto, temperature input mode
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Cmd(_LCD_CURSOR_OFF);
  Lcd_Out(1, 1, "Enter Ref Temp");
  Lcd_Out(2, 1, "Ref Temp:");
  Temp_Ref = 0;                       //initialize reference temperature to 0
  while(1){
           do{
              kp = Keypad_Key_Click();     //listen for keypad input while its no pressed
           }while (!kp);
           
           if(kp == enter)break;                    //Exit loop if enter is pressed
           if(kp == clear)goto START;               //goto start point if clear is pressed
           if (kp > 3 && kp < 8){ kp = kp-1;}       //command used to callibrate 3x3 kp to work with 4x4 kp library
           if (kp > 8 && kp < 12){ kp = kp-2;}      //above statement for row 3
           if (kp == 14){ kp = 0;}
           Lcd_Chr_Cp(kp + '0');
           Temp_Ref = (10*Temp_Ref) + kp;           //increment reference tempertur input by 10s plus new input (used to shift left)
  }
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Out(1, 1, "Ref Temp:");
  intToStr(Temp_Ref, Text);                         //conver int tp string for lcd display
  Temp_Input = Ltrim(Text);
  Lcd_Out_CP(Temp_Input);
  Lcd_Out(2, 1, "Press # to cont.");

  
  kp = 0;
  while(kp != enter){
            do{
                kp = Keypad_Key_Click();
                if(kp == clear)goto START;          //go to temp input mode if clear is pressed
            }while(!kp);
  }
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Out(1, 1, "Ref Temp:");
  Lcd_Chr(1, 15, 223);
  Lcd_Chr(1, 16, 'C');
  
  while(1){
           temp = ADC_Read(0);
           mV = temp * 5000.0 /1024.0;
           Temp_Actual = mV/10.0;
           intToStr (Temp_Ref, Text);
           Temp_Input = Ltrim(Text);
           Lcd_Out(1, 11, Temp_Input);
           Lcd_Out(2, 1, "Temp= ");
           FloatToStr(Temp_Actual, Text);
           Text[5] = 0;
           Lcd_Out(2, 7, Text);
           Lcd_Chr(2, 12, 223);
           Lcd_Chr(2, 13, 'C');
           //Lcd_Out(2, 12, "  ");
           
           if(Temp_Ref < Temp_Actual){            //too hot, turn on fan
                       heater = OFF;
                       fan = ON;
           }
           else if(Temp_Ref > Temp_Actual){       //too cold, turn on heater
                       heater = ON;
                       fan = OFF;
           }
           else{           //nuetral
                       heater = OFF;
                       fan = OFF;
           }
           kp = Keypad_Key_Click();
           if(kp == clear)goto START;             //go to temp input mode if clear is pressed
  }
  
  
}