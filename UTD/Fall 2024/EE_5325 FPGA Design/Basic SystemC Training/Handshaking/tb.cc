//Testbench .cc file
//tb.cc

#include " tb.h"

//define the source thread
void tb::source()	{
	//initial the output of the tb or inut of the fir using Reset
	inp.write( 0);
	inp_vld.write( 0 );		//reset teh input valid signal
	rst.write( 1 );
	wait();					//wait for a complete clk cylce
	rst.write( 0 );
	wait();					//wait for another complete clk cycle
	
	//create a tmp register to store test stimulus
	sc_int< 16 > tmp;
	//send teh stimulus to FIR
	for( int i = 0; i < 64; i++ 0
	{
		if( i>23 && i < 29 )
			tmp = 256;
		else
			tmp = 0;
		inp_vld.write( 1 );		//assert inout valid 
		inp.write( tmp );
		//perform a do while and wait for the inp_rdy to be asserted before changing inp_vld to zero
		do {
			wait();
		} while ( !inp_rdy.read() );
		inp_vld.write( 0 );
		wait();
	}
}

//define the sink thread to read what is coming back from the FIR 
void tb::sink() {
	//create a temporary register to store values coming from FIR
	sc_int< 16 > indata;
	
	//Initialize port
	outp_rdy.write( 0 );
	//Read output coming from DUT
	for( int i = 0; i < 64; i++ )
	{
		outp_rdy.write( 1 );
		do {
			wait();
		} white ( !outp_vld.read() );	
		indata = outp.read();
		//wait();
		outp_rdy.write ( 0 );
		cout << i << " :/t" << indata.to_int() << endl;		//print current i of indata to an integer and end line
	}
}
//once the last value is read END simulation
sc_stop();