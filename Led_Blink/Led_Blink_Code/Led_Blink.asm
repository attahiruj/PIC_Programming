
_main:

;Led_Blink.c,4 :: 		void main() {
;Led_Blink.c,5 :: 		TRISC5_bit = 0;   //set pin c2 to output   sourcing
	BCF         TRISC5_bit+0, BitPos(TRISC5_bit+0) 
;Led_Blink.c,6 :: 		TRISC2_bit = 0;   //set pin c2 to output   sinking
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;Led_Blink.c,7 :: 		ANSELC = 0;       //set port C (ANALOGSELECT) to Digital
	CLRF        ANSELC+0 
;Led_Blink.c,8 :: 		while(1){
L_main0:
;Led_Blink.c,9 :: 		LATC.B5 =  0;        //portC.bit5 to low
	BCF         LATC+0, 5 
;Led_Blink.c,10 :: 		LATC.B2 =  0;
	BCF         LATC+0, 2 
;Led_Blink.c,11 :: 		Delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
;Led_Blink.c,12 :: 		LATC.B5 =  1;
	BSF         LATC+0, 5 
;Led_Blink.c,13 :: 		LATC.B2 =  1;
	BSF         LATC+0, 2 
;Led_Blink.c,14 :: 		Delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
;Led_Blink.c,15 :: 		}
	GOTO        L_main0
;Led_Blink.c,16 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
