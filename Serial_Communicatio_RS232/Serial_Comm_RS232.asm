
_main:

;Serial_Comm_RS232.c,19 :: 		void main() {
;Serial_Comm_RS232.c,20 :: 		TRISB = 0;       //set port B as output
	CLRF        TRISB+0 
;Serial_Comm_RS232.c,21 :: 		ANSELB = 0;      //Set PORT B as Digital Pins
	CLRF        ANSELB+0 
;Serial_Comm_RS232.c,22 :: 		ANSELC = 0;      //Set PORT B as Digital Pins ***UART1 wont read if not set
	CLRF        ANSELC+0 
;Serial_Comm_RS232.c,23 :: 		OSCCON = 0x66;   //configure OSCON Register for internal oscillator : datasheet
	MOVLW       102
	MOVWF       OSCCON+0 
;Serial_Comm_RS232.c,25 :: 		UART1_Init(9600);      //initialize UART module
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Serial_Comm_RS232.c,26 :: 		Delay_ms(100);         //wait
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
;Serial_Comm_RS232.c,27 :: 		UART1_Write_Text("2MJ \r\n");
	MOVLW       ?lstr1_Serial_Comm_RS232+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_Serial_Comm_RS232+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Serial_Comm_RS232.c,28 :: 		Delay_ms(500);         //wait
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main1:
	DECFSZ      R13, 1, 1
	BRA         L_main1
	DECFSZ      R12, 1, 1
	BRA         L_main1
	DECFSZ      R11, 1, 1
	BRA         L_main1
	NOP
	NOP
;Serial_Comm_RS232.c,29 :: 		UART1_Write_Text(" Press 1 for Red \r\n Press 2 for Green \r\n Press 3 for Blue \r\n");
	MOVLW       ?lstr2_Serial_Comm_RS232+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_Serial_Comm_RS232+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Serial_Comm_RS232.c,31 :: 		Led_Red = ON;
	BSF         LATB0_bit+0, BitPos(LATB0_bit+0) 
;Serial_Comm_RS232.c,32 :: 		Led_Green = ON;
	BSF         LATB1_bit+0, BitPos(LATB1_bit+0) 
;Serial_Comm_RS232.c,33 :: 		Led_Blue = ON;
	BSF         LATB2_bit+0, BitPos(LATB2_bit+0) 
;Serial_Comm_RS232.c,34 :: 		Delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
	NOP
;Serial_Comm_RS232.c,35 :: 		Led_Red = OFF;
	BCF         LATB0_bit+0, BitPos(LATB0_bit+0) 
;Serial_Comm_RS232.c,36 :: 		Led_Green = OFF;
	BCF         LATB1_bit+0, BitPos(LATB1_bit+0) 
;Serial_Comm_RS232.c,37 :: 		Led_Blue = OFF;
	BCF         LATB2_bit+0, BitPos(LATB2_bit+0) 
;Serial_Comm_RS232.c,40 :: 		while(1){
L_main3:
;Serial_Comm_RS232.c,42 :: 		if(UART1_Data_Ready() == 1){
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main5
;Serial_Comm_RS232.c,43 :: 		UART1_Write_Text("\r\n data ready \r\n");
	MOVLW       ?lstr3_Serial_Comm_RS232+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr3_Serial_Comm_RS232+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Serial_Comm_RS232.c,45 :: 		read_uart = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _read_uart+0 
;Serial_Comm_RS232.c,46 :: 		switch(read_uart){
	GOTO        L_main6
;Serial_Comm_RS232.c,47 :: 		case '1':
L_main8:
;Serial_Comm_RS232.c,48 :: 		Led_Red = ON;
	BSF         LATB0_bit+0, BitPos(LATB0_bit+0) 
;Serial_Comm_RS232.c,49 :: 		Led_Green = OFF;
	BCF         LATB1_bit+0, BitPos(LATB1_bit+0) 
;Serial_Comm_RS232.c,50 :: 		Led_Blue = OFF;
	BCF         LATB2_bit+0, BitPos(LATB2_bit+0) 
;Serial_Comm_RS232.c,51 :: 		break;
	GOTO        L_main7
;Serial_Comm_RS232.c,53 :: 		case '2':
L_main9:
;Serial_Comm_RS232.c,54 :: 		Led_Red = OFF;
	BCF         LATB0_bit+0, BitPos(LATB0_bit+0) 
;Serial_Comm_RS232.c,55 :: 		Led_Green = ON;
	BSF         LATB1_bit+0, BitPos(LATB1_bit+0) 
;Serial_Comm_RS232.c,56 :: 		Led_Blue = OFF;
	BCF         LATB2_bit+0, BitPos(LATB2_bit+0) 
;Serial_Comm_RS232.c,57 :: 		break;
	GOTO        L_main7
;Serial_Comm_RS232.c,59 :: 		case '3':
L_main10:
;Serial_Comm_RS232.c,60 :: 		Led_Red = OFF;
	BCF         LATB0_bit+0, BitPos(LATB0_bit+0) 
;Serial_Comm_RS232.c,61 :: 		Led_Green = OFF;
	BCF         LATB1_bit+0, BitPos(LATB1_bit+0) 
;Serial_Comm_RS232.c,62 :: 		Led_Blue = ON;
	BSF         LATB2_bit+0, BitPos(LATB2_bit+0) 
;Serial_Comm_RS232.c,63 :: 		break;
	GOTO        L_main7
;Serial_Comm_RS232.c,65 :: 		default:
L_main11:
;Serial_Comm_RS232.c,66 :: 		Led_Red = OFF;
	BCF         LATB0_bit+0, BitPos(LATB0_bit+0) 
;Serial_Comm_RS232.c,67 :: 		Led_Green = OFF;
	BCF         LATB1_bit+0, BitPos(LATB1_bit+0) 
;Serial_Comm_RS232.c,68 :: 		Led_Blue = OFF;
	BCF         LATB2_bit+0, BitPos(LATB2_bit+0) 
;Serial_Comm_RS232.c,69 :: 		break;
	GOTO        L_main7
;Serial_Comm_RS232.c,70 :: 		}
L_main6:
	MOVF        _read_uart+0, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
	MOVF        _read_uart+0, 0 
	XORLW       50
	BTFSC       STATUS+0, 2 
	GOTO        L_main9
	MOVF        _read_uart+0, 0 
	XORLW       51
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
	GOTO        L_main11
L_main7:
;Serial_Comm_RS232.c,71 :: 		}
L_main5:
;Serial_Comm_RS232.c,72 :: 		}
	GOTO        L_main3
;Serial_Comm_RS232.c,73 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
