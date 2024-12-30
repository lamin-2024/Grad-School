//This is the fir and Thread declaration module

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