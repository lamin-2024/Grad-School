/*----------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 06 HW Question 2
Group: Ron Kalin/ Lamin Jammeh
Project Description: This is the main module, it detects a comma symbol 4b'1101 once
the symbol is detect the index of the MSB of the symbol and send it as an output 
-------------------------------------------------------------------------------------*/
module comma_1101_search #(parameter word_size = 32,
							  index_size = 4)
				   (output	reg [index_size:0]	index_out, 		//4 bits index [4:0]=16+8+4+2+1=31, possible index_out = 0:31
				   input		[word_size - 1:0]    word_in,			//32 bits input [31:0]
				   input   							   trigger);		//triggers the count
               reg [word_size - 1:0]	temp_reg;				//Temporary register to locate the comma code
																
always @ (posedge trigger)
			begin: search_code
				temp_reg = word_in;								//copying the result into the temporary register
				for (index_out = 3;	index_out < (word_size);	index_out = (index_out + 1))
					begin
						if (temp_reg[3:0] == 4'b1101) disable search_code;	//always check the 3LSBs
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