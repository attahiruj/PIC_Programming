#line 1 "C:/Users/Attahiru Jibril/Documents/Design/Electronics_Circuits-Embedded_System/mikroC/PIC_Grind/PWM_Motor_LED/PWM_Motor_LED.c"
#line 11 "C:/Users/Attahiru Jibril/Documents/Design/Electronics_Circuits-Embedded_System/mikroC/PIC_Grind/PWM_Motor_LED/PWM_Motor_LED.c"
unsigned int read_adc;
long current_duty;






void main() {
 ANSELC = 0;
 ANSELB = 0;
 TRISB = 0;
 TRISC = 0;
 TRISA0_bit = 1;

 PWM1_Init(1000);
 PWM2_Init(1000);
 PWM1_Start();
 PWM2_Start();
 ADC_Init();

  PORTB  =  0x02 ;

 while(1){
 read_adc = ADC_Read(0);
 current_duty = (long) read_adc * 255;
 current_duty = current_duty/1023;

 PWM1_Set_Duty(current_duty);
 PWM2_Set_Duty(current_duty);
 delay_ms(10);
 }


}
