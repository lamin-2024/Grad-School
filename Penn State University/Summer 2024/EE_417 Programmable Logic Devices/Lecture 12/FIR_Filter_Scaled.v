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
module FIR_Filter_Project1	#(parameter order = 10,										//filter order [pre-determined]
									  parameter word_size_in = 4,								//size of data_in [pre-determined]
									  parameter word_size_out = 16)	//word_size = word_in + coeff_size + [log2[N]] N=4, & coeff=word_in
							  
									//declare inputs and outputs
									(
									output	[word_size_out - 1:0]	Data_out,
									input		[word_size_in - 1:0]		Data_in,
									input										clock, reset
									);
									
reg		[word_size_in -1:0]		Samples[order:0];		//temp storage for input samples (x(n))
reg		[word_size_out -1:0]	acc;					//temp storage for output data
integer	k;

//Filter Coefficients
parameter b0 = 4'd7;
parameter b1 = 4'd8;
parameter b2 = 4'd9;
parameter b3 = 4'd12;
parameter b4 = 4'd4;
parameter b5 = 4'd6;
parameter b6 = 4'd3;
parameter b7 = 4'd2;
parameter b8 = 4'd5;
parameter b9 = 4'd42;

//define the formula for the output
assign 	Data_out = acc;

/define PR0 to PR9 as registers 
reg		[word_size_out -1:0]	PR0 [0:order-1];
reg		[word_size_out -1:0]	PR1 [1:order-1];
reg		[word_size_out -1:0]	PR2 [2:order-1];
reg		[word_size_out -1:0]	PR3 [3:order-1];
reg		[word_size_out -1:0]	PR4 [4:order-1];
reg		[word_size_out -1:0]	PR5 [5:order-1];
reg		[word_size_out -1:0]	PR6 [6:order-1];
reg		[word_size_out -1:0]	PR7 [7:order-1];
reg		[word_size_out -1:0]	PR8 [8:order-1];

//define the transition logic 
always @ (posedge clock)
	if (reset == 1)
	/*---------------------------------------
	if reset is high do the following
	****set all Pipeline registers to zero
	*************IR = 0		Input register
	*************PR[0:order-1] = 0		Pipeline register
	*************OR = 0		Output register
	----------------------------------------*/
		begin
		//The input shift register 
			for (k=0; k <= order; k = k + 1)
				Samples[k] <= 0;
				
		//The pipeline register 
			for (k = 0; k <= order; k = k + 1)
				begin
					PR0[k] <= 0;
					PR1[k] <= 0;
					PR2[k] <= 0;
					PR3[k] <= 0;
					PR4[k] <= 0;
					PR5[k] <= 0;
					PR6[k] <= 0;
					PR7[k] <= 0;
					PR8[k] <= 0;
				end 
		//The outpput register 
		       acc <= 0;
		end
	else
	/*---------------------------------------
	if reset is low do the following
	*************1 => move the Sample in into a cutset (Input register) to reduce idle time of the input 
	*************2 => insert the PR at the input of the add and perform x[n] * b(n) and save in Pipeline register (PRn[n-1])
	*************3 => add all the PR registers at the input of the output register and save in the Output register
	----------------------------------------*/
		begin
		//The input shift register 
			Samples[0] <= Data_in;
			for (k = 1; k <= order; k = k + 1)
				Samples[k] <= Samples[k-1];
			
		//The pipeline register at PR0 
			 PR0[0] <= b0 * Data_in;
			 PR0[1] <= b1 * Samples[1];
			 PR0[2] <= b2 * Samples[2];
			 PR0[3] <= b3 * Samples[3];
			 PR0[4] <= b4 * Samples[4];
			 PR0[5] <= b5 * Samples[5];
			 PR0[6] <= b6 * Samples[6];
			 PR0[7] <= b7 * Samples[7];
			 PR0[8] <= b8 * Samples[8];
			 PR0[9] <= b9 * Samples[9];
			 
		//The pipeline register at PR1 
			 PR1[0] <= PR0[0];
			 PR1[1] <= b1 * Samples[1] + PR0[1];
			 PR1[2] <= b2 * Samples[2];
			 PR1[3] <= b3 * Samples[3];
			 PR1[4] <= b4 * Samples[4];
			 PR1[5] <= b5 * Samples[5];
			 PR1[6] <= b6 * Samples[6];
			 PR1[7] <= b7 * Samples[7];
			 PR1[8] <= b8 * Samples[8];
			 PR1[9] <= b9 * Samples[9];
			 
		//The pipeline register at PR2 
			 PR2[2] <= b2 * Samples[2] + PR1[2];
			 PR2[3] <= b3 * Samples[3];
			 PR2[4] <= b4 * Samples[4];
			 PR2[5] <= b5 * Samples[5];
			 PR2[6] <= b6 * Samples[6];
			 PR2[7] <= b7 * Samples[7];
			 PR2[8] <= b8 * Samples[8];
			 PR2[9] <= b9 * Samples[9];
			 
		//The pipeline register at PR3 
			 PR3[3] <= b3 * Samples[3] + PR2[3];
			 PR3[4] <= b4 * Samples[4];
			 PR3[5] <= b5 * Samples[5];
			 PR3[6] <= b6 * Samples[6];
			 PR3[7] <= b7 * Samples[7];
			 PR3[8] <= b8 * Samples[8];
			 PR3[9] <= b9 * Samples[9];
		
		//The pipeline register at PR4 
			 PR4[4] <= b4 * Samples[4] + PR3[4];
			 PR4[5] <= b5 * Samples[5];
			 PR4[6] <= b6 * Samples[6];
			 PR4[7] <= b7 * Samples[7];
			 PR4[8] <= b8 * Samples[8];
			 PR4[9] <= b9 * Samples[9];

		//The pipeline register at PR5
			 PR5[5] <= b5 * Samples[5] + PR4[5];
			 PR5[6] <= b6 * Samples[6];
			 PR5[7] <= b7 * Samples[7];
			 PR5[8] <= b8 * Samples[8];
			 PR5[9] <= b9 * Samples[9];

		//The pipeline register at PR6
			 PR6[6] <= b6 * Samples[6] + PR5[6];
			 PR6[7] <= b7 * Samples[7];
			 PR6[8] <= b8 * Samples[8];
			 PR6[9] <= b9 * Samples[9];
			 
		//The pipeline register at PR7
			 PR7[7] <= b7 * Samples[7] + PR6[7];
			 PR7[8] <= b8 * Samples[8];
			 PR7[9] <= b9 * Samples[9];
		
		//The pipeline register at PR8
			 PR8[8] <= b8 * Samples[8] + PR7[8];
			 PR8[9] <= b9 * Samples[9];
			 
		//The outpput register 
		       acc <= PR8[8] + PR8[9];
		end
			
endmodule
