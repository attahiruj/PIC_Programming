#line 1 "C:/Users/Attahiru Jibril/Documents/Design/Electronics_Circuits-Embedded_System/mikroC/PIC_Grind/Led_Blink/Led_Blink_Code/Led_Blink.c"
#line 4 "C:/Users/Attahiru Jibril/Documents/Design/Electronics_Circuits-Embedded_System/mikroC/PIC_Grind/Led_Blink/Led_Blink_Code/Led_Blink.c"
void main() {
 TRISC5_bit = 0;
 TRISC2_bit = 0;
 ANSELC = 0;
 while(1){
 LATC.B5 = 0;
 LATC.B2 = 0;
 Delay_ms(500);
 LATC.B5 = 1;
 LATC.B2 = 1;
 Delay_ms(500);
 }
}
