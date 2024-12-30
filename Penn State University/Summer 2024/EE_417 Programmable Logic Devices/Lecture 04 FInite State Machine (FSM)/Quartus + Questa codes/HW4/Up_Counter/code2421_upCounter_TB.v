/*-------------------------------------------------------------
Test Bench for code2421_upCounter
CLass: EE417 Summer 2024
Lesson 04 HW Question 3 part 2
Group: Ron Kalin/ Lamin Jammeh
---------------------------------------------------------------*/
//Step1 define the test bench
module code2421_upCounter_TB ();

//step2 define define the inputs and outputs of the testbench
reg 			clk, reset, enable;
wire   [3:0] count;
wire	 [3:0] upcount;



 //step3 Instantiate the code2421_upCounter module
 code2421_upCounter UUT (
								.upcount(upcount),
								.clk(clk),
								.reset(reset),
								.enable(enable)
								);

//assign internal probe to count 
assign count = UUT.count;
    
//step4 Initialize clock
initial 
	begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period
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

        // Display both upcount and count values
        $display("upcount = %b, count = %b", upcount, count);
    end

endmodule
