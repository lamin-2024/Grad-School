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
//MAC	M0	(Acc_0, Sample_in,		 b0, 0);
//MAC M1	(Acc_1, Sample_Array[1], b1, Acc_0);
//MAC M2	(Acc_2, Sample_Array[2], b1, Acc_1);
//MAC M3	(Acc_3, Sample_Array[3], b1, Acc_2);
//MAC M4	(Acc_4, Sample_Array[4], b1, Acc_3);

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
			for (k=1; k <= FIR_order; k = k + 1)
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