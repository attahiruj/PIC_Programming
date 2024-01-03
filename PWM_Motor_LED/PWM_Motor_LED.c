/*
Title: MOTOR and LED Controller(PWM) with potentiometer (ADC)
Written by: Attahiru Jibril
Written on: 05/22/2023
IDE: MikroC Pro
MCU: PIC18F445k22
FOC: external 8MHz
MCLR pin: enabled
*/

unsigned int read_adc;
long current_duty;

#define Motor PORTB        //rename portB to motor
#define CW 0x01            //turn ON only RB0 in PortB
#define CCW 0x02           //turn ON only RB1 in PortB


void main() {
     ANSELC = 0;           //set portC as digital
     ANSELB = 0;           //set portB as digital
     TRISB = 0;            //set portB as output
     TRISC = 0;            //set portC as output
     TRISA0_bit = 1;       //set A0 as analog pin
     
     PWM1_Init(1000);      //initialise PWM1 at 1kHz  :used by motor enable
     PWM2_Init(1000);      //initialise PWM2 at 1kHz  :used by Led
     PWM1_Start();         //start PWM1
     PWM2_Start();         //start PWM2
     ADC_Init();           //Initialise ADC
     
     Motor = CCW;          //Set motor to CCW/CW mode
     
     while(1){
              read_adc = ADC_Read(0);                 //read ADC at A0
              current_duty = (long) read_adc * 255;   // convert voltage level to duty_cycle (0-255)
              current_duty = current_duty/1023;       //sample duty by adc bit 2^10 = 1024 (0-1023)
              
              PWM1_Set_Duty(current_duty);            //set value of duty
              PWM2_Set_Duty(current_duty);
              delay_ms(10);                           //10 milliseconds delay
     }
     

}