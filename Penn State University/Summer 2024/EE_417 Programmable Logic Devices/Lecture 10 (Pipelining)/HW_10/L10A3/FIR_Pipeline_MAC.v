/*-----------------FIR Pipeline MAC--------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 10 HW Question 3
Group: Ron Kalin/ Lamin Jammeh
Project Description: In this module the Pipeline registers are placed at the output of the adders
note thet Current_adder = Prev_adder + b(n) * Sample_Array[n]
-----------------------------------------------------------------------------------------------------*/

module FIR_Pipeline_MAC (FIR_out_pipeline, Sample_in, clock, reset);

//define the parameter sets for the design 
parameter FIR_order			= 6;
parameter Sample_size		= 6;						//maximum sample value is 63
parameter weight_size		= 4;						//maximum value may be 31
parameter word_size_out		= 2 * Sample_size + 3;		//log2(2^2 * 2^5 * (order+1))
parameter product_size		= Sample_size + weight_size + 3;

//define output
output reg [word_size_out -1:0]		FIR_out_pipeline;

//define inputs
input	   [Sample_size -1:0]		Sample_in;
input										clock, reset;

//define the filter coefficients
parameter	b0 = 4'd2;
parameter	b1 = 4'd5;
parameter	b2 = 4'd9;
parameter	b3 = 4'd14;
parameter   b4 = 4'd9;
parameter	b5 = 4'd5;
parameter   b6 = 4'd2;


reg			[Sample_size -1:0]		Sample_Array[1:FIR_order];			//5th coefficient multiplied by Data_in
integer		k;

//define PR0 to PR3 as registers 
reg		[word_size_out -1:0]	PR0 [0:FIR_order];
reg		[word_size_out -1:0]	PR1 [1:FIR_order];
reg		[word_size_out -1:0]	PR2 [2:FIR_order];

//define the transition logic 
always @ (posedge clock)
	if (reset == 1)
	/*---------------------------------------
	if reset is high do the following
	****set all Pipeline registers to zero
	*************IR = 0		Input register or Sample_Array
	*************PR = 0		Pipeline register or PR
	*************OR = 0		Output register or FIR_out_pipeline
	----------------------------------------*/
		begin
		//The input shift register 
			for (k=1; k <= FIR_order; k = k + 1)
				Sample_Array[k] <= 0;
				
		//The pipeline register 
			for (k = 0; k <= FIR_order; k = k + 1)
				PR0[k] <= 0;
		//The pipeline register 
			for (k = 1; k <= FIR_order; k = k + 1)
				PR1[k] <= 0;
			
		//The pipeline register 
			for (k = 2; k <= FIR_order; k = k + 1)
				PR2[k] <= 0;	
			
		//The outpput register 
		       FIR_out_pipeline <= 0;
		end
		
	else
	/*---------------------------------------
	if reset is low do the following
	*************1 => move the Sample in into a cutset (Input register) to reduce idle time of the input 
	*************2 => PR = Prev_PR + b(n) * x[n] since the first PR is the at the output of the first adder
	*************3 => add all the products to generate the output 
	----------------------------------------*/
		begin
		//The input shift register 
			Sample_Array[1] <= Sample_in;
			for (k = 2; k <= FIR_order; k = k + 1)
				Sample_Array[k] <= Sample_Array[k-1];
			
		//@ input of add_0 there is no Pipeline Register 
			 //PR0[0] <= b0 * Sample_in;					//ignore the other input (c_in = 0) to the summation (add_0)
			 
		//@ input of add_1 or output of add_0 there is PR0 and b1*Sample_in[1]
		//make sure the countour line with pipeline registers is extended to rest of the coefficients from b2...bn for data coherency
			 PR0[1] <= b1 * Sample_Array[1] + (b0 * Sample_in);
			 PR0[2] <= b2 * Sample_Array[2];
			 PR0[3] <= b3 * Sample_Array[3];
			 PR0[4] <= b4 * Sample_Array[4];
			 PR0[5] <= b5 * Sample_Array[5];
			 PR0[6] <= b6 * Sample_Array[6];
			 
		//@ input of add_2 or output of add_1 there is PR1 and b2*Sample_in[2]
			 //PR2[2] <= PR0[1] + PR0[2]; 
			 
		//@ input of add_3 or output of add_2 there is PR2 and b3*Sample_in[3]
		//make sure the countour line with pipeline registers is extended to rest of the coefficients from b4...bn for data coherency
			 PR1[3] <= PR0[3] + (PR0[1] + PR0[2]);
			 PR1[4] <= PR0[4];
			 PR1[5] <= PR0[5];
			 PR1[6] <= PR0[6];
				
		//@ input of add_4 or output of add_3 there is PR3 and b4*Sample_in[4]
			 //PR4[4] <= PR0[4] + PR1[3];	
			 
		//@ input of add_5 or output of add_4 there is PR4 and b5*Sample_in[5]
		//make sure the countour line with pipeline registers is extended to rest of the coefficients from b6...bn for data coherency
			 PR2[5] <= PR1[5] + (PR1[4] + PR1[3]);
			 PR2[6] <= PR1[6];	 
	
		//The outpput register 
		       FIR_out_pipeline <= PR2[6] + PR2[5];
		end
			
endmodule