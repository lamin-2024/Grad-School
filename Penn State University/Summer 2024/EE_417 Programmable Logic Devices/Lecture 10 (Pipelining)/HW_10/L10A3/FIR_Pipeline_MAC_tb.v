/*----------------------------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 10 HW Question 3
Group: Ron Kalin/ Lamin Jammeh
Project Description: testbench
-----------------------------------------------------------------------------------------------------*/

module FIR_Pipeline_MAC_tb ();

//define the parameter sets for the design 
parameter FIR_order			= 4;
parameter Sample_size		= 6;						//maximum sample value is 63
parameter weight_size		= 5;						//maximum value may be 31
parameter word_size_out		= 2 * Sample_size + 2;		//maximum possible output 63*31*(4+1)
parameter product_size		= Sample_size + weight_size;

//define the wires and registers for the test bench
wire	[word_size_out -1:0]	FIR_out_pipeline;

reg		[Sample_size -1:0]		Sample_in;
reg								clock, reset;

//define the unit under test UUT
FIR_Pipeline_MAC	UUT	(FIR_out_pipeline, Sample_in, clock, reset);

//instantiate the clock signal
initial	
	begin
		clock = 0;
		forever		#5 clock = ~clock;
	end 
	
//instantiate and toggle the reset signal
initial
	begin
		reset = 1; 
		#40 reset = 0;
	end 
	
//aplly different input Sample and observe the outputs
initial
	begin
		Sample_in = 0;
		#100	Sample_in = 1;			//impulse response
		#10	Sample_in = 0;
		#100	Sample_in = 10;		//same input over 5 clock cycles
		#50	Sample_in = 0;
		#100	Sample_in = 1;
		#10	Sample_in = 2;
		#10	Sample_in = 8;
		#10	Sample_in = 2;
		#10	Sample_in = 1;
		#10	Sample_in = 0;
		#100	Sample_in = 63;
		#100	Sample_in = 0;
		
		#100;
		$stop;
	end 
endmodule