/*------------------------PAM8_Datapath---------------------------------------------*/
module PAM8_Datapath	(data_out, data_in, clock, reset, start, load);

output	[2:0] data_out;
input		  data_in, clock, reset, start, load;

reg		[2:0] shft_reg, out_reg;

assign data_out = out_reg;

always @ (posedge clock)
		  if (reset) begin
					 shft_reg	<= 3'b0;
					 out_reg	<= 3'b0;
					 end
	else if	 (start) begin
					 shft_reg	<= {data_in, shft_reg[1:0]};
					 out_reg	<= 3'b0;
					 end
	else if  (load)  begin
					 shft_reg	<= {data_in, shft_reg[2:1]};
					 out_reg	<= shft_reg;
					 end
	else 			 shft_reg	<= {data_in, shft_reg[2:1]};
endmodule