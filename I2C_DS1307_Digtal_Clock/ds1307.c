
#include "ds1307.h"

//global variable
int second;
int minute;
int hour;
int hr;
int day;
int date;
int month;
int year;




unsigned char ds1307_init(){
    I2C1_Init(100000);                    //initialize i2c at 100khz
    I2C1_Start();                         //start i2c
    I2C1_Wr(ds1307_write);                //DS1307 module address when in write mode
    I2C1_Stop();                          //stop i2c
    return 1;
}

unsigned char d_MSB(unsigned char value){
    return ((value >> 4) +'0');           //shift MSB to right 4bit, + '0' is used to convert digit to a character
}

unsigned char d_LSB(unsigned char value){
    return ((value & 0x0F) +'0');
}

// funtion to read DS1307 registers for time info
unsigned char ds1307_reader(unsigned char reg_addr){

    unsigned char data_read;
    I2C1_Start();                         //start i2c
    I2C1_Wr(ds1307_write);                //DS1307 module address when in write mode
    I2C1_Wr(reg_addr);                    //write the name of address you want to read from
    I2C1_Repeated_Start();                //restart i2c
    I2C1_Wr(ds1307_read);                 //DS1307 module address when in read mode
    data_read = I2C1_Rd(0);               //read date of register and dont acknowledge - 0
    I2C1_Stop();

    return data_read;
}

// funtion to write to DS1307 registers time info
void ds1307_writer(unsigned char reg_addr, unsigned char data_write){

    I2C1_Start();                         //start i2c
    I2C1_Wr(ds1307_write);                //DS1307 module address when in write mode
    I2C1_Wr(reg_addr);                    //write the name of address you want to read from
    I2C1_Wr(data_write);                 //DS1307 module address when in read mode

    I2C1_Stop();

}

char ds1307_getTime(){
     char time_t[] = "00:00:00";
     second = ds1307_reader(ds1307_sec);
     minute = ds1307_reader(ds1307_min);
     hr = ds1307_reader(ds1307_hour);
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
     day = ds1307_reader(ds1307_day);
     date = ds1307_reader(ds1307_date);
     month = ds1307_reader(ds1307_month);
     year = ds1307_reader(ds1307_year);

     date_t[0] = d_MSB(day);
     date_t[1] = d_LSB(day);
     date_t[3] = d_MSB(month);
     date_t[4] = d_LSB(month);
     date_t[6] = d_MSB(year);
     date_t[7] = d_LSB(year);
     
     return date_t;
}

// Function to convert binary to BCD
unsigned char binaryToBCD(unsigned char binary){
    unsigned char msb, lsb;
    lsb = (binary%10)&0x0F;
    msb = binary - lsb;
    msb /=10;
    msb = msb<<4;
    msb = msb & 0xF0;
    return (msb|lsb);
}
// Function to convert BCD to binary
unsigned char bcdToBinary(unsigned char bcd){
    unsigned char msb, lsb;
    lsb = bcd & 0x0F;
    msb = bcd & 0xF0;
    msb = msb >>4;
    msb *=10;
    return(msb+lsb);
}