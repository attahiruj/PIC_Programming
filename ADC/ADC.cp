#line 1 "C:/Users/Attahiru Jibril/Documents/Design/Electronics_Circuits-Embedded_System/mikroC/PIC_Grind/ADC/ADC.c"

sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D4 at RB0_bit;


sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D7_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB0_bit;

unsigned int ADCResult = 0;
float voltage;
char voltageText[15];

void main() {
 ANSELB =0;
 ANSELE = 0x02;
 TRISE1_bit = 1;

 ADC_Init();
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 Lcd_Out(1, 1, "ADC");


 while(1){
 ADCResult = ADC_Get_Sample(6);
 voltage = (ADCResult * 5000.0)/1024.0;
 voltage = voltage/1000;
 FloatToStr(voltage, voltageText);
 Lcd_Out(2, 1, voltageText);
 }
}
