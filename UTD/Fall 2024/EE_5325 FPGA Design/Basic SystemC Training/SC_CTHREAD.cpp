//SC_CTHREAD which is the clock thread 
//use FOR Filter for this example

//include the library
#include <systemc.h>

//name the module and declare the ports
SC_MODULE( fir ){
	sc_in< bool >		 clk;
	sc_in< bool >		 rst;
	sc_in< sc_int<16> >  inp;
	sc_out< sc_int<16> > outp;
	
	//define the filter behavior as a function
	void fir_main();		//this will be define in separate module 
	
	SC_CTOR( fir ) {
		SC_CTHREAD( fir_main, clk.pos() );
		reset_signal_is( rst, true );
	}
}



/**************Declaration of the filter coefficients**************************************/
//coefficient for each FIR
const sc_uint<8>	coef[5] = {
	18,
	77,
	107,
	77,
	18
};



/**************Define the FIR Main thread**************************************/
//FIR Main thread
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
		