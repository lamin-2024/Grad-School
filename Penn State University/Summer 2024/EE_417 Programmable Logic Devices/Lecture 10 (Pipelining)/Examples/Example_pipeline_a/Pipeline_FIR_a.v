/*-----------------FIR Pipeline (a)--------------------------------------------------------------------------------*/

/*
in this module the Pipeline registers are placed at the output of the multipliers
therefore PR is at output of x[n] * b(n)
*/

module Pipeline_FIR_a (FIR_out_pipeline, Sample_in, clock, reset);

//define the parameter sets for the design 
parameter FIR_order			= 4;
parameter Sample_size		= 6;						//maximum sample value is 63
parameter weight_size		= 5;						//maximum value may be 31
parameter word_size_out		= 2 * Sample_size + 3;		//log2(2^2 * 2^5 * (order+1))
parameter product_size		= Sample_size + weight_size + 3;

//define output
output reg [word_size_out -1:0]		FIR_out_pipeline;

//define inputs
input	   [Sample_size -1:0]		Sample_in;
input								clock, reset;

//define the filter coefficients
parameter	b0 = 5'd3;
parameter	b1 = 5'd7;
parameter	b2 = 5'd20;
parameter	b3 = 5'd7;
parameter   b4 = 5'd3;

reg			[Sample_size -1:0]		Sample_Array[1:FIR_order];			//5th coefficient multiplied by Data_in
integer		k;
reg			[product_size -1:0]		PR[0:FIR_order];					//Array format for Pipeline register 

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
				PR[k] <= 0;
				
		//The outpput register 
		       FIR_out_pipeline <= 0;
		end
		
	else
	/*---------------------------------------
	if reset is low do the following
	*************1 => move the Sample in into a cutset (Input register) to reduce idle time of the input 
	*************2 => Multiply  the Sample_in x[n] by the b(n) and save in Pipeline register (PR[n-1])
		*********therefore PR[n-1] = x[n] * b(0...n)
	*************3 => add all the products to generate the output 
	----------------------------------------*/
		begin
		//The input shift register 
			Sample_Array[1] <= Sample_in;
			for (k = 2; k <= FIR_order; k = k + 1)
				Sample_Array[k] <= Sample_Array[k-1];
			
		//The pipeline register 
			 PR[0] <= b0 * Sample_in;
			 PR[1] <= b1 * Sample_Array[1];
			 PR[2] <= b2 * Sample_Array[2];
			 PR[3] <= b3 * Sample_Array[3];
			 PR[4] <= b4 * Sample_Array[4];
				
		//The outpput register 
		       FIR_out_pipeline <= PR[0] + PR[1] + PR[2] + PR[3] + PR[4];
		end
			
endmodule