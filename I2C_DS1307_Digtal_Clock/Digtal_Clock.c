/*
Title: I2C communication, Digital clock with DS1307
Written by: Attahiru Jibril
Written on: 05/25/2023
IDE: MikroC Pro
MCU: PIC18F45k22
FOC: internal 8MHz
MCLR pin: enabled
*/

#include "ds1307.h"

#define setBtn PORTA.F0
#define upBtn PORTA.F1
#define downBtn PORTA.F2

unsigned char set_hour;
unsigned char set_minute;
unsigned char set_second;
unsigned char set_day;
unsigned char set_month;
unsigned char set_year;

unsigned short set_position;
short set;

// Lcd pinout settings
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D4 at RB0_bit;

// Pin direction
sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D7_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB0_bit;


void boot(){
    OSCCON = 0x66;
    ANSELD = 0;
    TRISD = 1;
    ANSELC = 0;
    
//UART init
    UART1_Init(9600);
    delay_ms(200);
    UART1_Write_Text("UART Init\r\n");
    delay_ms(200);
    
// LCD init
    ANSELB = 0;
    Lcd_Init();
    Lcd_Cmd(_LCD_CLEAR);
    Lcd_Cmd(_LCD_CURSOR_OFF);
    UART1_Write_Text("LCD init \r\n");
    Lcd_Out(1, 1,"Digital Clock");
    delay_ms(200);
    Lcd_Cmd(_LCD_CLEAR);
    Lcd_Out(1,1, "Time: ");
    Lcd_Out(2,1, "Date: ");

//rtc init

    if(ds1307_init() == 1){
        UART1_Write_Text("ds1307 init \r\n");
    }else UART1_Write_Text("ds1307 init failed\r\n");
    delay_ms(200);
    
//Button Init
    ANSELA = 0;                    //disable  analog on port A
    TRISD = 0x07;                  //set  RA1, RA2 and RA3 as input
    PORTA = 0x00;                  //initialise port A to 0
    
    UART1_Write_Text("Boot OK\r\n");

}


void main() {

     boot();

     while (1){
         // navigate HH:MM:SS DD/MM/YY to set time
         set = 0;
         if(!setBtn){
             delay_ms(10);
             if(!setBtn){
                 set_position++; UART1_Write_Text("setBtn pressed\r\n");
                 if(set_position >= 7){
                     set_position = 0;
                 }
             }
         }
         
         if(set_position){
             //increment set if up btn is pressed
             if(!upBtn){
                 delay_ms(10);
                 if(!upBtn){
                     set = 1;
                 }
             }
             //decrement set if down btn is pressed
             if(!downBtn){
                 delay_ms(10);
                 if(!downBtn){
                     set = -1;
                 }
             }
         }
         
         if(set_position && set){
             switch(set_position){
                 case 1:
                     set_hour = ds1307_reader(ds1307_hour);
                     set_hour = bcdToBinary(set_hour);
                     set_hour = set_hour + set;
                     set_hour = binaryToBcd(set_hour);
                     if((set_hour & 0x1F) >= 0x13){
                         set_hour = set_hour & 0b11100001;
                         set_hour = set_hour ^ 0x20;
                     }
                     else if((set_hour & 0x1F) <= 0x00){
                         set_hour = set_hour | 0b00010010;
                         set_hour = set_hour ^ 0x20;
                     }
                     ds1307_writer(ds1307_hour, set_hour);
                     break;

                 case 2:
                     set_minute = ds1307_reader(ds1307_min);
                     set_minute = bcdToBinary(set_minute);
                     set_minute = set_minute + set;
                     if(set_minute >= 60) set_minute = 0;
                     if(set_minute <= 0) set_minute = 59;
                     set_minute = binaryToBcd(set_minute);
                     ds1307_writer(ds1307_min, set_minute);
                     break;

                 case 3:
                     if(set){
                         ds1307_writer(ds1307_sec, 0x00);
                     }
                     break;

                 case 4:
                     set_day = ds1307_reader(ds1307_day);
                     set_day = bcdToBinary(set_day);
                     set_day = set_day + set;
                     set_day = binaryToBcd(set_day);
                     if(set_day >= 0x32){
                         set_day = 1;
                     }
                     if(set_day <= 0x00){
                         set_day = 0x31;
                     }
                     ds1307_writer(ds1307_day, set_day);
                     break;
                 
                 case 5:
                     set_month = ds1307_reader(ds1307_month);
                     set_month = bcdToBinary(set_month);
                     set_month = set_month + set;
                     set_month = binaryToBcd(set_month);
                     if(set_month >= 0x12){
                         set_month = 1;
                     }
                     if(set_month <= 0x00){
                         set_month = 0x12;
                     }
                     ds1307_writer(ds1307_month, set_month);
                     break;
                     
                 case 6:
                     set_year = ds1307_reader(ds1307_day);
                     set_year = bcdToBinary(set_year);
                     set_year = set_day + set;
                     set_year = binaryToBcd(set_year);
                     if(set_year >= 0x50){
                         set_year = 0x00;
                     }
                     if(set_year <= -1){
                         set_year = 0x99;
                     }
                     ds1307_writer(ds1307_year, set_year);
                     break;
             }
         }
         
         Lcd_Out(1,7, ds1307_getTime());
         Lcd_Out(2,7, ds1307_getDate());

         delay_ms(100);
     }
}