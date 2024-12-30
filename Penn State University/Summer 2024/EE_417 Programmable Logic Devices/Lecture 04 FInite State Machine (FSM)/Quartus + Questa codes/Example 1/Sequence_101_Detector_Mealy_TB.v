/*____________________________________________________________
Test Bench for the Mealy Machine
Sequence _101_Detector_Mealy
EE417 Summer 2024
______________________________________________________________*/

module Sequence_101_Detector_Mealy_TB ();

wire	z_out;
reg	clk, reset;
reg	x_in;

wire [1:0] state, next_state;   //internal probes
 
Sequence_101_Detector_Mealy UUT (z_out, clk, reset, x_in);

//internal probes to make it easy to track the logic and for troubleshooting
assign state = UUT.state;
assign next_state = UUT.next_state;

initial
begin
clk = 1'b0;
forever begin
	#5 clk = ~clk;	end
end
	
initial
begin
reset = 1'b1;
#30  reset = 1'b0;
#200 reset = 1'b1;
#30  reset = 1'b0;
end
		
initial
begin
	x_in = 1'b0; #15
		
	forever	begin
		
			x_in = 1'b1;	#10	x_in = 1'b0;	#10 x_in = 1'b1;	#10;	//101 sequence
			x_in = 1'b0;	#10	x_in = 1'b1;	#10 x_in = 1'b1;	#10;	//011
			x_in = 1'b1;	#10	x_in = 1'b0;	#10 x_in = 1'b1;	#10;	//101 sequence
			x_in = 1'b0;	#10	x_in = 1'b1;	#10 x_in = 1'b0;	#10;	//overlapping 101
			x_in = 1'b1;	#10	x_in = 1'b0;	#10 x_in = 1'b0;	#10;	//overlapping
			x_in = 1'b0;	#10	x_in = 1'b0;	#10 x_in = 1'b0;	#10;	//000
			x_in = 1'b1;	#10	x_in = 1'b1;	#10 x_in = 1'b1;	#10;	//111
			x_in = 1'b0;	#10	x_in = 1'b1;	#10 x_in = 1'b1;	#10;	//1..011
		end
	end
endmodule