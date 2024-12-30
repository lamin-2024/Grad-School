/*------------------------------------------------------------------------
writea Verilog module that detects whether an input word has its majority of
bits equal to 1s or not. The module should be parameterized, and should use 
the disable command
--------------------------------------------------------------------------*/

module majority_bits_are_1s  #(
							   parameter	word_size  = 8,
							   parameter	majority   = 5,
							   parameter	count_size = 3
							   )
							  (
							   input		[word_size -1: 0]	data_in,
							   output							majority_ones_out,
							   output	reg	[count_size -1:0]	count 
							   );
integer 	index;     //define index as integer to shift through the data_in

//assign a condition for majority_ones_out 
assign		majority_ones_out = (count >= majority);		//if the number of 1s in data_in exceeds 4 or is >=5 then 1s are the majority in data_in

//system is not clk or time trigger
//define an always block and write the conditions for the output or behavior of the system
always	@ (data_in)							//look for change in data_in
	begin:	count_ones						//name the begine block as count_ones
	count = 0;								//start count at 0
	for (index = 0;		index < word_size;	index = index + 1)		//start index from 0 to word_size and increment by 1
		begin
			count = count + data_in[index];							//check data_in for 1s and update count with total 1s in data_in
			if (count >= majority)									
					disable count_ones;								// stop counting once count is equal to 8
		end
end
endmodule