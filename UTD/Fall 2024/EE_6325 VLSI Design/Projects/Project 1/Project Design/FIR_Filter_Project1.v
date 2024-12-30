/*--------------------------------------------------------------------------
Name:		Lamin Jammeh	
CLass:	CE6325 Fall_2024 
Project:	1
Project Description: this is a Finite Impulse Response (FIR) filter design using Verilog HDL
The design follows the concepts below
**The filter order is selected and parameterized so the design can be scaled in the fututre
**The filter cooefficents are pre-determined
**Data_in samples will be provided in the testbench to determine the filter behavior 
**The Data_in sample is Multiplied and accumalated through the diffrent filter stages/taps
**The Data_out word_size = word_in + coeff_size + [log2[N]]  where N= # of taps in the filter
 
----------------------------------------------------------------------------*/
module FIR_Filter_Project1	#(parameter order = 5,										//filter order [pre-determined]
									  parameter word_size_in = 4,								//size of data_in [pre-determined]
									  parameter word_size_out = 16)	//word_size = word_in + coeff_size + [log2[N]] N=4, & coeff=word_in
							  
									//declare inputs and outputs
									(
									output	[word_size_out - 1:0]	Data_out,
									input		[word_size_in - 1:0]		Data_in,
									input										clock, reset
									);
									
reg		[word_size_in -1:0]		Samples[order-1:0];		//temp storage for input samples (x(n))
reg		[word_size_out -1:0]	acc;					//temp storage for output data
integer	k;

//Filter Coefficients
parameter b0 = 4'd7;
parameter b1 = 4'd8;
parameter b2 = 4'd9;
parameter b3 = 4'd12;
parameter b4 = 4'd4;

//define the formula for the output
assign 	Data_out = acc;

always @(posedge clock)
 begin
	if (reset == 1)						
	//when reset is high and clock is rising samples[k] = 0 regardless of k value
		begin
			for (k = 0;	k < order;	k = k+1)
			begin
				Samples[k] <= 0;
				acc	     <= 0;
			end
		end
		else 
		//when reset is low and clock is rising compute Samples with data_in to get Data_out
			begin
				Samples[0] <= Data_in;						//@ k=0 Samples[0] <= Data_in
				for (k = 1; k < order;	k = k + 1)			// from k=1 to k=order Samples[k] <=Samples[k-1]
				begin
					Samples[k] <= Samples[k - 1];				//Data_in will go throught all the filter coefficeints 
					acc <=   b0*Data_in 
						  + b1*Samples[0] 
						  + b2*Samples[1] 
				        + b3*Samples[2] 
				        + b4*Samples[3];
				end
			end
 end
endmodule