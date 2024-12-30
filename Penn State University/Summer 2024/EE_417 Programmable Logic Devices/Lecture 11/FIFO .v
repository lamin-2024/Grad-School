/*---------------FIFO Main code------------------------------------------*/

module FIFO (Data_out,						//Data path from FIFO
			 empty,							//Flag asserted high for empty stack
			 full,  						//Flag asserted high for full stack
			 Data_in,						//Data path into FIFO 
			 wr_enable,						//input controlling a write to FIFO memory stack
			 rd_enable,						//input controlling a read to stack
			 clk,
			 rst
			 );
			 
parameter	FIFO_width  = 16;				//width of stack and Data path
parameter	FIFO_height = 4;				//height of stack (# of words)
parameter	ptr_width	= 2;				//width of read and write pointers to address the FIFO words 

output	reg [FIFO_width -1: 0]		Data_out;
output								empty, full;
input		[FIFO_width -1: 0]		Data_in;
input								clk, rst;
input								wr_enable, rd_enable;

// Pointers for reading and writing 
reg		[ptr_width -1: 0]	read_ptr, write_ptr;
reg		[ptr_width -1: 0]	ptr_diff;

//memory FIFO register
reg		[FIFO_width -1: 0] FIFO_Mem	[FIFO_height -1:0];		//memory array

// empty and full flags
assign		empty = (ptr_diff == 0)			  ? 1'b1 : 1'b0;
assign		full  = (ptr_diff == FIFO_height) ? 1'b1 : 1'b0;

always	@(posedge clk or posedge rst)
	begin
		if (rst)
			begin
				Data_out	<= 0;
				read_ptr	<= 0;
				write_ptr   <= 0;
				ptr_diff	<= 0;
			end
		else if ((rd_enable) && (!empty))		//read request and FIFO not empty
			begin
				Data_out	<= FIFO_Mem [read_ptr];
				read_ptr	<= read_ptr + 1;
				ptr_diff	<= ptr_diff - 1;
			end 
		else if ((wr_enable) && (!full))		//write request and FIFO not full
			begin
				FIFO_Mem	[write_ptr]		<= Data_in;
				write_ptr					<= write_ptr + 1;
				ptr_diff					<= ptr_diff + 1;
			end 
	end 
endmodule



/*---------------------------FIFO testbench----------------------------------*/

module FIFO_tb ();
parameter FIFO_width  = 16;							//width of stack and  data paths
parameter FIFO_height = 4;							//height of stack (# of words)
parameter ptr_width   = 2;							//width of pointer to address stack

wire	[FIFO_width -1: 0]	fifo_0, fifo_1, fifo_2, fifo_3;

//define the unit under test UUT
FIFO	UUT		(Data_out, empty, full, Data_in, wr_enable, rd_enable, clk, rst);

//monitor each slot in the memory 
assign	fifo_0	= UUT.FIFO_Mem [0];
assign	fifo_1	= UUT.FIFO_Mem [2];
assign	fifo_2	= UUT.FIFO_Mem [2];
assign	fifo_3	= UUT.FIFO_Mem [3];

initial 	
	begin
		clk 		= 0;
		rst 		= 1;
		rd_enable 	= 0;
		wr_enable	= 0;
		Data_in		= 16'h1111;
		#350	$stop;
	end 
	
//instantiate the clock signal
initial
	begin
		forever 
		#5 clk = ~clk;
	end
	
//simulate the different test scenarios
initial
	fork
		#40   rst		= 1'b0;
		#50	  Data_in	= 16'hFF01;
		#60	  rd_enable = 1'b1;
		#80	  rd_enable = 1'b0;
		#100  wr_enable = 1'b1;
		#110  Data_in   = 16'h539E;
		#120  wr_enable = 1'b0;
		#130  rd_enable = 1'b1;
		#140  rd_enable = 1'b0;
		#150  Data_in   = 16'h1100;
		#160  wr_enable = 1'b1;
		#170  Data_in   = 16'hABCD;
		#180  Data_in   = 16'h2222;
		#200  Data_in   = 16'h5050;
		#240  wr_enable = 1'b0;
		#260  rd_enable = 1'b1;
	join
endmodule