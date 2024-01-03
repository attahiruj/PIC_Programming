#line 1 "C:/Users/Attahiru Jibril/Documents/Design/Electronics_Circuits-Embedded_System/mikroC/PIC_Grind/I2C_DS1307_Digtal_Clock/ds1307.c"
#line 1 "c:/users/attahiru jibril/documents/design/electronics_circuits-embedded_system/mikroc/pic_grind/i2c_ds1307_digtal_clock/ds1307.h"
#line 24 "c:/users/attahiru jibril/documents/design/electronics_circuits-embedded_system/mikroc/pic_grind/i2c_ds1307_digtal_clock/ds1307.h"
unsigned char ds1307_init();


unsigned char d_MSB(unsigned char value);
unsigned char d_LSB(unsigned char value);
unsigned char ds1307_reader(unsigned char reg_addr);
void ds1307_writer(unsigned char reg_addr, unsigned char data_write);
char ds1307_getTime();
char ds1307_getDate();
unsigned char bcdToBinary(unsigned char bcd);
unsigned char binaryToBCD(unsigned char binary);
#line 5 "C:/Users/Attahiru Jibril/Documents/Design/Electronics_Circuits-Embedded_System/mikroC/PIC_Grind/I2C_DS1307_Digtal_Clock/ds1307.c"
int second;
int minute;
int hour;
int hr;
int day;
int date;
int month;
int year;




unsigned char ds1307_init(){
 I2C1_Init(100000);
 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Stop();
 return 1;
}

unsigned char d_MSB(unsigned char value){
 return ((value >> 4) +'0');
}

unsigned char d_LSB(unsigned char value){
 return ((value & 0x0F) +'0');
}


unsigned char ds1307_reader(unsigned char reg_addr){

 unsigned char data_read;
 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(reg_addr);
 I2C1_Repeated_Start();
 I2C1_Wr( 0xD1 );
 data_read = I2C1_Rd(0);
 I2C1_Stop();

 return data_read;
}


void ds1307_writer(unsigned char reg_addr, unsigned char data_write){

 I2C1_Start();
 I2C1_Wr( 0xD0 );
 I2C1_Wr(reg_addr);
 I2C1_Wr(data_write);

 I2C1_Stop();

}

char ds1307_getTime(){
 char time_t[] = "00:00:00";
 second = ds1307_reader( 0x00 );
 minute = ds1307_reader( 0x01 );
 hr = ds1307_reader( 0x02 );
 hour = hr & 0b00011111;

 time_t[0] = d_MSB(hour);
 time_t[1] = d_LSB(hour);
 time_t[3] = d_MSB(minute);
 time_t[4] = d_LSB(minute);
 time_t[6] = d_MSB(second);
 time_t[7] = d_LSB(second);

 return time_t;
}

char ds1307_getDate(){
 char date_t[] = "00/00/00";
 day = ds1307_reader( 0x03 );
 date = ds1307_reader( 0x04 );
 month = ds1307_reader( 0x05 );
 year = ds1307_reader( 0x06 );

 date_t[0] = d_MSB(day);
 date_t[1] = d_LSB(day);
 date_t[3] = d_MSB(month);
 date_t[4] = d_LSB(month);
 date_t[6] = d_MSB(year);
 date_t[7] = d_LSB(year);

 return date_t;
}


unsigned char binaryToBCD(unsigned char binary){
 unsigned char msb, lsb;
 lsb = (binary%10)&0x0F;
 msb = binary - lsb;
 msb /=10;
 msb = msb<<4;
 msb = msb & 0xF0;
 return (msb|lsb);
}

unsigned char bcdToBinary(unsigned char bcd){
 unsigned char msb, lsb;
 lsb = bcd & 0x0F;
 msb = bcd & 0xF0;
 msb = msb >>4;
 msb *=10;
 return(msb+lsb);
}
