/*----------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 06 HW Question 1
Group: Ron Kalin/ Lamin Jammeh
Project Description: This is the main module, it counts the number of 0s in the input 
data and displays the results
Note that the word_size is Parameterize so it can change without causing an error in the code 
-------------------------------------------------------------------------------------*/

/*----------16 bits Word_size Trial--------------*/
module count_0s #(
							   parameter	word_size  = 8,				//change as you wish
							   parameter	count_size = 5					//count size should be at least 16 to accomodate for both 8bit and 16bit word_size
							   )
							  (
							   input		[word_size -1: 0]	data_in,							//data_in = [15:0]
							   output	reg	[count_size -1:0]	total_zeros 
							   );
integer 	index;     //define index as integer to shift through the data_in


//define an always block and write the conditions for the output or behavior of the system
always	@ (data_in)							//look for change in data_in
	begin:	count_zeros						//name the begine block as count_ones
		total_zeros = 0;								//start total_zeros at 0
		for (index = 0;		index < word_size;	index = index + 1)		//start index from 0 to word_size and increment by 1
			begin
				if (data_in[index] == 0)													//check each index of data for 0s
					begin
					total_zeros = total_zeros + 1;														//increment count by 1 once a 0 is encounter at an index in data_in
					end
			end
	end
endmodule