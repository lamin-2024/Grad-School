/*----------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 06 HW Question 2
Group: Ron Kalin/ Lamin Jammeh
Project Description: This is the test-bench for the comma symbol 4b'1101 detector
-------------------------------------------------------------------------------------*/
module comma_search_tb ();

//set the parameters wires and registers
parameter						word_size	= 32;
parameter						index_size  = 4 ;
wire       [index_size:0]   index_out;
reg		   [word_size  - 1:0]   word_in;
reg							    trigger;

//define the unit under test UUT
comma_search UUT (index_out, word_in, trigger);

//instantiate the trigger signal
initial begin
		trigger		= 1'b0;
		forever
			#10		trigger	= ~trigger;
		end

//define the word inut and observe the outputs		
initial fork
		  word_in = 32'b_0000_0000_0000_0000_0000_0000_0000_1101;
	#40  word_in = 32'b_0000_1010_1010_0000_1101_0000_0000_0000;
	#80  word_in = 32'B_1110_0000_0000_1101_1010_1010_0000_1001;
	#120 word_in = 32'b_0000_0000_0000_0000_1111_1111_1101_0000;
	#160 word_in = 32'b_1101_0101_0000_1111_0000_1010_1010_0000;
	#200 word_in = 32'b_1111_1111_1111_1111_1111_1111_1101_0000;
	#240 word_in = 32'b_0000_1010_1011_0111_1101_0101_0000_1111;
	#280 word_in = 32'b_0000_1101_0000_1111_0000_1101_0000_1010;
		  join

////monitor and display the output 		  
initial
		$monitor ($time,, "word_in = %b: index_out = %d", word_in, index_out);
endmodule