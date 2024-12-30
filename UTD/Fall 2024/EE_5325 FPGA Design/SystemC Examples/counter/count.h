//count.h 
#include "systemc.h"

//name the module and ports
SC_MODULE( count )	{
	sc_in< bool >	load;
	sc_in< int >	din;		//input port
	sc_in< bool >	clock;		//input port
	sc_out< int >	dout;		//output port
	
	int	count_val;				//internal data sotrage
	
	//define a member function
	void count_up();
	
	//define the constructor
	SC_CTOR( count )	{
		SC_METHOD( count_up );	//method process
		sensitive_pos << clock;
	}
};