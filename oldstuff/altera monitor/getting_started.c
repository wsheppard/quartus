/* This program demonstrates use of parallel ports in the DE0 Basic Computer
 *
 * It performs the following: 
 * 	1. displays the SW switch values on the green LEDG
 * 	2. displays a rotating pattern on the HEX displays
 * 	3. if KEY[2..1] is pressed, uses the SW switches as the pattern
*/
int main(void)
{
	/* Declare volatile pointers to I/O registers (volatile means that IO load
	 * and store instructions will be used to access these pointer locations, 
	 * instead of regular memory loads and stores)
	*/
	volatile int * green_LED_ptr	= (int *) 0x10000010;	// green LED address
	volatile int * HEX3_HEX0_ptr	= (int *) 0x10000020;	// HEX3_HEX0 address
	volatile int * SW_switch_ptr	= (int *) 0x10000040;	// SW slider switch address
	volatile int * KEY_ptr			= (int *) 0x10000050;	// pushbutton KEY address

	int HEX_bits = 0x0000000F;					// pattern for HEX displays
	int SW_value, KEY_value;
	volatile int delay_count;					// volatile so the C compiler doesn't remove the loop

	while(1)
	{
		SW_value = *(SW_switch_ptr);		 	// read the SW slider switch values
		*(green_LED_ptr) = SW_value; 			// light up the green LEDs

		KEY_value = *(KEY_ptr); 				// read the pushbutton KEY values
		if (KEY_value != 0)						// check if any KEY was pressed
		{
			HEX_bits = SW_value;					// set pattern using SW values
			while (*KEY_ptr);						// wait for pushbutton KEY release
		}
		*(HEX3_HEX0_ptr) = HEX_bits;			// display pattern on HEX3 ... HEX0

		/* rotate the pattern shown on the HEX displays */
		if (HEX_bits & 0x80000000)
			HEX_bits = (HEX_bits << 1) | 1;
		else
			HEX_bits = HEX_bits << 1;

		for (delay_count = 100000; delay_count != 0; --delay_count); // delay loop
	}
}
