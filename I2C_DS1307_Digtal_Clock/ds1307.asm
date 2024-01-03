
_ds1307_init:

;ds1307.c,17 :: 		unsigned char ds1307_init(){
;ds1307.c,18 :: 		I2C1_Init(100000);                    //initialize i2c at 100khz
	MOVLW       20
	MOVWF       SSP1ADD+0 
	CALL        _I2C1_Init+0, 0
;ds1307.c,19 :: 		I2C1_Start();                         //start i2c
	CALL        _I2C1_Start+0, 0
;ds1307.c,20 :: 		I2C1_Wr(ds1307_write);                //DS1307 module address when in write mode
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;ds1307.c,21 :: 		I2C1_Stop();                          //stop i2c
	CALL        _I2C1_Stop+0, 0
;ds1307.c,22 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
;ds1307.c,23 :: 		}
L_end_ds1307_init:
	RETURN      0
; end of _ds1307_init

_d_MSB:

;ds1307.c,25 :: 		unsigned char d_MSB(unsigned char value){
;ds1307.c,26 :: 		return ((value >> 4) +'0');           //shift MSB to right 4bit, + '0' is used to convert digit to a character
	MOVF        FARG_d_MSB_value+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       48
	ADDWF       R0, 1 
;ds1307.c,27 :: 		}
L_end_d_MSB:
	RETURN      0
; end of _d_MSB

_d_LSB:

;ds1307.c,29 :: 		unsigned char d_LSB(unsigned char value){
;ds1307.c,30 :: 		return ((value & 0x0F) +'0');
	MOVLW       15
	ANDWF       FARG_d_LSB_value+0, 0 
	MOVWF       R0 
	MOVLW       48
	ADDWF       R0, 1 
;ds1307.c,31 :: 		}
L_end_d_LSB:
	RETURN      0
; end of _d_LSB

_ds1307_reader:

;ds1307.c,34 :: 		unsigned char ds1307_reader(unsigned char reg_addr){
;ds1307.c,37 :: 		I2C1_Start();                         //start i2c
	CALL        _I2C1_Start+0, 0
;ds1307.c,38 :: 		I2C1_Wr(ds1307_write);                //DS1307 module address when in write mode
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;ds1307.c,39 :: 		I2C1_Wr(reg_addr);                    //write the name of address you want to read from
	MOVF        FARG_ds1307_reader_reg_addr+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;ds1307.c,40 :: 		I2C1_Repeated_Start();                //restart i2c
	CALL        _I2C1_Repeated_Start+0, 0
;ds1307.c,41 :: 		I2C1_Wr(ds1307_read);                 //DS1307 module address when in read mode
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;ds1307.c,42 :: 		data_read = I2C1_Rd(0);               //read date of register and dont acknowledge - 0
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVF        R0, 0 
	MOVWF       ds1307_reader_data_read_L0+0 
;ds1307.c,43 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;ds1307.c,45 :: 		return data_read;
	MOVF        ds1307_reader_data_read_L0+0, 0 
	MOVWF       R0 
;ds1307.c,46 :: 		}
L_end_ds1307_reader:
	RETURN      0
; end of _ds1307_reader

_ds1307_writer:

;ds1307.c,49 :: 		void ds1307_writer(unsigned char reg_addr, unsigned char data_write){
;ds1307.c,51 :: 		I2C1_Start();                         //start i2c
	CALL        _I2C1_Start+0, 0
;ds1307.c,52 :: 		I2C1_Wr(ds1307_write);                //DS1307 module address when in write mode
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;ds1307.c,53 :: 		I2C1_Wr(reg_addr);                    //write the name of address you want to read from
	MOVF        FARG_ds1307_writer_reg_addr+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;ds1307.c,54 :: 		I2C1_Wr(data_write);                 //DS1307 module address when in read mode
	MOVF        FARG_ds1307_writer_data_write+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;ds1307.c,56 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;ds1307.c,58 :: 		}
L_end_ds1307_writer:
	RETURN      0
; end of _ds1307_writer

_ds1307_getTime:

