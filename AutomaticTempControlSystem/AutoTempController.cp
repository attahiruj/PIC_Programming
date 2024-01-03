#line 1 "C:/Users/Attahiru Jibril/Documents/Design/Electronics_Circuits-Embedded_System/mikroC/PIC_Grind/AutomaticTempControlSystem/AutoTempController.c"
#line 12 "C:/Users/Attahiru Jibril/Documents/Design/Electronics_Circuits-Embedded_System/mikroC/PIC_Grind/AutomaticTempControlSystem/AutoTempController.c"
sbit LCD_RS at RC4_bit;
sbit LCD_EN at RC5_bit;
sbit LCD_D7 at RC3_bit;
sbit LCD_D6 at RC2_bit;
sbit LCD_D5 at RC1_bit;
sbit LCD_D4 at RC0_bit;


sbit LCD_RS_Direction at TRISC4_bit;
sbit LCD_EN_Direction at TRISC5_bit;
sbit LCD_D7_Direction at TRISC3_bit;
sbit LCD_D6_Direction at TRISC2_bit;
sbit LCD_D5_Direction at TRISC1_bit;
sbit LCD_D4_Direction at TRISC0_bit;


char keypadPort at PORTB;









void main() {
 unsigned short kp, text[14];
 unsigned short Temp_Ref;
 unsigned char Temp_Input;
 unsigned int Temp;
 float mV, Temp_Actual;

 ANSELC = 0;
 ANSELB = 0;
 ANSELD = 0;
 TRISA0_bit = 1;
 TRISC = 0;
 TRISD0_bit = 0;
 TRISD1_bit = 0;

 Keypad_Init();
 Lcd_Init();

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,4, "Automatic");
 Lcd_Out(2,4, "Temp Control");

 delay_ms(2000);
  PORTD.RD0  =  0 ;
  PORTD.RD1  =  0 ;

 START:
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1, 1, "Enter Ref Temp");
 Lcd_Out(2, 1, "Ref Temp:");
 Temp_Ref = 0;
 while(1){
 do{
 kp = Keypad_Key_Click();
 }while (!kp);

 if(kp ==  15 )break;
 if(kp ==  13 )goto START;
 if (kp > 3 && kp < 8){ kp = kp-1;}
 if (kp > 8 && kp < 12){ kp = kp-2;}
 if (kp == 14){ kp = 0;}
 Lcd_Chr_Cp(kp + '0');
 Temp_Ref = (10*Temp_Ref) + kp;
 }
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Ref Temp:");
 intToStr(Temp_Ref, Text);
 Temp_Input = Ltrim(Text);
 Lcd_Out_CP(Temp_Input);
 Lcd_Out(2, 1, "Press # to cont.");


 kp = 0;
 while(kp !=  15 ){
 do{
 kp = Keypad_Key_Click();
 if(kp ==  13 )goto START;
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


 if(Temp_Ref < Temp_Actual){
  PORTD.RD0  =  0 ;
  PORTD.RD1  =  1 ;
 }
 else if(Temp_Ref > Temp_Actual){
  PORTD.RD0  =  1 ;
  PORTD.RD1  =  0 ;
 }
 else{
  PORTD.RD0  =  0 ;
  PORTD.RD1  =  0 ;
 }
 kp = Keypad_Key_Click();
 if(kp ==  13 )goto START;
 }


}
