#line 1 "C:/Users/Attahiru Jibril/Documents/Design/Electronics_Circuits-Embedded_System/mikroC/PIC_Grind/Digital_Thermometer/Digital_Thermometer.c"


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

unsigned int temp;
float mV;
unsigned char text[15];

void main() {
ADCON1 = 0x0E;
TRISA.RA1 = 1;
OSCCON = 0x76;

ADC_Init();
Lcd_Init();
Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);
Lcd_Out(1,5, "Digital");
Lcd_Out(2,4, "Thermometer");
Delay_ms(1000);

Lcd_Cmd(_LCD_CLEAR);
Lcd_Out(1,1, "Temperature:");
Lcd_Chr(2,8,223);
Lcd_Chr(2,9,'C');
while(1){
 temp = ADC_Read(0);
 mV = temp * 5000.0 / 1024.0;
 mV = mV/10.0;
 FloatToStr(mV, text);
 text[4] = 0;
 Lcd_Out(2,3,text);
 Delay_ms(300);

}

}
