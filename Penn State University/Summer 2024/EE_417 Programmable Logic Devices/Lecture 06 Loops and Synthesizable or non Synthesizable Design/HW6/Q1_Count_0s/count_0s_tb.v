/*----------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 06 HW Question 1
Group: Ron Kalin/ Lamin Jammeh
Project Description: This is the test-bench for the count_0s code
-------------------------------------------------------------------------------------*/

/*----------16 bits Word_size Trial--------------*/
module count_0s_tb ();

//define the parameters, registes and wires
parameter								word_size  = 8;					//can be change to any desirded word_size
parameter								count_size = 5;
reg			[word_size -1:0]		data_in;
wire			[count_size -1:0]		total_zeros;

//define the unit under test UUT
count_0s	UUT		(data_in, total_zeros);

//simulate different data_in and observe the outputs to validate the design

//-------------16-bit data_in word_size-------------//
//initial
//	begin
//		#0	  data_in = 16'b0000_0000_0000_0000;
//		#10  data_in = 16'b1111_0000_0000_0001;
//		#10  data_in = 16'b1111_0111_1111_1111;
//		#10  data_in = 16'b1010_1010_1000_1110;
//		#10  data_in = 16'b0111_0000_0011_1111;
//		#10  data_in = 16'b0011_1111_0011_1001;
//		#10  data_in = 16'b0000_0011_0000_0011;
//		#10  data_in = 16'b1010_1111_1101_0011;
//	end

//-------------8-bit data_in word_size-------------//	
initial
	begin
		#0	 data_in = 8'b0000_0000;
		#10  data_in = 8'b1111_0001;
		#10  data_in = 8'b0000_1111;
		#10  data_in = 8'b1111_1111;
		#10  data_in = 8'b1010_1010;
		#10  data_in = 8'b0111_1111;
		#10  data_in = 8'b1100_0001;
		#10  data_in = 8'b1111_0011;
		#10  data_in = 8'b0000_0011;
		#10  data_in = 8'b1010_1111;
	end
//monitor the results
initial
	begin
		$monitor ($time,, "data_in = %b: total_zeros = %d", data_in, total_zeros);
	end
endmodule