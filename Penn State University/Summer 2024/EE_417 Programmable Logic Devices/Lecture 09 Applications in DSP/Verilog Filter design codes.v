//Eight-order, Gausssian Lowpass FIR (Finite duration Impulse Response)

module FIR_Gaussian_Lowpass	#(parameter order = 8,
							  parameter word_size_in = 8;
							  parameter word_size_out = 2 * word_size_in + 2
							  
							  //Filter Coefficients
							  parameter b0 = 8'd7,
							  parameter b1 = 8'd17,
							  parameter b2 = 8'd32,
							  parameter b3 = 8'd46,
							  parameter b4 = 8'd52,
							  parameter b5 = 8'd46,
							  parameter b6 = 8'd32,
							  parameter b7 = 8'd17,
							  parameter b8 = 8'd17)
							  
							  //inputs and outputs
							 (
							  output	[word_size_out - 1:0]	Data_out,
							  input		[word_size_in - 1:0]	Data_in,
							  input								clock, reset
							  );
reg		[word_size_in -1:0]		Samples[1:order];		//temp storage for input samples (x(n))
integer							k;

//define the formula for the output
assign 	Data_out =  b0*Data_in 
                  + b1*Samples[1] 
				  + b2*Samples[2] 
				  + b3*Samples[3] 
				  + b4*Samples[4]
				  + b5*Samples[5] 
				  + b6*Samples[6] 
				  + b7*Samples[7] 
				  + b8*Samples[8];

always @(posedge clock)
	if (reset == 1)						
	//when reset is high and clock is rising samples[k] = 0 regardless of k value
		begin
			for (k = 1;	k <= order;	k = k+1)
			Samples[k] <= 0;
		end
		else 
		//when reset is low and clock is rising compute Samples with data_in to get Data_out
			begin
				Samples[1] <= Data_in;						//@ k=1 Samples[1] <= Data_in
				for (k = 2; k <= order;	k = k + 1)			// from k=2 to k=order Samples[k] <=Samples[k-1]
					Samples[k] <= Samples[k - 1];
			end
endmodule


//---------------------------------------------------------------------------------------------------------------------------//
//Eight-order IIR (Infinite duration Impulse Response) filter

module IIR_Filter_8 #(parameter order = 8,
					  parameter word_size_in = 8;
					  parameter word_size_out = 2 * word_size_in + 2
							  
					//Feedforward Filter Coefficients
					  parameter b0 = 8'd7,
					  parameter b1 = 8'd0,
					  parameter b2 = 8'd0,
					  parameter b3 = 8'd0,
					  parameter b4 = 8'd0,
					  parameter b5 = 8'd0,
					  parameter b6 = 8'd0,
					  parameter b7 = 8'd0,
					  parameter b8 = 8'd0,
					  
					//Feedback Filter Coefficients
					  parameter a1 = 8'd46,
					  parameter a2 = 8'd32,
					  parameter a3 = 8'd17,
					  parameter a4 = 8'd0,
					  parameter a5 = 8'd17,
					  parameter a6 = 8'd32,
					  parameter a7 = 8'd46,
					  parameter a8 = 8'd52)
							  
							  //inputs and outputs
							 (
							  output	[word_size_out - 1:0]	Data_out,
							  input		[word_size_in - 1:0]	Data_in,
							  input								clock, reset
							  );
							  
//internal registers and wires
reg		[word_size_in -1:0]		Samples_in [1:order];
reg		[word_size_in -1:0]		Samples_out[1:order];
wire	[word_size_out -1:0]	Data_feedforward;
wire	[word_size_out -1:0]	Data_feedback;
integer							k;
//define a formular for the Data_feedforward
assign  Data_feedforward =	b0*Data_in 
						  + b1*Samples_in[1] 
						  + b2*Samples_in[2] 
						  + b3*Samples_in[3] 
						  + b4*Samples_in[4]
				          + b5*Samples_in[5] 
						  + b6*Samples_in[6] 
						  + b7*Samples_in[7] 
						  + b8*Samples_in[8]; 
						  
//define a formular for the Data_feedback
assign  Data_feedback =    a1*Samples_out[1] 
						  + a2*Samples_out[2] 
						  + a3*Samples_out[3] 
						  + a4*Samples_out[4]
				          + a5*Samples_out[5] 
						  + a6*Samples_out[6] 
						  + a7*Samples_out[7] 
						  + a8*Samples_out[8]; 
						  
