/*---------------------------------------------------------------------------------------
Testbench for the counting ones module 
-----------------------------------------------------------------------------------------*/
module majority_bits_are_1s_tb ();
parameter						word_size  = 8;
parameter						count_size = 3;
reg			[word_size -1:0]	data_in;
wire							majority_ones_out;
wire		[count_size -1:0]	count;

majority_bits_are_1s	UUT		(data_in, majority_ones_out, count);
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
endmodule