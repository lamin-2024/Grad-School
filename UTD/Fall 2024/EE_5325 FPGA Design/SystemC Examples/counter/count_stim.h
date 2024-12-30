//Example: stimulus Generator (.h)

//count_stim.h
#include "systemc.h"
//name the module and ports
SC_MODULE( count_stim )	{
	sc_out< bool >	load;
	sc_out< int >	din;		//input port
	sc_in< bool >	clock;		//input port
	sc_in< int >	dout;		//output port
	
	//define a member function
	void stimgen();
	
	//define the constructor
	SC_CTOR( count_stim )	{
		SC_THREAD( stimgen );	//method process
		sensitive_pos << clock;
	}
};