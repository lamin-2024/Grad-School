/*-------------------RAM_one clk-----------------------------------------------------------------------------------------------*/

module RAM_ONE_clk	(
					 input			clk,		//one clk for read and write
					 input	[5:0]	address,	//one address for read and write	(log2(memory depth) log2(64) = 6
					 input			mem_read,	//read enable
					 input			mem_write,	//write enable
					 input	[15:0]	data_in,
					 output	[15:0]	data_out
					);

//internaal register
reg		[15:0]	memory [63:0];					//the memory has a depth of 64 words (addresses from 0 to 63) with data size of 16

//Transition logic
always	@(posedge clk)
	if(mem_write)
		memory[address] <= data_in;				//synchronized write
		
assign data_out = (mem_read == 1'b1) ? memory[address]: 16'd0;		//combinational logic for data_out
endmodule



/*--------------------------------------------------------------RAM_clear-----------------------------------------------------------*/

module RAM_clear	(
					 input				clk,				//one clk for read and write
					 input		[5:0]	address,			//(log2(memory depth) log2(64) = 6
					 input				read_or_write,		//read enable
					 input				clear,				//clear memory
					 input		[15:0]	data_in,
					 output	reg	[15:0]	data_out
					);

//internaal register
reg		[15:0]	memory [63:0];					//the memory has a depth of 64 words (addresses from 0 to 63) with data size of 16
integer k;
					
//Transition logic
always	@(posedge clk)
	if (clear)
		for (k = 0; k < 64; k = k+1)
			memory[k] <= 16'd0,
	else if (read_or_write)
			memory[address] <= data_in;		//priority to write if we recieve both read and write signal at the same time 
	else if (~read_or_write)
			data_out		<= memory[address];
endmodule