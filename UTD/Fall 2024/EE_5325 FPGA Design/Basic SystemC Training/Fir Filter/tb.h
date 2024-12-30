//Testbench hehader file
//tb.h
#include < systemc.h >
SC_MODULE( tb )
{
	sc_in< bool >		 clk;
	sc_out< bool >		 rst;
	sc_out< sc_int<16> >  inp;
	sc_in< sc_int<16> > outp;
	
	//declare the member functions
	void source();			//for rst and input inp values
	void sink();			//reads the values coming from the fir to the output outp
	
	//declare the thread for each member functions
	SC_CTOR( tb )	{
		SC_CTHREAD( source, clk.pos() );
		SC_CTHREAD( sink, clk.pos() );
	}
}