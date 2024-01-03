
//to avoid same code copied more than once when used in multipe places
#ifndef DS1307_I2C_DRIVER_H
#define DS1307_I2C_DRIVER_H



//DS1307 register defines
#define ds1307_write 0xD0
#define ds1307_read 0xD1
#define ds1307_sec 0x00
#define ds1307_min 0x01
#define ds1307_hour 0x02
#define ds1307_day 0x03
#define ds1307_date 0x04
#define ds1307_month 0x05
#define ds1307_year 0x06





//Inintialization
unsigned char ds1307_init();

//Data acquisition
unsigned char d_MSB(unsigned char value);
unsigned char d_LSB(unsigned char value);
unsigned char ds1307_reader(unsigned char reg_addr);
void ds1307_writer(unsigned char reg_addr, unsigned char data_write);
char ds1307_getTime();
char ds1307_getDate();
unsigned char bcdToBinary(unsigned char bcd);
unsigned char binaryToBCD(unsigned char binary);

#endif