//define a formula for Data_out
assign	Data_out = Data_feedforward + Data_feedback;

always @ (posedge clock)
	if (reset == 1)
	//when reset is high and clock is rising Samples_in[k] and Samples_out[k]= 0 regardless of k value
		for (k = 1;	k<= order; k = k+1)
			begin
				Samples_in[k] <= 0;
				Samples_out[k] <= 0;
			end
			
	else 
	//when reset is low and clock is rising compute Samples_in and Samples_out with data_in and  Data_out
		begin
			//define Samples_in and Samples_out @ k=1
			Samples_in[1] <= Data_in;			
			Samples_out[1] <= Data_out;			
			for (k = 2; k <= order; k+1)
				begin
					//define Samples_in and Samples_out from k=1 to k=order
					Samples_in[k] <= Samples_in[k-1];
					Samples_out[k]<= Samples_out[k-1];
				end
		end	
endmodule		



/*-------------------------------Building Blocks for signal Processor----------------------------------------
The Three Building Blocks are
Integrators
Differentiators
Decimators
Interpolators
-------------------------------------------------------------------------------------------------------------*/

//-------------------Parallel Integrator----------------------------------------------------------------------

module Integrator_Par	#(parameter word_length = 8)
						 (
						  output reg	[word_length -1:0]	Data_out,
						  input			[word_length -1:0]	Data_in,
						  input								hold, clock, reset
						  );
						  
always @ (posedge clock)
	begin
		if (reset) 
			data_out <= 0;			           //when reset is high, and clock is rising data_out <=0
		else if (hold)
			data_out <= data_out;             //when hold is high, reset is low, and  clock is rising data_out <= data_out 
		else
			data_out <= data_out + data_in;	  //when hold is low, reset is low, and  clock is rising data_out <= data_out + data_in 
	end
endmodule



//-------------------Sequential Integrator----------------------------------------------------------------------

module Integrator_Seq	#(parameter word_length = 8, latency = 4)
						 (
						  output reg	[word_length -1:0]	Data_out,
						  input			[word_length -1:0]	Data_in,
						  input								hold, LSB_flag, clock, reset
						  );

//internal registers and wires
reg			[(word_length*latency) -1:0]	Shft_Reg;
reg											carry;
wire		[word_length:0]					sum;
						  
always @ (posedge clock)
	begin
		if (reset) 
			begin 
			//when reset is high, and clock is rising Shft_Reg <=0 and carry <=0
				Shft_Reg <= 0;			           
				carry	 <= 0;
			end
		else if (hold)
			begin
			//when hold is high, reset is low, and  clock is rising Shft_Reg <=Shft_Reg and carry <=carry
				Shft_Reg <= Shft_Reg;			           
				carry	 <= carry;
			end
		else
			begin
			//when hold is low, reset is low, and  clock is rising use the formula below to get Shft_Reg and carry 
				Shft_Reg <= {Shft_Reg[(word_length*(latency-1) -1:0], sum[word_length -1:0]};			           
				carry	 <= sum[word_length];
			end 
	end
	
//assign a formula for sum and data_out 
assign	sum = data_in + Shft_Reg[(latency*word_length) -1: (latency-1)*word_length] + (carry & (~LSB_flag));
assign  data_out = Shft_Reg[(latency*word_length) -1: (latency -1)*word_length];
endmodule



//-------------------Differentiator----------------------------------------------------------------------


module Differentiator #(parameter word_size = 8) (
    output [word_size-1:0] Data_out,
    output [word_size-1:0] buffer, // expose buffer as an output
    input  [word_size-1:0] Data_in,
    input                  hold, clock, reset
);

// internal registers and wires
reg [word_size-1:0] buffer_reg; // internal register for buffer

// assign a formula for Data_out
assign Data_out = Data_in - buffer_reg; // Data_out will be the difference between Data_in and buffer
assign buffer = buffer_reg; // expose the internal buffer

always @ (posedge clock) begin
    if (reset) 
        buffer_reg <= 0; // when reset is high, and clock is rising buffer <=0
    else if (hold)
        buffer_reg <= buffer_reg; // when hold is high, reset is low, and clock is rising buffer <= buffer 
    else
        buffer_reg <= Data_in; // when hold is low, reset is low, and clock is rising buffer <= data_in 
end

endmodule



//-------------------Decimators----------------------------------------------------------------------

