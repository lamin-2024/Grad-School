//introduction using and2

//step 1 include the library files
#include <systemc.h>

//name the module
SC_MODULE( and2 ) {
	
	//Step 2 define the ports with data type DT = sc_uint<1> means 1 bit unsigned integer
	sc_in	< sc_uint<1> >	a;
	sc_in	< sc_uint<1> >	b;
	sc_out	< sc_uint<1> >	f;
	sc_in	<bool>  clk;	//this will make the design sequential 
	
	/*
	Port I/O in systemC
	SysytemC uses functions to read from sc_in<> or write to sc_out<>
		.read()
		.write()
	Examples
		x = inp.read();
		outp.write(val);
	*/
	
	//Step3 add member func to perform the adding operations using the Port I/O concept in systemC
	//(this define how the inputs intract to form the output)
	void func(){
		f.write( a.read()	&	b.read() ); // this means f = a&b therefore [a, b] reads inputs and f writes the result
	}		// note void means the func does not return any value 
		
		
	//Step4 define the SystemC constructor (SC_CTOR) this is where the threads are defined
	/* A thread is a function made to act like a hardware process
			Run concurently
			sensitive to signals, clock edges or fixed amounts of simulation time
			Not called by the user, always active
	  SystemC supports three kinds of threads
			SC_METHOD()
				Executes once every sensitivity event
				Runs continuosly
				Analogous to a verilog @always block
				Synthesizable
					Useful for combinational expressions or simple sequential logic 
			SC_THREAD()
				Runs once at start of simulation, then suspends itself when done
				can contain an infinite loop to execute code at a fixed rate of time
				Similar to a verilog @initial block 
				NOT Synthesizable
					Useful in testbenches to describe clocks or initial startup signal sequences
			SC_CTHREAD()
				Means 'clocked thread'
				Runs continuosly
				References a clock edge
				Synthesizable
				Can take one or more clock cycles to execute a single iteration
				Used in 99% of all high-level behavioral designs
			
	*/
	SC_CTOR( and2 )	{
		SC_METHOD(func);
		//sensitive << a	<< b; 
		sensitive <<clk.neg();		//since we add a clk signal the thread or SC_METHOD now changes with the clck edge instead of input 'a 'or 'b' 
		
	}
}