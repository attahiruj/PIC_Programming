
// Lcd pinout settings
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D4 at RB0_bit;

// Pin direction
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
ADCON1 = 0x0E;       //set all analog pin as digital except a0
TRISA.RA1 = 1;       //RA1 as input     TRISE1_bit
OSCCON = 0x76;       //configure oscon to use 8MHz internal oscillator

ADC_Init();          //innitialise ADC library
Lcd_Init();          //innitialise LCD library
Lcd_Cmd(_LCD_CLEAR);               //Clear LCD
Lcd_Cmd(_LCD_CURSOR_OFF);          //Remove LCD Cursor
Lcd_Out(1,5, "Digital");           //Display Digital
Lcd_Out(2,4, "Thermometer");       //Display Thermometer
Delay_ms(1000);                    //1 second delay

Lcd_Cmd(_LCD_CLEAR);               //Clear LCD
Lcd_Out(1,1, "Temperature:");      //Display Temperature:
Lcd_Chr(2,8,223);                  //Display degree symbol
Lcd_Chr(2,9,'C');                  //Display character "C"
while(1){
      temp = ADC_Read(0);
      mV = temp * 5000.0 / 1024.0; //multiply adc value by ref voltage ie 5V(*1000 for resolution) and devide by 1024 (10bit ie 2^10)
      mV = mV/10.0;
      FloatToStr(mV, text);        //Float to string conversion
      text[4] = 0;                 //Clip text output to 4
      Lcd_Out(2,3,text);
      Delay_ms(300);                    //300 milisecond delay
      
}

}