//-------------Parallel-in-Parallel-out Decimator----------------------------------------------------
module Decimator_1	#(parameter word_length = 8)
						 (
						  output reg	[word_length -1:0]	Data_out,
						  input			[word_length -1:0]	Data_in,
						  input								hold,			//Active high
						  input 							clock,			//Positive edge
						  input 							reset			//Active high
						  );

always @ (posedge clock)
		if (reset) 
			data_out <= 0;			           //when reset is high, and clock is rising data_out <=0
		else if (hold)
			data_out <= data_out;             //when hold is high, reset is low, and  clock is rising data_out <= data_out 
		else
			data_out <= data_in;	  //when hold is low, reset is low, and  clock is rising data_out <= data_in 
endmodule


/*-----------------------Decimator_2----------------------------------------------------
Samples a Parallel input and produces a Parallel output
but also has an option to form a serial output by shifting the output word through the LSB
while the hold is asserted
----------------------------------------------------------------------------------------*/
module Decimator_2	#(parameter word_length = 8)
						 (
						  output reg	[word_length -1:0]	Data_out,
						  input			[word_length -1:0]	Data_in,
						  input								hold,			//Active high
						  input 							clock,			//Positive edge
						  input 							reset			//Active high
						  );

always @ (posedge clock)
		if (reset) 
			data_out <= 0;			           //when reset is high, and clock is rising data_out <=0
		else if (hold)
			data_out <= data_out >> 1;             //when hold is high, reset is low, and  clock is rising data_out <= data_out shifted to the right 
		else
			data_out <= data_in;	  //when hold is low, reset is low, and  clock is rising data_out <= data_in 
endmodule




module Decimator_3   	#(parameter word_length = 8, latency = 4)
						 (
						  output    	[(word_length*latency) -1:0]	Data_out,
						  input			[word_length -1:0]				Data_in,
						  input								            load, hold, clock, reset
						  );

//internal registers and wires
reg			[(word_length*latency) -1:0]	Shft_Reg;			//Shift register
reg			[(word_length*latency) -1:0]	Int_Reg;			//Intermediate register
reg			[(word_length*latency) -1:0]	Decim_Reg;			//Decimation register 
						  
always @ (posedge clock)						//Decimation
		if (reset) 
			begin 
			//when reset is high, and clock is rising Shft_Reg <=0 and Int_Reg <=0
				Shft_Reg <= 0;			           
				Int_Reg	 <= 0;
			end
		else 
		begin if (!lold)
				begin
				//when lold is high, reset is low, and  clock is rising use the formula below
					Shft_Reg <= {Data_in, Shft_Reg[(word_length*latency) -1:word_length]};			           
				end
			else
				begin
				//when lold is low, reset is low, and  clock is rising use the formula below to get Shft_Reg and Int_Reg 
					Shft_Reg[(word_length*latency) -1:(word_length*(latency-1))] <= Data_in;			           
					Int_Reg <= Shft_Reg;
				end 
	    end
	
always @ (posedge clock)				//Byte buffering
	if (reset)
		Decim_Reg <= 0;
	else if (!load)
		Decim_Reg <= Int_Reg;
		
//assign a formula for Data_out
assign  Data_out <= Decim_Reg;
endmodule



//-------------------Interpolators----------------------------------------------------------------------

module LinearInterpolator (
    input wire clk,
    input wire reset,
    input wire [15:0] input_sample,
    output wire [15:0] output_sample
);
    reg [15:0] buffer;

    always @(posedge clk or posedge reset) begin
        if (reset)
            buffer <= 16'h0;
        else
            buffer <= (input_sample + buffer) >> 1;
    end

    assign output_sample = buffer;
endmodule










module Differentiator #(parameter word_size = 8) (
    output [word_size-1:0] Data_out,
    input  [word_size-1:0] Data_in,
    input                  hold, clock, reset
);

// internal registers and wires
reg [word_size-1:0] buffer; // internal register for buffer

// assign a formula for Data_out
assign Data_out = Data_in - buffer_reg; // Data_out will be the difference between Data_in and buffer

always @ (posedge clock) begin
    if (reset) 
        buffer <= 0; // when reset is high, and clock is rising buffer <=0
    else if (hold)
        buffer <= buffer; // when hold is high, reset is low, and clock is rising buffer <= buffer 
    else
        buffer <= Data_in; // when hold is low, reset is low, and clock is rising buffer <= data_in 
end

endmodule



