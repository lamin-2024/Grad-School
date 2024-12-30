/*--------------------------------------MAC module--------------------------------*/

module MAC (ACC_out, Sample_in, weight_in, ACC_in);

//define the parameter sets for the design 
parameter FIR_order			= 4;
parameter Sample_size		= 6;						//maximum sample value is 63
parameter weight_size		= 5;						//maximum value may be 31
parameter word_size_out		= 2 * Sample_size + 2;		//maximum possible output 63*31*(4+1)

output	[word_size_out -1:0]	ACC_out;
input	[Sample_size -1:0]		Sample_in;
input	[weight_size -1:0]		weight_in;
input	[word_size_out -1:0]	ACC_in;

//define the formular for Multiply and Accumulate MAC 
assign ACC_out = (Sample_in * weight_in) + ACC_in;

endmodule






/*-----------------FIR noPipeline--------------------------------------------------------------------------------*/
module FIR_noPipeline (FIR_out_MAC, FIR_out_assign, Sample_in, clock, reset);

//define the parameter sets for the design 
parameter FIR_order			= 4;
parameter Sample_size		= 6;						//maximum sample value is 63
parameter weight_size		= 5;						//maximum value may be 31
parameter word_size_out		= 2 * Sample_size + 2;		//maximum possible output 63*31*(4+1)

output reg [word_size_out -1:0]		FIR_out_MAC;
output reg [word_size_out -1:0] 	FIR_out_assign;

input	   [Sample_size -1:0]		Sample_in;
input								clock, reset;

//define wires for the internal routing layout
wire	   [word_size_out -1:0] 	Acc_0, Acc_1, Acc_2, Acc_3, Acc_4;
wire	   [word_size_out -1:0]		comb_out;							//optional

//define the filter coefficients
parameter	b0 = 5'd3;
parameter	b1 = 5'd7;
parameter	b2 = 5'd20;
parameter	b3 = 5'd7;
parameter   b4 = 5'd3;

reg			[Sample_size -1:0]		Sample_Array[1:FIR_order];			//5th coefficient multiplied by Data_in
integer		k;

//------------------Method one to calculate the combinational logic----------------------------
MAC	M0	(Acc_0, Sample_in,		 b0, 0);
MAC M1	(Acc_1, Sample_Array[1], b1, Acc_0);
MAC M2	(Acc_2, Sample_Array[2], b1, Acc_1);
MAC M3	(Acc_3, Sample_Array[3], b1, Acc_2);
MAC M4	(Acc_4, Sample_Array[4], b1, Acc_3);

//------------------Method two to calculate combinational logic---------------------------------
assign comb_out = b0 * Sample_in
				+ b1 * Sample_Array[1]
				+ b2 * Sample_Array[2]
				+ b3 * Sample_Array[3]
				+ b4 * Sample_Array[4];
				
//define the transition logic 
always @ (posedge clock)
	if (reset == 1)
		begin
			for (k=1; K <= FIR_order; k = k + 1)
				Sample_Array[k] <= 0;
				FIR_out_MAC		<= 0;
				FIR_out_assign  <= 0;
		end
	else 
		begin
				Sample_Array[1] <= Sample_in;
					for (k = 2; k <= FIR_order; k = k + 1)
						Sample_Array[k] <= Sample_Array[k-1];
						FIR_out_assign  <= comb_out;
						FIR_out_MAC     <= Acc_4;
		end
endmodule






/*-----------------FIR noPipeline TestBench--------------------------------------------------------------------------------*/

module FIR_Pipeline_tb ();

//define the parameter sets for the design 
parameter FIR_order			= 4;
parameter Sample_size		= 6;						//maximum sample value is 63
parameter weight_size		= 5;						//maximum value may be 31
parameter word_size_out		= 2 * Sample_size + 2;		//maximum possible output 63*31*(4+1)

//define the wires and registers for the test bench
wire	[word_size_out -1:0]	FIR_out_MAC;
wire	[word_size_out -1:0]	FIR_out_assign;

reg		[Sample_size -1:0]		Sample_in;
reg								clock, reset;

