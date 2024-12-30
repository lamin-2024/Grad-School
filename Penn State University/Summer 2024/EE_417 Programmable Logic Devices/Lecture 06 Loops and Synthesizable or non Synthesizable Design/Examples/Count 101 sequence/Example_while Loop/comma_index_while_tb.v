/*------------------TestBench--------------------------------------------------------------------*/
module comma_index_while_tb ();
parameter						word_size	= 16;
parameter						index_size  = 4 ;
wire       [index_size - 1:0]   index_out;
reg		   [word_size  - 1:0]   word_in;
reg							    trigger;

comma_index_while UUT (index_out, word_in, trigger);

initial begin
		trigger		= 1'b0;
		forever
			#10		trigger	= ~trigger;
		end
		
initial fork
		 word_in = 16'b_0000_0000_0000_0101;
	#40  word_in = 16'b_0000_1010_1010_0000;
	#80  word_in = 16'B_1010_0000_0000_1111;
	#120 word_in = 16'b_0000_0000_0000_0000;
	#160 word_in = 16'b_1111_0101_0000_1111;
	#200 word_in = 16'b_1111_1111_1111_1111;
	#240 word_in = 16'b_0000_1010_1011_0111;
	#280 word_in = 16'b_0000_1010_0000_1111;
		  join
initial
		$monitor ($time,, "word_in = %b: index_out = %d", word_in, index_out);
endmodule