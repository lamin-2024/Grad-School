module RandomCounter_TB ();

wire [2:0] count;
reg		  reset, enable, mode;
reg		  clk;

//internal probes to observe the state is changing
wire [1:0] state, next_state;

// define the units under test
RandomCounter UUT (count, clk, reset, enable, mode);

//assigning the internal probes to the test internal register
assign state		= UUT.state;
assign next_state = UUT.next_state;

//instantiate the clk cycles
initial
	begin
		clk = 1'b0;
		forever
		#5		clk = ~clk;  
	end
	
//instantiate the reset cycle
initial
	begin
		reset = 1'b1;
		#50	reset = 1'b0;
		#200  reset = 1'b1;
		#40	reset = 1'b0;
	end
	
//instantiate the mode
initial
	begin
		mode = 1'b0;
		forever
		#100  mode = ~mode;
	end
	
//instantiate the enable bit
initial
	begin
		enable = 1'b0;
		forever
			begin
				#30	enable = 1'b1;
				#80	enable = 1'b0;
			end
	end
endmodule