//define the unit under test UUT
FIR_noPipeline	UUT	(FIR_out_MAC, FIR_out_assign, Sample_in, clock, reset);

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
		#100	Sample_in = 1;		//impulse response
		#10		Sample_in = 0;
		#100	Sample_in = 10;		//same input over 5 clock cycles
		#50		Sample_in = 0;
		#100	Sample_in = 1;
		#10		Sample_in = 2;
		#10		Sample_in = 8;
		#10		Sample_in = 2;
		#10		Sample_in = 1;
		#10		Sample_in = 0;
		#100	Sample_in = 63;
		#100	Sample_in = 0;
	end 
endmodule






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
	*************IR = 0		Input register
	*************PR = 0		Pipeline register
	*************OR = 0		Output register
	----------------------------------------*/
		begin
		//The input shift register 
			for (k=1; K <= FIR_order; k = k + 1)
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
			 PR[0] <= b0 * Sample_in
			 PR[1] <= b1 * Sample_Array[1]
			 PR[2] <= b2 * Sample_Array[2]
			 PR[3] <= b3 * Sample_Array[3]
			 PR[4] <= b4 * Sample_Array[4];
				
		//The outpput register 
		       FIR_out_pipeline <= PR[0] + PR[1] + PR[2] + PR[3] + PR[4];
		end
			
endmodule






/*-----------------FIR Pipeline (b)--------------------------------------------------------------------------------*/

/*
in this module the Pipeline registers are placed at the input of the adders
therefore PR is at oinput of a(0) + [x[n] * b(0)]
*/

module Pipeline_FIR_b (FIR_out, Sample_in, clock, reset);

//define the parameter sets for the design 
parameter FIR_order			= 4;
parameter Sample_size		= 6;						//maximum sample value is 63
parameter weight_size		= 5;						//maximum value may be 31
parameter word_size_out		= Sample_size + weight_size + 3;		//log2(2^2 * 2^5 * (order+1))

//define output
output reg [word_size_out -1:0]		FIR_out;

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

//define PR0 to PR3 as registers 
reg		[word_size_out -1:0]	PR0 [0:FIR_order];
reg		[word_size_out -1:0]	PR1 [1:FIR_order];
reg		[word_size_out -1:0]	PR2 [2:FIR_order];
reg		[word_size_out -1:0]	PR3 [3:FIR_order];

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
			for (k=1; K <= FIR_order; k = k + 1)
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
		//The pipeline register 
			for (k = 3; k <= FIR_order; k = k + 1)
				PR3[k] <= 0;
				
		//The outpput register 
		       FIR_out <= 0;
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
			Sample_Array[1] <= Sample_in;
			for (k = 2; k <= FIR_order; k = k + 1)
				Sample_Array[k] <= Sample_Array[k-1];
			
		//The pipeline register at PR0 
			 PR0[0] <= b0 * Sample_in;
			 PR0[1] <= b1 * Sample_Array[1];
			 PR0[2] <= b2 * Sample_Array[2];
			 PR0[3] <= b3 * Sample_Array[3];
			 PR0[4] <= b4 * Sample_Array[4];
			 
		//The pipeline register at PR1 
			 PR1[1] <= b1 * Sample_Array[1] + PR0[1];
			 PR1[2] <= b2 * Sample_Array[2];
			 PR1[3] <= b3 * Sample_Array[3];
			 PR1[4] <= b4 * Sample_Array[4];
			 
		//The pipeline register at PR2 
			 PR2[2] <= b2 * Sample_Array[2] + PR1[2];
			 PR2[3] <= b3 * Sample_Array[3];
			 PR2[4] <= b4 * Sample_Array[4];
			 
		//The pipeline register at PR3 
			 PR3[3] <= b3 * Sample_Array[3] + PR2[3];
			 PR3[4] <= b4 * Sample_Array[4];
				
		//The outpput register 
		       FIR_out_pipeline <= PR3[3] + PR3[4];
		end
			
endmodule






/*-----------------Pipeline_FIR--------------------------------------------------------------------------------*/
/*
in this module piepeline_a and piepeline_b are combined
*/

