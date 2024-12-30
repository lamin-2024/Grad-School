// ee417 lesson 11 Assignment 1 L11A1
// Name: Ron Kalin, Date: 07-25-24  Group: Kalin/Jammeh
// Design: FIFO using common clock for reading and writing, with reset.
// FIFO has input & output data ports, & flags denoting status of the stack (full or empty).
// FIFO module should not support simultaneous read & write, and gives preference to the read operation. 
// parameters are used for the stack height and width. starting point: data width=5 & stack height=8
module FIFO ( Data_out,			// data path from FIFO
				  stack_empty,		// flag asserted high for empty stack
				  stack_almost_empty,
				  stack_full,		// flag asserted high for full stack
				  stack_almost_full,
				  Data_in,			// data path into FIFO
				  write_to_stack,	// input controlling write to stack
				  read_from_stack,// input controlling read to stack
				  clk,				// clock
				  rst	);				// reset
parameter stack_width  = 5;	// width of stack and data points (bit length of word)
parameter stack_height = 8;	// height of stack (# of words)
parameter stack_ptr_width = $clog2(stack_height); //3;// pointer width stack addresses, log2 fcn = no. bits to represent addr for all values in stack

output [stack_width -1 : 0]     Data_out;
output    						     stack_empty, stack_full;
output    					     	  stack_almost_empty, stack_almost_full;
input  [stack_width -1 : 0]     Data_in;
input								     write_to_stack, read_from_stack;
input								     clk, rst;

// Pointers for reading and writing
reg  [stack_ptr_width -1 : 0]  read_ptr, write_ptr;
reg  [stack_ptr_width    : 0]  ptr_diff; //pointer difference
reg  [stack_width -1 : 0]      Data_out; //declaring as output register
reg  [stack_width -1 : 0]      stack [stack_height -1 : 0]; // memory array

/*assign stack_empty = (ptr_diff == 0) ? 1 : 0; //1’b1 : 1’b0; //single bit setup
assign stack_full  = (ptr_diff == stack_height) ? 1 : 0; //1’b1 : 1’b0;*/

assign stack_empty = (ptr_diff == 0) ? 1 : 0; //stack fullness indicators
assign stack_full  = (ptr_diff == stack_height) ? 1 : 0;
assign stack_almost_empty = (ptr_diff == 1) ? 1 : 0;
assign stack_almost_full  = (ptr_diff == stack_height-1) ? 1 : 0;

always @ (posedge clk or posedge rst)     
begin
if (rst) begin 
     Data_out  <= 0; // reset output and pointers to zero
     read_ptr  <= 0;
     write_ptr <= 0;
     ptr_diff  <= 0;
end

else  begin
       if ( (read_from_stack) && (!stack_empty) ) //prioritize reading over writing
           begin  Data_out  <= stack [read_ptr];//send stack to data_out
                  read_ptr  <= read_ptr + 1;    // incr read pointer
						ptr_diff  <= ptr_diff - 1;    // decr pointer diff
			  end
       else if  ( (write_to_stack) && (!stack_full) )
           begin  stack [write_ptr] <= Data_in; //send stack to data_in
                  write_ptr         <= write_ptr + 1;// incr write pointer
                  ptr_diff          <= ptr_diff + 1; // incr pointer diff 
			  end
    end
end
endmodule