;ds1307.c,60 :: 		char ds1307_getTime(){
;ds1307.c,61 :: 		char time_t[] = "00:00:00";
	MOVLW       48
	MOVWF       ds1307_getTime_time_t_L0+0 
	MOVLW       48
	MOVWF       ds1307_getTime_time_t_L0+1 
	MOVLW       58
	MOVWF       ds1307_getTime_time_t_L0+2 
	MOVLW       48
	MOVWF       ds1307_getTime_time_t_L0+3 
	MOVLW       48
	MOVWF       ds1307_getTime_time_t_L0+4 
	MOVLW       58
	MOVWF       ds1307_getTime_time_t_L0+5 
	MOVLW       48
	MOVWF       ds1307_getTime_time_t_L0+6 
	MOVLW       48
	MOVWF       ds1307_getTime_time_t_L0+7 
	CLRF        ds1307_getTime_time_t_L0+8 
;ds1307.c,62 :: 		second = ds1307_reader(ds1307_sec);
	CLRF        FARG_ds1307_reader_reg_addr+0 
	CALL        _ds1307_reader+0, 0
	MOVF        R0, 0 
	MOVWF       _second+0 
	MOVLW       0
	MOVWF       _second+1 
;ds1307.c,63 :: 		minute = ds1307_reader(ds1307_min);
	MOVLW       1
	MOVWF       FARG_ds1307_reader_reg_addr+0 
	CALL        _ds1307_reader+0, 0
	MOVF        R0, 0 
	MOVWF       _minute+0 
	MOVLW       0
	MOVWF       _minute+1 
;ds1307.c,64 :: 		hr = ds1307_reader(ds1307_hour);
	MOVLW       2
	MOVWF       FARG_ds1307_reader_reg_addr+0 
	CALL        _ds1307_reader+0, 0
	MOVF        R0, 0 
	MOVWF       _hr+0 
	MOVLW       0
	MOVWF       _hr+1 
;ds1307.c,65 :: 		hour = hr & 0b00011111;
	MOVLW       31
	ANDWF       _hr+0, 0 
	MOVWF       R0 
	MOVF        _hr+1, 0 
	MOVWF       R1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVF        R0, 0 
	MOVWF       _hour+0 
	MOVF        R1, 0 
	MOVWF       _hour+1 
;ds1307.c,67 :: 		time_t[0] = d_MSB(hour);
	MOVF        R0, 0 
	MOVWF       FARG_d_MSB_value+0 
	CALL        _d_MSB+0, 0
	MOVF        R0, 0 
	MOVWF       ds1307_getTime_time_t_L0+0 
;ds1307.c,68 :: 		time_t[1] = d_LSB(hour);
	MOVF        _hour+0, 0 
	MOVWF       FARG_d_LSB_value+0 
	CALL        _d_LSB+0, 0
	MOVF        R0, 0 
	MOVWF       ds1307_getTime_time_t_L0+1 
;ds1307.c,69 :: 		time_t[3] = d_MSB(minute);
	MOVF        _minute+0, 0 
	MOVWF       FARG_d_MSB_value+0 
	CALL        _d_MSB+0, 0
	MOVF        R0, 0 
	MOVWF       ds1307_getTime_time_t_L0+3 
;ds1307.c,70 :: 		time_t[4] = d_LSB(minute);
	MOVF        _minute+0, 0 
	MOVWF       FARG_d_LSB_value+0 
	CALL        _d_LSB+0, 0
	MOVF        R0, 0 
	MOVWF       ds1307_getTime_time_t_L0+4 
;ds1307.c,71 :: 		time_t[6] = d_MSB(second);
	MOVF        _second+0, 0 
	MOVWF       FARG_d_MSB_value+0 
	CALL        _d_MSB+0, 0
	MOVF        R0, 0 
	MOVWF       ds1307_getTime_time_t_L0+6 
;ds1307.c,72 :: 		time_t[7] = d_LSB(second);
	MOVF        _second+0, 0 
	MOVWF       FARG_d_LSB_value+0 
	CALL        _d_LSB+0, 0
	MOVF        R0, 0 
	MOVWF       ds1307_getTime_time_t_L0+7 
;ds1307.c,74 :: 		return time_t;
	MOVLW       ds1307_getTime_time_t_L0+0
	MOVWF       R0 
;ds1307.c,75 :: 		}
L_end_ds1307_getTime:
	RETURN      0
; end of _ds1307_getTime

_ds1307_getDate:

