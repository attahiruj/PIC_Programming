
_main:

;ADC.c,21 :: 		void main() {
;ADC.c,22 :: 		ANSELB =0;
	CLRF        ANSELB+0 
;ADC.c,23 :: 		ANSELE = 0x02;
	MOVLW       2
	MOVWF       ANSELE+0 
;ADC.c,24 :: 		TRISE1_bit = 1; //Set RE1 as input
	BSF         TRISE1_bit+0, BitPos(TRISE1_bit+0) 
;ADC.c,26 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;ADC.c,27 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;ADC.c,28 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;ADC.c,29 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;ADC.c,31 :: 		Lcd_Out(1, 1, "ADC");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_ADC+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_ADC+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;ADC.c,34 :: 		while(1){
L_main0:
;ADC.c,35 :: 		ADCResult = ADC_Get_Sample(6);
	MOVLW       6
	MOVWF       FARG_ADC_Get_Sample_channel+0 
	CALL        _ADC_Get_Sample+0, 0
	MOVF        R0, 0 
	MOVWF       _ADCResult+0 
	MOVF        R1, 0 
	MOVWF       _ADCResult+1 
;ADC.c,36 :: 		voltage = (ADCResult * 5000.0)/1024.0;
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
	MOVWF       _voltage+0 
	MOVF        R1, 0 
	MOVWF       _voltage+1 
	MOVF        R2, 0 
	MOVWF       _voltage+2 
	MOVF        R3, 0 
	MOVWF       _voltage+3 
;ADC.c,37 :: 		voltage = voltage/1000;
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _voltage+0 
	MOVF        R1, 0 
	MOVWF       _voltage+1 
	MOVF        R2, 0 
	MOVWF       _voltage+2 
	MOVF        R3, 0 
	MOVWF       _voltage+3 
;ADC.c,38 :: 		FloatToStr(voltage, voltageText);
	MOVF        R0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        R1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        R2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        R3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       _voltageText+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(_voltageText+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;ADC.c,39 :: 		Lcd_Out(2, 1, voltageText);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _voltageText+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_voltageText+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;ADC.c,40 :: 		}
	GOTO        L_main0
;ADC.c,41 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
