
_main:

;Digital_Thermometer.c,22 :: 		void main() {
;Digital_Thermometer.c,23 :: 		ADCON1 = 0x0E;       //set all analog pin as digital except a0
	MOVLW       14
	MOVWF       ADCON1+0 
;Digital_Thermometer.c,24 :: 		TRISA.RA1 = 1;       //RA1 as input     TRISE1_bit
	BSF         TRISA+0, 1 
;Digital_Thermometer.c,25 :: 		OSCCON = 0x76;       //configure oscon to use 8MHz internal oscillator
	MOVLW       118
	MOVWF       OSCCON+0 
;Digital_Thermometer.c,27 :: 		ADC_Init();          //innitialise ADC library
	CALL        _ADC_Init+0, 0
;Digital_Thermometer.c,28 :: 		Lcd_Init();          //innitialise LCD library
	CALL        _Lcd_Init+0, 0
;Digital_Thermometer.c,29 :: 		Lcd_Cmd(_LCD_CLEAR);               //Clear LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Digital_Thermometer.c,30 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          //Remove LCD Cursor
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Digital_Thermometer.c,31 :: 		Lcd_Out(1,5, "Digital");           //Display Digital
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Digital_Thermometer+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Digital_Thermometer+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Digital_Thermometer.c,32 :: 		Lcd_Out(2,4, "Thermometer");       //Display Thermometer
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Digital_Thermometer+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Digital_Thermometer+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Digital_Thermometer.c,33 :: 		Delay_ms(1000);                    //1 second delay
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
	NOP
;Digital_Thermometer.c,35 :: 		Lcd_Cmd(_LCD_CLEAR);               //Clear LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Digital_Thermometer.c,36 :: 		Lcd_Out(1,1, "Temperature:");      //Display Temperature:
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_Digital_Thermometer+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_Digital_Thermometer+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Digital_Thermometer.c,37 :: 		Lcd_Chr(2,8,223);                  //Display degree symbol
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       223
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Digital_Thermometer.c,38 :: 		Lcd_Chr(2,9,'C');                  //Display character "C"
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Digital_Thermometer.c,39 :: 		while(1){
L_main1:
;Digital_Thermometer.c,40 :: 		temp = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
;Digital_Thermometer.c,41 :: 		mV = temp * 5000.0 / 1024.0; //multiply adc value by ref voltage ie 5V(*1000 for resolution) and devide by 1024 (10bit ie 2^10)
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       64
	MOVWF       R5 
	MOVLW       28
	MOVWF       R6 
	MOVLW       139
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       137
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _mV+0 
	MOVF        R1, 0 
	MOVWF       _mV+1 
	MOVF        R2, 0 
	MOVWF       _mV+2 
	MOVF        R3, 0 
	MOVWF       _mV+3 
;Digital_Thermometer.c,42 :: 		mV = mV/10.0;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _mV+0 
	MOVF        R1, 0 
	MOVWF       _mV+1 
	MOVF        R2, 0 
	MOVWF       _mV+2 
	MOVF        R3, 0 
	MOVWF       _mV+3 
;Digital_Thermometer.c,43 :: 		FloatToStr(mV, text);        //Float to string conversion
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _text+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;Digital_Thermometer.c,44 :: 		text[4] = 0;                 //Clip text output to 4
	CLRF        _text+4 
;Digital_Thermometer.c,45 :: 		Lcd_Out(2,3,text);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _text+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Digital_Thermometer.c,46 :: 		Delay_ms(300);                    //300 milisecond delay
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;Digital_Thermometer.c,48 :: 		}
	GOTO        L_main1
;Digital_Thermometer.c,50 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