;ds1307.c,77 :: 		char ds1307_getDate(){
;ds1307.c,78 :: 		char date_t[] = "00/00/00";
	MOVLW       48
	MOVWF       ds1307_getDate_date_t_L0+0 
	MOVLW       48
	MOVWF       ds1307_getDate_date_t_L0+1 
	MOVLW       47
	MOVWF       ds1307_getDate_date_t_L0+2 
	MOVLW       48
	MOVWF       ds1307_getDate_date_t_L0+3 
	MOVLW       48
	MOVWF       ds1307_getDate_date_t_L0+4 
	MOVLW       47
	MOVWF       ds1307_getDate_date_t_L0+5 
	MOVLW       48
	MOVWF       ds1307_getDate_date_t_L0+6 
	MOVLW       48
	MOVWF       ds1307_getDate_date_t_L0+7 
	CLRF        ds1307_getDate_date_t_L0+8 
;ds1307.c,79 :: 		day = ds1307_reader(ds1307_day);
	MOVLW       3
	MOVWF       FARG_ds1307_reader_reg_addr+0 
	CALL        _ds1307_reader+0, 0
	MOVF        R0, 0 
	MOVWF       _day+0 
	MOVLW       0
	MOVWF       _day+1 
;ds1307.c,80 :: 		date = ds1307_reader(ds1307_date);
	MOVLW       4
	MOVWF       FARG_ds1307_reader_reg_addr+0 
	CALL        _ds1307_reader+0, 0
	MOVF        R0, 0 
	MOVWF       _date+0 
	MOVLW       0
	MOVWF       _date+1 
;ds1307.c,81 :: 		month = ds1307_reader(ds1307_month);
	MOVLW       5
	MOVWF       FARG_ds1307_reader_reg_addr+0 
	CALL        _ds1307_reader+0, 0
	MOVF        R0, 0 
	MOVWF       _month+0 
	MOVLW       0
	MOVWF       _month+1 
;ds1307.c,82 :: 		year = ds1307_reader(ds1307_year);
	MOVLW       6
	MOVWF       FARG_ds1307_reader_reg_addr+0 
	CALL        _ds1307_reader+0, 0
	MOVF        R0, 0 
	MOVWF       _year+0 
	MOVLW       0
	MOVWF       _year+1 
;ds1307.c,84 :: 		date_t[0] = d_MSB(day);
	MOVF        _day+0, 0 
	MOVWF       FARG_d_MSB_value+0 
	CALL        _d_MSB+0, 0
	MOVF        R0, 0 
	MOVWF       ds1307_getDate_date_t_L0+0 
;ds1307.c,85 :: 		date_t[1] = d_LSB(day);
	MOVF        _day+0, 0 
	MOVWF       FARG_d_LSB_value+0 
	CALL        _d_LSB+0, 0
	MOVF        R0, 0 
	MOVWF       ds1307_getDate_date_t_L0+1 
;ds1307.c,86 :: 		date_t[3] = d_MSB(month);
	MOVF        _month+0, 0 
	MOVWF       FARG_d_MSB_value+0 
	CALL        _d_MSB+0, 0
	MOVF        R0, 0 
	MOVWF       ds1307_getDate_date_t_L0+3 
;ds1307.c,87 :: 		date_t[4] = d_LSB(month);
	MOVF        _month+0, 0 
	MOVWF       FARG_d_LSB_value+0 
	CALL        _d_LSB+0, 0
	MOVF        R0, 0 
	MOVWF       ds1307_getDate_date_t_L0+4 
;ds1307.c,88 :: 		date_t[6] = d_MSB(year);
	MOVF        _year+0, 0 
	MOVWF       FARG_d_MSB_value+0 
	CALL        _d_MSB+0, 0
	MOVF        R0, 0 
	MOVWF       ds1307_getDate_date_t_L0+6 
;ds1307.c,89 :: 		date_t[7] = d_LSB(year);
	MOVF        _year+0, 0 
	MOVWF       FARG_d_LSB_value+0 
	CALL        _d_LSB+0, 0
	MOVF        R0, 0 
	MOVWF       ds1307_getDate_date_t_L0+7 
;ds1307.c,91 :: 		return date_t;
	MOVLW       ds1307_getDate_date_t_L0+0
	MOVWF       R0 
;ds1307.c,92 :: 		}
L_end_ds1307_getDate:
	RETURN      0
; end of _ds1307_getDate

_binaryToBCD:

;ds1307.c,95 :: 		unsigned char binaryToBCD(unsigned char binary){
;ds1307.c,97 :: 		lsb = (binary%10)&0x0F;
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_binaryToBCD_binary+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       15
	ANDWF       R0, 0 
	MOVWF       FLOC__binaryToBCD+0 
;ds1307.c,98 :: 		msb = binary - lsb;
	MOVF        FLOC__binaryToBCD+0, 0 
	SUBWF       FARG_binaryToBCD_binary+0, 0 
	MOVWF       R0 
;ds1307.c,99 :: 		msb /=10;
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
;ds1307.c,100 :: 		msb = msb<<4;
	MOVF        R0, 0 
	MOVWF       R1 
	RLCF        R1, 1 
	BCF         R1, 0 
	RLCF        R1, 1 
	BCF         R1, 0 
	RLCF        R1, 1 
	BCF         R1, 0 
	RLCF        R1, 1 
	BCF         R1, 0 
;ds1307.c,101 :: 		msb = msb & 0xF0;
	MOVLW       240
	ANDWF       R1, 0 
	MOVWF       R0 
;ds1307.c,102 :: 		return (msb|lsb);
	MOVF        FLOC__binaryToBCD+0, 0 
	IORWF       R0, 1 
;ds1307.c,103 :: 		}
L_end_binaryToBCD:
	RETURN      0
; end of _binaryToBCD

_bcdToBinary:

;ds1307.c,105 :: 		unsigned char bcdToBinary(unsigned char bcd){
;ds1307.c,107 :: 		lsb = bcd & 0x0F;
	MOVLW       15
	ANDWF       FARG_bcdToBinary_bcd+0, 0 
	MOVWF       R3 
;ds1307.c,108 :: 		msb = bcd & 0xF0;
	MOVLW       240
	ANDWF       FARG_bcdToBinary_bcd+0, 0 
	MOVWF       R2 
;ds1307.c,109 :: 		msb = msb >>4;
	MOVF        R2, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
;ds1307.c,110 :: 		msb *=10;
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
;ds1307.c,111 :: 		return(msb+lsb);
	MOVF        R3, 0 
	ADDWF       R0, 1 
;ds1307.c,112 :: 		}
L_end_bcdToBinary:
	RETURN      0
; end of _bcdToBinary
