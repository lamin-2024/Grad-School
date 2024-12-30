
module FIFO_tb ();
parameter FIFO_width  = 16;							//width of stack and  data paths
parameter FIFO_height = 4;							//height of stack (# of words)
parameter ptr_width   = 2;							//width of pointer to address stack

//define registers and wires for the testbench
wire		[FIFO_width -1:0]		Data_out;
wire									empty, full;
reg		[FIFO_width -1:0]		Data_in;
reg									clk, rst;
reg									wr_enable, rd_enable;

//internal probes
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
		clk 		   = 0;
		rst 		   = 1;
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
		#40   rst		 = 1'b0;
		#50   Data_in	 = 16'hFF01;
		#60	rd_enable = 1'b1;
		#80   rd_enable = 1'b0;
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