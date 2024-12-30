/*----------------------------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 11 HW Question 2
Group: Ron Kalin/ Lamin Jammeh
Project Description: This is a RAM module where write takes priority when a read_or_write signal is high
-----------------------------------------------------------------------------------------------------*/

module RAM	#(parameter	memory_height = 8,
				  parameter	data_width	  = 4)
            (
				 input											clock,				//one clock for read and write				 				 
				 input											reset,				//clears memory
				 input			[memory_height -1:0]		address,				//address line 
				 input											read_or_write,		//enables read or write 
				 input			[data_width -1:0]			data_in,				//input data port
				 output	reg	[data_width -1:0]			data_out				//output data port
				 );

//internal register
reg		[data_width -1:0]	memory [memory_height -1:0];					// temp register to store memory data
integer k;
					
//Transition logic
always	@(posedge clock)
	if (reset)
		for (k = 0; k < memory_height; k = k+1)
			memory[k] <= 4'b0000;					//all address lines in memory are cleared @ reset high
	else if (read_or_write)
			memory[address] <= data_in;		//priority to write if we recieve both read and write signal at the same time 
	else if (~read_or_write)
			data_out		<= memory[address];	// when read_or_write is low data_out=requested address line 
endmodule