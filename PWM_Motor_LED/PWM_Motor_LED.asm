
_main:

;PWM_Motor_LED.c,19 :: 		void main() {
;PWM_Motor_LED.c,20 :: 		ANSELC = 0;           //set portC as digital
	CLRF        ANSELC+0 
;PWM_Motor_LED.c,21 :: 		ANSELB = 0;           //set portB as digital
	CLRF        ANSELB+0 
;PWM_Motor_LED.c,22 :: 		TRISB = 0;            //set portB as output
	CLRF        TRISB+0 
;PWM_Motor_LED.c,23 :: 		TRISC = 0;            //set portC as output
	CLRF        TRISC+0 
;PWM_Motor_LED.c,24 :: 		TRISA0_bit = 1;       //set A0 as analog pin
	BSF         TRISA0_bit+0, BitPos(TRISA0_bit+0) 
;PWM_Motor_LED.c,26 :: 		PWM1_Init(1000);      //initialise PWM1 at 1kHz  :used by motor enable
	BSF         T2CON+0, 0, 0
	BSF         T2CON+0, 1, 0
	MOVLW       124
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;PWM_Motor_LED.c,27 :: 		PWM2_Init(1000);      //initialise PWM2 at 1kHz  :used by Led
	BSF         T2CON+0, 0, 0
	BSF         T2CON+0, 1, 0
	MOVLW       124
	MOVWF       PR2+0, 0
	CALL        _PWM2_Init+0, 0
;PWM_Motor_LED.c,28 :: 		PWM1_Start();         //start PWM1
	CALL        _PWM1_Start+0, 0
;PWM_Motor_LED.c,29 :: 		PWM2_Start();         //start PWM2
	CALL        _PWM2_Start+0, 0
;PWM_Motor_LED.c,30 :: 		ADC_Init();           //Initialise ADC
	CALL        _ADC_Init+0, 0
;PWM_Motor_LED.c,32 :: 		Motor = CCW;          //Set motor to CCW/CW mode
	MOVLW       2
	MOVWF       PORTB+0 
;PWM_Motor_LED.c,34 :: 		while(1){
L_main0:
;PWM_Motor_LED.c,35 :: 		read_adc = ADC_Read(0);                 //read ADC at A0
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _read_adc+0 
	MOVF        R1, 0 
	MOVWF       _read_adc+1 
;PWM_Motor_LED.c,36 :: 		current_duty = (long) read_adc * 255;   // convert voltage level to duty_cycle (0-255)
	MOVLW       0
	MOVWF       R2 
	MOVWF       R3 
	MOVLW       255
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       _current_duty+0 
	MOVF        R1, 0 
	MOVWF       _current_duty+1 
	MOVF        R2, 0 
	MOVWF       _current_duty+2 
	MOVF        R3, 0 
	MOVWF       _current_duty+3 
;PWM_Motor_LED.c,37 :: 		current_duty = current_duty/1023;       //sample duty by adc bit 2^10 = 1024 (0-1023)
	MOVLW       255
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_S+0, 0
	MOVF        R0, 0 
	MOVWF       _current_duty+0 
	MOVF        R1, 0 
	MOVWF       _current_duty+1 
	MOVF        R2, 0 
	MOVWF       _current_duty+2 
	MOVF        R3, 0 
	MOVWF       _current_duty+3 
;PWM_Motor_LED.c,39 :: 		PWM1_Set_Duty(current_duty);            //set value of duty
	MOVF        R0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;PWM_Motor_LED.c,40 :: 		PWM2_Set_Duty(current_duty);
	MOVF        _current_duty+0, 0 
	MOVWF       FARG_PWM2_Set_Duty_new_duty+0 
	CALL        _PWM2_Set_Duty+0, 0
;PWM_Motor_LED.c,41 :: 		delay_ms(10);                           //10 milliseconds delay
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	NOP
;PWM_Motor_LED.c,42 :: 		}
	GOTO        L_main0
;PWM_Motor_LED.c,45 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
