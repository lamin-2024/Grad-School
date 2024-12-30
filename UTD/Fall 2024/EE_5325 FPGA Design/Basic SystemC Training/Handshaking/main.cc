//main.cc file for the system
include < systemc.h >
include " fir.h "
include " tb.h "

SC_MODULE( SYSTEM )	{
	//declare the lower level modules fir0 and tb0
	tb			*tb0;
	fir			*fir0;
	
	//define the port names as signals for the SYSTEM
	sc_signal< sc_int<16> >		inp_sig;
	// a valid input signal to let the fir0 module knows that it is recieving a valid signal from tb0
	// a input ready signal to let the tb0 know that fir0 is ready to received and process the next signals 
	sc_signal< bool >			inp_sig_vld;
	sc_signal< bool >			inp_sig_rdy;
	
	// a valid output signal to let the tb0 module knows that it is recieving a valid signal from fir0
	// a output ready signal to let the fir00 know that tb0 is ready to receive the next signal  
	sc_signal< sc_int<16> >		outp_sig;
	sc_signal< bool >			outp_sig_vld;
	sc_signal< bool >			outp_sig_rdy;
	
	sc_signal< bool >			rst_sig;
	
	sc_clock	clk_sig;
	
	//tie the lower modules together in the constructor
	SC_CTOR( SYSTEM )
		: clk_sig ( "clk_sig", 10, SC_NS )		//define the clk signal as 10ns period
		{
			tb = new tb( "tb0" );				//use the new operator to allocate memory space for the tb 
			tb0 -> clk( clk_sig );				//tie the clk from tb0 to the clk_sig in SYSTEM 
			tb0 -> rst( rst_sig );
			tb0 -> inp( inp_sig );
			tb0 -> outp( outp_sig );
			//tie the new inputs and outputs (vld and rdy) to the lower modules 
			tb0 -> inp_vld( inp_sig_vld );
			tb0 -> inp_rdy( inp_sig_rdy );
			tb0 -> outp_vld( outp_sig_vld );
			tb0 -> outp_rdy( outp_sig_rdy );
			
			
			
			fir0 = new fir( "fir0" );
			fir0 -> clk( clk_sig );				//tie the clk from fir0 to the clk_sig in SYSTEM 
			fir0 -> rst( rst_sig );
			fir0 -> inp( inp_sig );
			fir0 -> outp( outp_sig );
			//tie the new inputs and outputs (vld and rdy) to the lower modules 
			fir0 -> inp_vld( inp_sig_vld );
			fir0 -> inp_rdy( inp_sig_rdy );
			fir0 -> outp_vld( outp_sig_vld );
			fir0 -> outp_rdy( outp_sig_rdy );
		}
		
	//define the destructor to free up space in memory after the test is completed
	~SYSTEM()	{
	delete tb0;
	delete fir0;
	}
};
	
//for the system module instantiation 
SYSTEM	*top = NULL;			//make sure SYSTEM points to top which is a null so it does not point to unknown part of memory 

int sc_main( int argc, char* argv[] )        //main function for systemC
{
	top = new SYSTEM( "top" );
	sc_start();
	return 0;
}