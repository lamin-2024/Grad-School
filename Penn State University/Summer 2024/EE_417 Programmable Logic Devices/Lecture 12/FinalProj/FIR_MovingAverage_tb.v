/*----------------------------------------------------------------------------------
Name Ron Kalin, Class: EE417 Summer 2024
Final Project
Group: Ron Kalin/Lamin Jammeh
Project Description: testbench for moving average FIR filter
-------------------------------------------------------------------------------------*/
module FIR_MovingAverage_tb();
    parameter DATA_WIDTH =  8; // declare Parameters
    parameter FILT_LENGTH = 4;

    // Signals
    reg clk, reset, enable;
    reg [DATA_WIDTH-1:0] sample_in;
    wire [DATA_WIDTH-1:0] filtered_sample;
	 
	 //wires monitor internal variables
	 //wire [DATA_WIDTH-1:0] buffer0, buffer1, buffer2, buffer3;
	 wire [DATA_WIDTH-1:0]	Acc;
	 
	 /*wire [DATA_WIDTH-1:0] coeff0, coeff1,coeff2,coeff3;
	 wire [DATA_WIDTH-1:0] tap_outputs [0:3];*/

	 integer f;
	 
    // Instantiate the moving_average_filter module
    FIR_MovingAverage UUT (
        .FIR_out(filtered_sample),
		  .sample_in(sample_in),
		  .enable(enable),
		  .clock(clk),
        .reset(reset)
    );
//    assign buffer0 =UUT.sample_array[0];
//	 assign buffer1 =UUT.sample_array[1];
//	 assign buffer2 =UUT.sample_array[2];
//	 assign buffer3 =UUT.sample_array[3];
	 assign Acc = UUT.Acc;


    always #5 clk = ~clk;      // Clock generation

    // Test stimulus
    initial begin
        clk = 0;
        reset = 1;
		  #10 reset = 0; enable =1; // Release reset, enable
		  #20 sample_in = 8'b0000_0000;  // input sample of 0
		  #20 sample_in = 8'b0000_0000;  // input sample of 0
        #20 sample_in = 8'b0000_0100;  // input sample of 4
        #20 sample_in = 8'b0000_0000;  // input sample of 0
        #20; // Wait for some cycles

        // Applying additional test vectors
		  #20 sample_in = 8'b0001_0001;  // input sample of 17
		  #20 sample_in = 8'b0010_0001;  // input sample of 33
        #20 sample_in = 8'b0011_0001;  // input sample of 49
        #20 sample_in = 8'b0100_0001;  // input sample of 65
		  #20 sample_in = 8'b0101_0001;  // input sample of 81
		  #20 sample_in = 8'b0110_0001;  // input sample of 97
        #20 sample_in = 8'b0111_0001;  // input sample of 113
        #20 sample_in = 8'b1000_0001;  // input sample of 129
		  #20 sample_in = 8'b1001_0001;  // input sample of 145
		  #20 sample_in = 8'b1010_0001;  // input sample of 161
        #20 sample_in = 8'b1011_0001;  // input sample of 177
		  #20 enable =0;
		  #40 enable =1;
        #20 sample_in = 8'b1100_0001;  // input sample of 193
		  #20 sample_in = 8'b1101_0001;  // input sample of 209
		  #20 sample_in = 8'b1110_0001;  // input sample of 225
        #20 sample_in = 8'b1111_0001;  // input sample of 241
        #20 sample_in = 8'b1000_0001;  // input sample of 129a
        #20; // Wait for some cycles

        $display("Filtered Output: %h", filtered_sample);
        //$finish;
		  $stop;
    end
	 
// save to test bench data to a text file
initial
		begin
			f = $fopen ("TestBench_Data.txt",	"w");
			$fwrite(f, "%b		%d		%b		%d", sample_in, sample_in, filtered_sample, filtered_sample);
			$fclose(f);
		end
endmodule