/*--------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 09 HW Question 3
Group: Ron Kalin/ Lamin Jammeh
Project Description: TestBench for Interpolator Filter 
----------------------------------------------------------*/
module Linear_Interpolator_tb ();

//define the registers and wire for the signals to monitor
reg		   clock, reset;
reg	[7:0] Data_in;
wire	[7:0]	Data_out;

//define the internal probes in the testbench for buffer1 and buffer2
wire       filter;  // New wire for observing filter
wire [7:0] buffer1; // New wire for observing buffer1
wire [7:0] buffer2; // New wire for observing buffer2

//Instantiate the unit under test UUT
Linear_Interpolator #(8)	UUT (
						       .Data_out(Data_out),
						       .Data_in(Data_in),
						       .clock(clock),
						       .reset(reset)
						       );
						  
// Assign buffer1 and buffer2 in the testbench to buffer1 and buffer2 in the Unit under test
assign filter  = UUT.filter;
assign buffer1 = UUT.buffer1;
assign buffer2 = UUT.buffer2;

//instantiate the clock cycle
initial
	begin
		clock = 0;
		forever #5 clock = ~clock;
	end
		
initial 
	begin
		//Initialize all the inputs
		reset = 1;
		Data_in = 8'b0;
      #20 reset = 0;
		
		//multiple Data_in samples and observe the buffer and Data_out
			 Data_in = 8'b10101010;
		#20 Data_in = 8'b01101001;
		#20 Data_in = 8'b00110011;
		#20 Data_in = 8'b11101001;
		
		//take everything back Data_out back to zero by setting reset to high
		#20  reset = 1;
		#20  reset = 0;
		
		// Final test case to ensure the interpolator works correctly after reset
		    Data_in = 8'b00001001;
		#20 Data_in = 8'b01101011;
		#20 Data_in = 8'b11101011;
		#20 Data_in = 8'b11101111;
		
		// stop the simulation
		#20;
		$stop;
	end
	
// Display the results
always @(posedge clock)
	begin					
		$display("@ Time = %t	Data_in = %d	Filter = %d		Buffer1 = %d 	Buffer2 = %d 	Data_out = %d", $time, Data_in, filter, buffer1, buffer2, Data_out);
	end	 
	
endmodule