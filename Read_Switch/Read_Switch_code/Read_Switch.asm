
_main:

;Read_Switch.c,1 :: 		void main() {
;Read_Switch.c,2 :: 		ADCON1= 0x0F;   //switch of ADC on all pins
	MOVLW       15
	MOVWF       ADCON1+0 
;Read_Switch.c,3 :: 		TRISB0_bit = 0;  //configure portB as output
	BCF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;Read_Switch.c,4 :: 		TRISC0_bit = 1;  //configure portC as input
	BSF         TRISC0_bit+0, BitPos(TRISC0_bit+0) 
;Read_Switch.c,6 :: 		while(1){
L_main0:
;Read_Switch.c,7 :: 		if(PORTC.RC0 == 0){
	BTFSC       PORTC+0, 0 
	GOTO        L_main2
;Read_Switch.c,8 :: 		Delay_ms(1);
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	NOP
	NOP
;Read_Switch.c,9 :: 		if(PORTC.RC0 == 0){
	BTFSC       PORTC+0, 0 
	GOTO        L_main4
;Read_Switch.c,10 :: 		LATB.B0 = 1;
	BSF         LATB+0, 0 
;Read_Switch.c,11 :: 		}
L_main4:
;Read_Switch.c,12 :: 		}
	GOTO        L_main5
L_main2:
;Read_Switch.c,14 :: 		LATB.B0 = 0;
	BCF         LATB+0, 0 
;Read_Switch.c,15 :: 		}
L_main5:
;Read_Switch.c,16 :: 		}
	GOTO        L_main0
;Read_Switch.c,18 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
