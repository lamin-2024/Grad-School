
module selectorBlock_A_TB ();

    // Inputs
    reg sel;
    reg clk;
    reg reset;
    reg enable;

	 //declare internal probes as wire 
	 wire [3:0] count;
	 wire [3:0] upcount;
	 
    // Outputs
    wire y;

    // Instantiate the selectorBlock_A module
    selectorBlock_A UUT (
								 .y(y),
								 .sel(sel),
								 .clk(clk),
								 .reset(reset),
								 .enable(enable)
								);
	 
	 //assign internal probe to count and upcount 
	assign count = UUT.count;
	assign upcount = UUT.upcount;
	
    //step4 Initialize clock
initial 
	begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period
    end

	 //step5 initialize the sel bit for the test purpose
	 initial 
	begin
        sel = 0;
        forever #15 sel = ~sel; // 30ns period
    end
 // Initialize signals
initial 
	begin
        clk = 0;
        reset = 0;
        enable = 1; // Enable the counter

        // Apply reset
        #10 reset = 1;
        #10 reset = 0;

        // Simulate some clock cycles
        #50;

        // Display output y
        $display("y = %b", y);
    end

endmodule
