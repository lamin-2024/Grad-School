//FIR Main thread defination

#include "fir.h"
void fir::fir_main(void)	//using scoping operator :: to associate fir_main to fir also the void shows that fir_main has no arguments
{
	//define a temp register for the filter taps
	sc_int<16>	taps[5];
	
	//implement the reset with a wait() and make outp = 0 at reset 
	outp.write( 0 );
	wait();
	
	while( true ) {
		//use a for loop to loop through the filter taps from 4 down to 0
		for( int i = 4; i > 0; i--)	{
			taps[i] = taps[i-1];
		}
		//take the newest taps (taps = 0) and assign to the inp.read()
		taps[0] = inp.read();
		
		//define another temp register to store the accumulating multiplications
		sc_int<16> val;
		for(int i = 0; i <5; i++)	{
			val += coef[i] * taps[i];	//note the += will add the latest multiply to what ever is stored in val 
		}
		outp.write( val );		//assign the last value of val to the output 'outp'
		wait(); 				//establish a clock boundary 
		