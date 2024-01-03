
_boot:

;Digtal_Clock.c,44 :: 		void boot(){
;Digtal_Clock.c,45 :: 		OSCCON = 0x66;
	MOVLW       102
	MOVWF       OSCCON+0 
;Digtal_Clock.c,46 :: 		ANSELD = 0;
	CLRF        ANSELD+0 
;Digtal_Clock.c,47 :: 		TRISD = 1;
	MOVLW       1
	MOVWF       TRISD+0 
;Digtal_Clock.c,48 :: 		ANSELC = 0;
	CLRF        ANSELC+0 
;Digtal_Clock.c,51 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Digtal_Clock.c,52 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_boot0:
	DECFSZ      R13, 1, 1
	BRA         L_boot0
	DECFSZ      R12, 1, 1
	BRA         L_boot0
	DECFSZ      R11, 1, 1
	BRA         L_boot0
;Digtal_Clock.c,53 :: 		UART1_Write_Text("UART Init\r\n");
	MOVLW       ?lstr1_Digtal_Clock+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_Digtal_Clock+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Digtal_Clock.c,54 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_boot1:
	DECFSZ      R13, 1, 1
	BRA         L_boot1
	DECFSZ      R12, 1, 1
	BRA         L_boot1
	DECFSZ      R11, 1, 1
	BRA         L_boot1
;Digtal_Clock.c,57 :: 		ANSELB = 0;
	CLRF        ANSELB+0 
;Digtal_Clock.c,58 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;Digtal_Clock.c,59 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Digtal_Clock.c,60 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Digtal_Clock.c,61 :: 		UART1_Write_Text("LCD init \r\n");
	MOVLW       ?lstr2_Digtal_Clock+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_Digtal_Clock+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Digtal_Clock.c,62 :: 		Lcd_Out(1, 1,"Digital Clock");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_Digtal_Clock+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_Digtal_Clock+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Digtal_Clock.c,63 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_boot2:
	DECFSZ      R13, 1, 1
	BRA         L_boot2
	DECFSZ      R12, 1, 1
	BRA         L_boot2
	DECFSZ      R11, 1, 1
	BRA         L_boot2
;Digtal_Clock.c,64 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Digtal_Clock.c,65 :: 		Lcd_Out(1,1, "Time: ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_Digtal_Clock+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_Digtal_Clock+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Digtal_Clock.c,66 :: 		Lcd_Out(2,1, "Date: ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_Digtal_Clock+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_Digtal_Clock+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Digtal_Clock.c,70 :: 		if(ds1307_init() == 1){
	CALL        _ds1307_init+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_boot3
;Digtal_Clock.c,71 :: 		UART1_Write_Text("ds1307 init \r\n");
	MOVLW       ?lstr6_Digtal_Clock+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr6_Digtal_Clock+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Digtal_Clock.c,72 :: 		}else UART1_Write_Text("ds1307 init failed\r\n");
	GOTO        L_boot4
L_boot3:
	MOVLW       ?lstr7_Digtal_Clock+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr7_Digtal_Clock+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
L_boot4:
;Digtal_Clock.c,73 :: 		delay_ms(200);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_boot5:
	DECFSZ      R13, 1, 1
	BRA         L_boot5
	DECFSZ      R12, 1, 1
	BRA         L_boot5
	DECFSZ      R11, 1, 1
	BRA         L_boot5
;Digtal_Clock.c,76 :: 		ANSELA = 0;                    //disable  analog on port A
	CLRF        ANSELA+0 
;Digtal_Clock.c,77 :: 		TRISD = 0x07;                  //set  RA1, RA2 and RA3 as input
	MOVLW       7
	MOVWF       TRISD+0 
;Digtal_Clock.c,78 :: 		PORTA = 0x00;                  //initialise port A to 0
	CLRF        PORTA+0 
;Digtal_Clock.c,80 :: 		UART1_Write_Text("Boot OK\r\n");
	MOVLW       ?lstr8_Digtal_Clock+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr8_Digtal_Clock+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Digtal_Clock.c,82 :: 		}
L_end_boot:
	RETURN      0
; end of _boot

_main:

;Digtal_Clock.c,85 :: 		void main() {
;Digtal_Clock.c,87 :: 		boot();
	CALL        _boot+0, 0
;Digtal_Clock.c,89 :: 		while (1){
L_main6:
;Digtal_Clock.c,91 :: 		set = 0;
	CLRF        _set+0 
;Digtal_Clock.c,92 :: 		if(!setBtn){
	BTFSC       PORTA+0, 0 
	GOTO        L_main8
;Digtal_Clock.c,93 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_main9:
	DECFSZ      R13, 1, 1
	BRA         L_main9
	DECFSZ      R12, 1, 1
	BRA         L_main9
	NOP
;Digtal_Clock.c,94 :: 		if(!setBtn){
	BTFSC       PORTA+0, 0 
	GOTO        L_main10
;Digtal_Clock.c,95 :: 		set_position++; UART1_Write_Text("setBtn pressed\r\n");
	INCF        _set_position+0, 1 
	MOVLW       ?lstr9_Digtal_Clock+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr9_Digtal_Clock+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Digtal_Clock.c,96 :: 		if(set_position >= 7){
	MOVLW       7
	SUBWF       _set_position+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main11
;Digtal_Clock.c,97 :: 		set_position = 0;
	CLRF        _set_position+0 
;Digtal_Clock.c,98 :: 		}
L_main11:
;Digtal_Clock.c,99 :: 		}
L_main10:
;Digtal_Clock.c,100 :: 		}
L_main8:
;Digtal_Clock.c,102 :: 		if(set_position){
	MOVF        _set_position+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
;Digtal_Clock.c,104 :: 		if(!upBtn){
	BTFSC       PORTA+0, 1 
	GOTO        L_main13
;Digtal_Clock.c,105 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_main14:
	DECFSZ      R13, 1, 1
	BRA         L_main14
	DECFSZ      R12, 1, 1
	BRA         L_main14
	NOP
;Digtal_Clock.c,106 :: 		if(!upBtn){
	BTFSC       PORTA+0, 1 
	GOTO        L_main15
;Digtal_Clock.c,107 :: 		set = 1;
	MOVLW       1
	MOVWF       _set+0 
;Digtal_Clock.c,108 :: 		}
L_main15:
;Digtal_Clock.c,109 :: 		}
L_main13:
;Digtal_Clock.c,111 :: 		if(!downBtn){
	BTFSC       PORTA+0, 2 
	GOTO        L_main16
;Digtal_Clock.c,112 :: 		delay_ms(10);
	MOVLW       26
	MOVWF       R12, 0
	MOVLW       248
	MOVWF       R13, 0
L_main17:
	DECFSZ      R13, 1, 1
	BRA         L_main17
	DECFSZ      R12, 1, 1
	BRA         L_main17
	NOP
;Digtal_Clock.c,113 :: 		if(!downBtn){
	BTFSC       PORTA+0, 2 
	GOTO        L_main18
;Digtal_Clock.c,114 :: 		set = -1;
	MOVLW       255
	MOVWF       _set+0 
;Digtal_Clock.c,115 :: 		}
L_main18:
;Digtal_Clock.c,116 :: 		}
L_main16:
;Digtal_Clock.c,117 :: 		}
L_main12:
;Digtal_Clock.c,119 :: 		if(set_position && set){
	MOVF        _set_position+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main21
	MOVF        _set+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main21
L__main43:
;Digtal_Clock.c,120 :: 		switch(set_position){
	GOTO        L_main22
;Digtal_Clock.c,121 :: 		case 1:
L_main24:
;Digtal_Clock.c,122 :: 		set_hour = ds1307_reader(ds1307_hour);
	MOVLW       2
	MOVWF       FARG_ds1307_reader_reg_addr+0 
	CALL        _ds1307_reader+0, 0
	MOVF        R0, 0 
	MOVWF       _set_hour+0 
;Digtal_Clock.c,123 :: 		set_hour = bcdToBinary(set_hour);
	MOVF        R0, 0 
	MOVWF       FARG_bcdToBinary_bcd+0 
	CALL        _bcdToBinary+0, 0
	MOVF        R0, 0 
	MOVWF       _set_hour+0 
;Digtal_Clock.c,124 :: 		set_hour = set_hour + set;
	MOVF        _set+0, 0 
	ADDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _set_hour+0 
;Digtal_Clock.c,125 :: 		set_hour = binaryToBcd(set_hour);
	MOVF        R0, 0 
	MOVWF       FARG_binaryToBCD_binary+0 
	CALL        _binaryToBCD+0, 0
	MOVF        R0, 0 
	MOVWF       _set_hour+0 
;Digtal_Clock.c,126 :: 		if((set_hour & 0x1F) >= 0x13){
	MOVLW       31
	ANDWF       R0, 0 
	MOVWF       R1 
	MOVLW       19
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main25
;Digtal_Clock.c,127 :: 		set_hour = set_hour & 0b11100001;
	MOVLW       225
	ANDWF       _set_hour+0, 1 
;Digtal_Clock.c,128 :: 		set_hour = set_hour ^ 0x20;
	BTG         _set_hour+0, 5 
;Digtal_Clock.c,129 :: 		}
	GOTO        L_main26
L_main25:
;Digtal_Clock.c,130 :: 		else if((set_hour & 0x1F) <= 0x00){
	MOVLW       31
	ANDWF       _set_hour+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 0 
	GOTO        L_main27
;Digtal_Clock.c,131 :: 		set_hour = set_hour | 0b00010010;
	MOVLW       18
	IORWF       _set_hour+0, 1 
;Digtal_Clock.c,132 :: 		set_hour = set_hour ^ 0x20;
	BTG         _set_hour+0, 5 
;Digtal_Clock.c,133 :: 		}
L_main27:
L_main26:
;Digtal_Clock.c,134 :: 		ds1307_writer(ds1307_hour, set_hour);
	MOVLW       2
	MOVWF       FARG_ds1307_writer_reg_addr+0 
	MOVF        _set_hour+0, 0 
	MOVWF       FARG_ds1307_writer_data_write+0 
	CALL        _ds1307_writer+0, 0
;Digtal_Clock.c,135 :: 		break;
	GOTO        L_main23
;Digtal_Clock.c,137 :: 		case 2:
L_main28:
;Digtal_Clock.c,138 :: 		set_minute = ds1307_reader(ds1307_min);
	MOVLW       1
	MOVWF       FARG_ds1307_reader_reg_addr+0 
	CALL        _ds1307_reader+0, 0
	MOVF        R0, 0 
	MOVWF       _set_minute+0 
;Digtal_Clock.c,139 :: 		set_minute = bcdToBinary(set_minute);
	MOVF        R0, 0 
	MOVWF       FARG_bcdToBinary_bcd+0 
	CALL        _bcdToBinary+0, 0
	MOVF        R0, 0 
	MOVWF       _set_minute+0 
;Digtal_Clock.c,140 :: 		set_minute = set_minute + set;
	MOVF        _set+0, 0 
	ADDWF       R0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _set_minute+0 
;Digtal_Clock.c,141 :: 		if(set_minute >= 60) set_minute = 0;
	MOVLW       60
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main29
	CLRF        _set_minute+0 
L_main29:
;Digtal_Clock.c,142 :: 		if(set_minute <= 0) set_minute = 59;
	MOVF        _set_minute+0, 0 
	SUBLW       0
	BTFSS       STATUS+0, 0 
	GOTO        L_main30
	MOVLW       59
	MOVWF       _set_minute+0 
L_main30:
;Digtal_Clock.c,143 :: 		set_minute = binaryToBcd(set_minute);
	MOVF        _set_minute+0, 0 
	MOVWF       FARG_binaryToBCD_binary+0 
	CALL        _binaryToBCD+0, 0
	MOVF        R0, 0 
	MOVWF       _set_minute+0 
;Digtal_Clock.c,144 :: 		ds1307_writer(ds1307_min, set_minute);
	MOVLW       1
	MOVWF       FARG_ds1307_writer_reg_addr+0 
	MOVF        R0, 0 
	MOVWF       FARG_ds1307_writer_data_write+0 
	CALL        _ds1307_writer+0, 0
;Digtal_Clock.c,145 :: 		break;
	GOTO        L_main23
;Digtal_Clock.c,147 :: 		case 3:
L_main31:
;Digtal_Clock.c,148 :: 		if(set){
	MOVF        _set+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main32
;Digtal_Clock.c,149 :: 		ds1307_writer(ds1307_sec, 0x00);
	CLRF        FARG_ds1307_writer_reg_addr+0 
	CLRF        FARG_ds1307_writer_data_write+0 
	CALL        _ds1307_writer+0, 0
;Digtal_Clock.c,150 :: 		}
L_main32:
;Digtal_Clock.c,151 :: 		break;
	GOTO        L_main23
;Digtal_Clock.c,153 :: 		case 4:
L_main33:
;Digtal_Clock.c,154 :: 		set_day = ds1307_reader(ds1307_day);
	MOVLW       3
	MOVWF       FARG_ds1307_reader_reg_addr+0 
	CALL        _ds1307_reader+0, 0
	MOVF        R0, 0 
	MOVWF       _set_day+0 
;Digtal_Clock.c,155 :: 		set_day = bcdToBinary(set_day);
	MOVF        R0, 0 
	MOVWF       FARG_bcdToBinary_bcd+0 
	CALL        _bcdToBinary+0, 0
	MOVF        R0, 0 
	MOVWF       _set_day+0 
;Digtal_Clock.c,156 :: 		set_day = set_day + set;
	MOVF        _set+0, 0 
	ADDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _set_day+0 
;Digtal_Clock.c,157 :: 		set_day = binaryToBcd(set_day);
	MOVF        R0, 0 
	MOVWF       FARG_binaryToBCD_binary+0 
	CALL        _binaryToBCD+0, 0
	MOVF        R0, 0 
	MOVWF       _set_day+0 
;Digtal_Clock.c,158 :: 		if(set_day >= 0x32){
	MOVLW       50
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main34
;Digtal_Clock.c,159 :: 		set_day = 1;
	MOVLW       1
	MOVWF       _set_day+0 
;Digtal_Clock.c,160 :: 		}
L_main34:
;Digtal_Clock.c,161 :: 		if(set_day <= 0x00){
	MOVF        _set_day+0, 0 
	SUBLW       0
	BTFSS       STATUS+0, 0 
	GOTO        L_main35
;Digtal_Clock.c,162 :: 		set_day = 0x31;
	MOVLW       49
	MOVWF       _set_day+0 
;Digtal_Clock.c,163 :: 		}
L_main35:
;Digtal_Clock.c,164 :: 		ds1307_writer(ds1307_day, set_day);
	MOVLW       3
	MOVWF       FARG_ds1307_writer_reg_addr+0 
	MOVF        _set_day+0, 0 
	MOVWF       FARG_ds1307_writer_data_write+0 
	CALL        _ds1307_writer+0, 0
;Digtal_Clock.c,165 :: 		break;
	GOTO        L_main23
;Digtal_Clock.c,167 :: 		case 5:
L_main36:
;Digtal_Clock.c,168 :: 		set_month = ds1307_reader(ds1307_month);
	MOVLW       5
	MOVWF       FARG_ds1307_reader_reg_addr+0 
	CALL        _ds1307_reader+0, 0
	MOVF        R0, 0 
	MOVWF       _set_month+0 
;Digtal_Clock.c,169 :: 		set_month = bcdToBinary(set_month);
	MOVF        R0, 0 
	MOVWF       FARG_bcdToBinary_bcd+0 
	CALL        _bcdToBinary+0, 0
	MOVF        R0, 0 
	MOVWF       _set_month+0 
;Digtal_Clock.c,170 :: 		set_month = set_month + set;
	MOVF        _set+0, 0 
	ADDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _set_month+0 
;Digtal_Clock.c,171 :: 		set_month = binaryToBcd(set_month);
	MOVF        R0, 0 
	MOVWF       FARG_binaryToBCD_binary+0 
	CALL        _binaryToBCD+0, 0
	MOVF        R0, 0 
	MOVWF       _set_month+0 
;Digtal_Clock.c,172 :: 		if(set_month >= 0x12){
	MOVLW       18
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main37
;Digtal_Clock.c,173 :: 		set_month = 1;
	MOVLW       1
	MOVWF       _set_month+0 
;Digtal_Clock.c,174 :: 		}
L_main37:
;Digtal_Clock.c,175 :: 		if(set_month <= 0x00){
	MOVF        _set_month+0, 0 
	SUBLW       0
	BTFSS       STATUS+0, 0 
	GOTO        L_main38
;Digtal_Clock.c,176 :: 		set_month = 0x12;
	MOVLW       18
	MOVWF       _set_month+0 
;Digtal_Clock.c,177 :: 		}
L_main38:
;Digtal_Clock.c,178 :: 		ds1307_writer(ds1307_month, set_month);
	MOVLW       5
	MOVWF       FARG_ds1307_writer_reg_addr+0 
	MOVF        _set_month+0, 0 
	MOVWF       FARG_ds1307_writer_data_write+0 
	CALL        _ds1307_writer+0, 0
;Digtal_Clock.c,179 :: 		break;
	GOTO        L_main23
;Digtal_Clock.c,181 :: 		case 6:
L_main39:
;Digtal_Clock.c,182 :: 		set_year = ds1307_reader(ds1307_day);
	MOVLW       3
	MOVWF       FARG_ds1307_reader_reg_addr+0 
	CALL        _ds1307_reader+0, 0
	MOVF        R0, 0 
	MOVWF       _set_year+0 
;Digtal_Clock.c,183 :: 		set_year = bcdToBinary(set_year);
	MOVF        R0, 0 
	MOVWF       FARG_bcdToBinary_bcd+0 
	CALL        _bcdToBinary+0, 0
	MOVF        R0, 0 
	MOVWF       _set_year+0 
;Digtal_Clock.c,184 :: 		set_year = set_day + set;
	MOVF        _set+0, 0 
	ADDWF       _set_day+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _set_year+0 
;Digtal_Clock.c,185 :: 		set_year = binaryToBcd(set_year);
	MOVF        R0, 0 
	MOVWF       FARG_binaryToBCD_binary+0 
	CALL        _binaryToBCD+0, 0
	MOVF        R0, 0 
	MOVWF       _set_year+0 
;Digtal_Clock.c,186 :: 		if(set_year >= 0x50){
	MOVLW       80
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main40
;Digtal_Clock.c,187 :: 		set_year = 0x00;
	CLRF        _set_year+0 
;Digtal_Clock.c,188 :: 		}
L_main40:
;Digtal_Clock.c,189 :: 		if(set_year <= -1){
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main46
	MOVF        _set_year+0, 0 
	SUBLW       255
L__main46:
	BTFSS       STATUS+0, 0 
	GOTO        L_main41
;Digtal_Clock.c,190 :: 		set_year = 0x99;
	MOVLW       153
	MOVWF       _set_year+0 
;Digtal_Clock.c,191 :: 		}
L_main41:
;Digtal_Clock.c,192 :: 		ds1307_writer(ds1307_year, set_year);
	MOVLW       6
	MOVWF       FARG_ds1307_writer_reg_addr+0 
	MOVF        _set_year+0, 0 
	MOVWF       FARG_ds1307_writer_data_write+0 
	CALL        _ds1307_writer+0, 0
;Digtal_Clock.c,193 :: 		break;
	GOTO        L_main23
;Digtal_Clock.c,194 :: 		}
L_main22:
	MOVF        _set_position+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main24
	MOVF        _set_position+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main28
	MOVF        _set_position+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main31
	MOVF        _set_position+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_main33
	MOVF        _set_position+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_main36
	MOVF        _set_position+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_main39
L_main23:
;Digtal_Clock.c,195 :: 		}
L_main21:
;Digtal_Clock.c,197 :: 		Lcd_Out(1,7, ds1307_getTime());
	CALL        _ds1307_getTime+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	CALL        _Lcd_Out+0, 0
;Digtal_Clock.c,198 :: 		Lcd_Out(2,7, ds1307_getDate());
	CALL        _ds1307_getDate+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	MOVWF       FARG_Lcd_Out_text+1 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	CALL        _Lcd_Out+0, 0
;Digtal_Clock.c,200 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main42:
	DECFSZ      R13, 1, 1
	BRA         L_main42
	DECFSZ      R12, 1, 1
	BRA         L_main42
	DECFSZ      R11, 1, 1
	BRA         L_main42
	NOP
;Digtal_Clock.c,201 :: 		}
	GOTO        L_main6
;Digtal_Clock.c,202 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
