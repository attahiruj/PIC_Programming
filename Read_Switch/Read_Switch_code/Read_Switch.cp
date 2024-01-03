#line 1 "C:/Users/Attahiru Jibril/Documents/Design/Electronics_Circuits-Embedded_System/mikroC/PIC_Grind/Read_Switch/Read_Switch_code/Read_Switch.c"
void main() {
 ADCON1= 0x0F;
 TRISB0_bit = 0;
 TRISC0_bit = 1;

 while(1){
 if(PORTC.RC0 == 0){
 Delay_ms(1);
 if(PORTC.RC0 == 0){
 LATB.B0 = 1;
 }
 }
 else{
 LATB.B0 = 0;
 }
 }

}
