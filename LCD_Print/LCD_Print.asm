
_main:

;LCD_Print.c,19 :: 		void main() {
;LCD_Print.c,20 :: 		ANSELB =0;
	CLRF        ANSELB+0 
;LCD_Print.c,21 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;LCD_Print.c,22 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCD_Print.c,23 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCD_Print.c,25 :: 		Lcd_Out(1, 1, "Printing");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_LCD_Print+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_LCD_Print+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCD_Print.c,26 :: 		Lcd_Out(2, 1, "Something");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_LCD_Print+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_LCD_Print+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCD_Print.c,27 :: 		Lcd_Cmd(_LCD_BLINK_CURSOR_ON);
	MOVLW       15
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;LCD_Print.c,29 :: 		while(1){
L_main0:
;LCD_Print.c,31 :: 		}
	GOTO        L_main0
;LCD_Print.c,32 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
