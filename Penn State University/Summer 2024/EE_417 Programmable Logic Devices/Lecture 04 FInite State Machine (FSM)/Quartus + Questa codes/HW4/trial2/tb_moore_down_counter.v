//`timescale 1ns / 1ps

module tb_moore_down_counter;
    // Inputs
    reg clk;
    reg reset;
    reg enable;

    // Outputs
    wire [3:0] count;

    // Instantiate the Unit Under Test (UUT)
    moore_down_counter uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count)
    );

   //instantiate the clk cycles
initial
	begin
		clk = 1'b0;
		forever
		#5		clk = ~clk;  
	end
	
//instantiate the reset bit
initial
	begin
		reset = 1'b1;
		#50	reset = 1'b0;
		#200  reset = 1'b1;
		#40	reset = 1'b0;
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

    initial begin
        // Monitor signals
        $monitor("Count: %b", count);
    end

endmodule
