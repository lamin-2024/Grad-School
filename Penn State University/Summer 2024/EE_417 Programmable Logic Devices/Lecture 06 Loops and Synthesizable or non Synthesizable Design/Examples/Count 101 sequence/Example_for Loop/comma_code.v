module comma_code #(parameter word_size = 16,
							  index_size = 4)
				   (output	reg [index_size - 1:0]	index_out,
				   input		[word_size - 1:0]   word_in,
				   input   							trigger);
				   reg [word_size - 1:0]	temp_reg;				//Temporary register to locate the comma code
																//using shifting, we cantest the 3LSB instead
																//of moving the index
																//avoid the error that index out is not a constant word
	always @ (posedge trigger)
			begin: search_code
				temp_reg = word_in;								//copying the result into the temporary register
				for (index_out = 2;	index_out < (word_size);	index_out = (index_out + 1))
					begin
						if (temp_reg[2:0] == 3'b101) disable search_code;	//always check the 3LSBs
						else begin
								temp_reg = temp_reg >> 1;								//shift the temp_reg to the right
								if ((temp_reg == 0) | (index_out == (word_size - 1))) 	//the temp_reg is all 0s
										 begin 
										 index_out = 4'b0000;
										 disable search_code;
										 end
								end
						end
			end
endmodule