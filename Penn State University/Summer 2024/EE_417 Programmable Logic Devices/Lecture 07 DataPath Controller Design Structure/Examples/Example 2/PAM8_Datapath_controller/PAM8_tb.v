/*-------------------------PAM8_tb------------------------------------------------------------*/
module PAM8_tb ();

reg	clock, reset, enable;
reg	data_in;

wire [2:0] data_out;
reg  [2:0] data_counter;

PAM8_Datapath_controller UUT (data_in, data_out, reset, clock, enable);

initial
	begin
		clock	= 1'b0;
		reset   = 1'b1;
		enable  = 1'b0;
		data_in	= 1'b0;
	end

always
#10 clock = ~clock;

initial
	begin
		#20	data_counter = 3'b101;
		forever
		#60 data_counter = data_counter + 1'b1;
	end
	
always
	begin
		#20	 data_in = data_counter [0];
		#20	 data_in = data_counter [1];
		#20	 data_in = data_counter [2];
	end
	
initial
	begin
		#40	 reset	= 1'b0;
		#80  enable = 1'b1;
		#180 enable = 1'b0;
		#240 enable = 1'b1;
	end
	
endmodule