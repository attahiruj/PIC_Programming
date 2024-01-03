
_main:

;AutoTempController.c,38 :: 		void main() {
;AutoTempController.c,45 :: 		ANSELC = 0;                         //Configure PORTC as digital i/o
	CLRF        ANSELC+0 
;AutoTempController.c,46 :: 		ANSELB = 0;                         //Configure PORTB as digital i/o
	CLRF        ANSELB+0 
;AutoTempController.c,47 :: 		ANSELD = 0;                         //Configure PORTD as digital i/o
	CLRF        ANSELD+0 
;AutoTempController.c,48 :: 		TRISA0_bit = 1;                     //Configure RA0/AN0 as input
	BSF         TRISA0_bit+0, BitPos(TRISA0_bit+0) 
;AutoTempController.c,49 :: 		TRISC = 0;                          //Configure PORTC as ouotput (lcd)
	CLRF        TRISC+0 
;AutoTempController.c,50 :: 		TRISD0_bit = 0;                     //Configure RD0 as output    (heater)
	BCF         TRISD0_bit+0, BitPos(TRISD0_bit+0) 
;AutoTempController.c,51 :: 		TRISD1_bit = 0;                     //Configure RD1 as output    (fan)
	BCF         TRISD1_bit+0, BitPos(TRISD1_bit+0) 
;AutoTempController.c,53 :: 		Keypad_Init();                      //initialize keypad
	CALL        _Keypad_Init+0, 0
;AutoTempController.c,54 :: 		Lcd_Init();                         //initialize lcd library
	CALL        _Lcd_Init+0, 0
;AutoTempController.c,56 :: 		Lcd_Cmd(_LCD_CLEAR);                //clear LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AutoTempController.c,57 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);           //remove lcd cursor
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AutoTempController.c,58 :: 		Lcd_Out(1,4, "Automatic");          //Print out Automatic on row 1 column 4
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_AutoTempController+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_AutoTempController+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutoTempController.c,59 :: 		Lcd_Out(2,4, "Temp Control");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_AutoTempController+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_AutoTempController+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutoTempController.c,61 :: 		delay_ms(2000);                     //2 seconds delay
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
;AutoTempController.c,62 :: 		heater = OFF;                       //initialise heater and fan OFF
	BCF         PORTD+0, 0 
;AutoTempController.c,63 :: 		fan = OFF;
	BCF         PORTD+0, 1 
;AutoTempController.c,65 :: 		START:                              //jump point for goto, temperature input mode
___main_START:
;AutoTempController.c,66 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AutoTempController.c,67 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AutoTempController.c,68 :: 		Lcd_Out(1, 1, "Enter Ref Temp");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_AutoTempController+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_AutoTempController+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutoTempController.c,69 :: 		Lcd_Out(2, 1, "Ref Temp:");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_AutoTempController+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_AutoTempController+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutoTempController.c,70 :: 		Temp_Ref = 0;                       //initialize reference temperature to 0
	CLRF        main_Temp_Ref_L0+0 
;AutoTempController.c,71 :: 		while(1){
L_main1:
;AutoTempController.c,72 :: 		do{
L_main3:
;AutoTempController.c,73 :: 		kp = Keypad_Key_Click();     //listen for keypad input while its no pressed
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       main_kp_L0+0 
;AutoTempController.c,74 :: 		}while (!kp);
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
;AutoTempController.c,76 :: 		if(kp == enter)break;                    //Exit loop if enter is pressed
	MOVF        main_kp_L0+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_main6
	GOTO        L_main2
L_main6:
;AutoTempController.c,77 :: 		if(kp == clear)goto START;               //goto start point if clear is pressed
	MOVF        main_kp_L0+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_main7
	GOTO        ___main_START
L_main7:
;AutoTempController.c,78 :: 		if (kp > 3 && kp < 8){ kp = kp-1;}       //command used to callibrate 3x3 kp to work with 4x4 kp library
	MOVF        main_kp_L0+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_main10
	MOVLW       8
	SUBWF       main_kp_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main10
L__main29:
	DECF        main_kp_L0+0, 1 
L_main10:
;AutoTempController.c,79 :: 		if (kp > 8 && kp < 12){ kp = kp-2;}      //above statement for row 3
	MOVF        main_kp_L0+0, 0 
	SUBLW       8
	BTFSC       STATUS+0, 0 
	GOTO        L_main13
	MOVLW       12
	SUBWF       main_kp_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main13
L__main28:
	MOVLW       2
	SUBWF       main_kp_L0+0, 1 
L_main13:
;AutoTempController.c,80 :: 		if (kp == 14){ kp = 0;}
	MOVF        main_kp_L0+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_main14
	CLRF        main_kp_L0+0 
L_main14:
;AutoTempController.c,81 :: 		Lcd_Chr_Cp(kp + '0');
	MOVLW       48
	ADDWF       main_kp_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;AutoTempController.c,82 :: 		Temp_Ref = (10*Temp_Ref) + kp;           //increment reference tempertur input by 10s plus new input (used to shift left)
	MOVLW       10
	MULWF       main_Temp_Ref_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       main_Temp_Ref_L0+0 
	MOVF        main_kp_L0+0, 0 
	ADDWF       main_Temp_Ref_L0+0, 1 
;AutoTempController.c,83 :: 		}
	GOTO        L_main1
L_main2:
;AutoTempController.c,84 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AutoTempController.c,85 :: 		Lcd_Out(1, 1, "Ref Temp:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_AutoTempController+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_AutoTempController+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutoTempController.c,86 :: 		intToStr(Temp_Ref, Text);                         //conver int tp string for lcd display
	MOVF        main_Temp_Ref_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_text_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_text_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;AutoTempController.c,87 :: 		Temp_Input = Ltrim(Text);
	MOVLW       main_text_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(main_text_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;AutoTempController.c,88 :: 		Lcd_Out_CP(Temp_Input);
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Out_CP_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_CP_text+1 
	CALL        _Lcd_Out_CP+0, 0
;AutoTempController.c,89 :: 		Lcd_Out(2, 1, "Press # to cont.");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_AutoTempController+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_AutoTempController+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutoTempController.c,92 :: 		kp = 0;
	CLRF        main_kp_L0+0 
;AutoTempController.c,93 :: 		while(kp != enter){
L_main15:
	MOVF        main_kp_L0+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
;AutoTempController.c,94 :: 		do{
L_main17:
;AutoTempController.c,95 :: 		kp = Keypad_Key_Click();
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       main_kp_L0+0 
;AutoTempController.c,96 :: 		if(kp == clear)goto START;          //go to temp input mode if clear is pressed
	MOVF        R0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_main20
	GOTO        ___main_START
L_main20:
;AutoTempController.c,97 :: 		}while(!kp);
	MOVF        main_kp_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main17
;AutoTempController.c,98 :: 		}
	GOTO        L_main15
L_main16:
;AutoTempController.c,99 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;AutoTempController.c,100 :: 		Lcd_Out(1, 1, "Ref Temp:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_AutoTempController+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_AutoTempController+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutoTempController.c,101 :: 		Lcd_Chr(1, 15, 223);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       223
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;AutoTempController.c,102 :: 		Lcd_Chr(1, 16, 'C');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       16
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;AutoTempController.c,104 :: 		while(1){
L_main21:
;AutoTempController.c,105 :: 		temp = ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
;AutoTempController.c,106 :: 		mV = temp * 5000.0 /1024.0;
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
;AutoTempController.c,107 :: 		Temp_Actual = mV/10.0;
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
	MOVWF       main_Temp_Actual_L0+0 
	MOVF        R1, 0 
	MOVWF       main_Temp_Actual_L0+1 
	MOVF        R2, 0 
	MOVWF       main_Temp_Actual_L0+2 
	MOVF        R3, 0 
	MOVWF       main_Temp_Actual_L0+3 
;AutoTempController.c,108 :: 		intToStr (Temp_Ref, Text);
	MOVF        main_Temp_Ref_L0+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_text_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_text_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;AutoTempController.c,109 :: 		Temp_Input = Ltrim(Text);
	MOVLW       main_text_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(main_text_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
;AutoTempController.c,110 :: 		Lcd_Out(1, 11, Temp_Input);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutoTempController.c,111 :: 		Lcd_Out(2, 1, "Temp= ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_AutoTempController+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_AutoTempController+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutoTempController.c,112 :: 		FloatToStr(Temp_Actual, Text);
	MOVF        main_Temp_Actual_L0+0, 0 
	MOVWF       FARG_FloatToStr_fnum+0 
	MOVF        main_Temp_Actual_L0+1, 0 
	MOVWF       FARG_FloatToStr_fnum+1 
	MOVF        main_Temp_Actual_L0+2, 0 
	MOVWF       FARG_FloatToStr_fnum+2 
	MOVF        main_Temp_Actual_L0+3, 0 
	MOVWF       FARG_FloatToStr_fnum+3 
	MOVLW       main_text_L0+0
	MOVWF       FARG_FloatToStr_str+0 
	MOVLW       hi_addr(main_text_L0+0)
	MOVWF       FARG_FloatToStr_str+1 
	CALL        _FloatToStr+0, 0
;AutoTempController.c,113 :: 		Text[5] = 0;
	CLRF        main_text_L0+5 
;AutoTempController.c,114 :: 		Lcd_Out(2, 7, Text);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_text_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_text_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;AutoTempController.c,115 :: 		Lcd_Chr(2, 12, 223);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       223
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;AutoTempController.c,116 :: 		Lcd_Chr(2, 13, 'C');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       13
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;AutoTempController.c,119 :: 		if(Temp_Ref < Temp_Actual){            //too hot, turn on fan
	MOVF        main_Temp_Ref_L0+0, 0 
	MOVWF       R0 
	CALL        _byte2double+0, 0
	MOVF        main_Temp_Actual_L0+0, 0 
	MOVWF       R4 
	MOVF        main_Temp_Actual_L0+1, 0 
	MOVWF       R5 
	MOVF        main_Temp_Actual_L0+2, 0 
	MOVWF       R6 
	MOVF        main_Temp_Actual_L0+3, 0 
	MOVWF       R7 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main23
;AutoTempController.c,120 :: 		heater = OFF;
	BCF         PORTD+0, 0 
;AutoTempController.c,121 :: 		fan = ON;
	BSF         PORTD+0, 1 
;AutoTempController.c,122 :: 		}
	GOTO        L_main24
L_main23:
;AutoTempController.c,123 :: 		else if(Temp_Ref > Temp_Actual){       //too cold, turn on heater
	MOVF        main_Temp_Ref_L0+0, 0 
	MOVWF       R0 
	CALL        _byte2double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        main_Temp_Actual_L0+0, 0 
	MOVWF       R0 
	MOVF        main_Temp_Actual_L0+1, 0 
	MOVWF       R1 
	MOVF        main_Temp_Actual_L0+2, 0 
	MOVWF       R2 
	MOVF        main_Temp_Actual_L0+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main25
;AutoTempController.c,124 :: 		heater = ON;
	BSF         PORTD+0, 0 
;AutoTempController.c,125 :: 		fan = OFF;
	BCF         PORTD+0, 1 
;AutoTempController.c,126 :: 		}
	GOTO        L_main26
L_main25:
;AutoTempController.c,128 :: 		heater = OFF;
	BCF         PORTD+0, 0 
;AutoTempController.c,129 :: 		fan = OFF;
	BCF         PORTD+0, 1 
;AutoTempController.c,130 :: 		}
L_main26:
L_main24:
;AutoTempController.c,131 :: 		kp = Keypad_Key_Click();
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       main_kp_L0+0 
;AutoTempController.c,132 :: 		if(kp == clear)goto START;             //go to temp input mode if clear is pressed
	MOVF        R0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_main27
	GOTO        ___main_START
L_main27:
;AutoTempController.c,133 :: 		}
	GOTO        L_main21
;AutoTempController.c,136 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
