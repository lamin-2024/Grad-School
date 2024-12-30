//Testbench .cc file
//tb.cc

#include " tb.h"

//define the source thread
void tb::source()	{
	//initial the output of the tb or inut of the fir using Reset
	inp.write( 0);
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
		inp.write( tmp );
		wait();
	}
}

//define the sink thread to read what is coming back from the FIR 
void tb::sink() {
	//create a temporary register to store values coming from FIR
	sc_int< 16 > indata;
	//Read outpuut coming from DUT
	for( int i = 0; i < 64; i++ )
	{
		indata = outp.read();
		wait();
		cout << i << " :/t" << indata.to_int() << endl;		//print current i of indata to an integer and end line
	}
}
//once the last value is read END simulation
sc_stop();