module Pipeline_FIR (FIR_pipeline_A, FIR_pipeline_B, FIR_MAC, Sample_in, clock, reset);

//define the parameter sets for the design 
parameter FIR_order			= 4;
parameter Sample_size		= 6;								//maximum sample value is 63
parameter weight_size		= 5;								//maximum value may be 31
parameter word_size_out		= Sample_size + weight_size + 3;	//maximum possible output 63*31*(4+1)

//define output
output reg [word_size_out -1:0]		FIR_MAC;
output reg [word_size_out -1:0]		FIR_pipeline_A;
output reg [word_size_out -1:0]		FIR_pipeline_B;


//define inputs
input	   [Sample_size -1:0]		Sample_in;
input								clock, reset;

//define wires for the internal routing layout
wire	[word_size_out -1:0]	FIR_assign;

//instantiate the different submodules
FIR_noPipeline M1 (FIR_MAC, FIR_assign, Sample_in, clock, reset);
piepeline_a	   M2 (FIR_pipeline_A, Sample_in, clock, reset);
piepeline_b	   M3 (FIR_pipeline_B, Sample_in, clock, reset);

endmodule






/*-----------------Pipeline_FIR testbench--------------------------------------------------------------------------------*/

module FIR_pipeline_tb ();

//define the parameter sets for the design 
parameter FIR_order			= 4;
parameter Sample_size		= 6;						//maximum sample value is 63
parameter weight_size		= 5;						//maximum value may be 31
parameter word_size_out		= 2 * Sample_size + 2;		//maximum possible output 63*31*(4+1)
parameter product_size		= Sample_size + weight_size;

//define the wires and registers for the test bench
wire	[word_size_out -1:0]	FIR_MAC;
wire	[word_size_out -1:0]	FIR_pipeline_B;
wire	[word_size_out -1:0]	FIR_pipeline_A;

reg		[Sample_size -1:0]		Sample_in;
reg								clock, reset;

//define the unit under test UUT
Pipeline_FIR	UUT	(FIR_pipeline_A, FIR_pipeline_B, FIR_MAC, Sample_in, clock, reset);

//define Probes to observe the Pipeline register PR0 
wire	[product_size -1:0]	PR00;			assign PR00 = UUT.M3.PR0[0];
wire	[product_size -1:0]	PR01;			assign PR01 = UUT.M3.PR0[1];
wire	[product_size -1:0]	PR02;			assign PR02 = UUT.M3.PR0[2];
wire	[product_size -1:0]	PR03;			assign PR03 = UUT.M3.PR0[3];
wire	[product_size -1:0]	PR04;			assign PR04 = UUT.M3.PR0[4];

//define Probes to observe the Pipeline register PR1
wire	[product_size -1:0]	PR11;			assign PR11 = UUT.M3.PR1[1];
wire	[product_size -1:0]	PR12;			assign PR12 = UUT.M3.PR1[2];
wire	[product_size -1:0]	PR13;			assign PR13 = UUT.M3.PR1[3];
wire	[product_size -1:0]	PR14;			assign PR14 = UUT.M3.PR1[4];

//define Probes to observe the Pipeline register PR2
wire	[product_size -1:0]	PR22;			assign PR22 = UUT.M3.PR2[2];
wire	[product_size -1:0]	PR23;			assign PR23 = UUT.M3.PR2[3];
wire	[product_size -1:0]	PR24;			assign PR24 = UUT.M3.PR2[4];

//define Probes to observe the Pipeline register PR3
wire	[product_size -1:0]	PR33;			assign PR33 = UUT.M3.PR3[3];
wire	[product_size -1:0]	PR34;			assign PR34 = UUT.M3.PR3[4];

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
		#100	Sample_in = 1;		//impulse response
		#10		Sample_in = 0;
		#100	Sample_in = 10;		//same input over 5 clock cycles
		#50		Sample_in = 0;
		#100	Sample_in = 1;
		#10		Sample_in = 2;
		#10		Sample_in = 8;
		#10		Sample_in = 2;
		#10		Sample_in = 1;
		#10		Sample_in = 0;
		#100	Sample_in = 63;
		#100	Sample_in = 0;
	end 
endmodule

