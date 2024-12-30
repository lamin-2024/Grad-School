/*--------Look-up table to find next_state and output value for a FSM-------------------*/

module ROM_FSM (clk, reset, z_out, x_in);

//define input and output
input			clk, reset, x_in;
output	reg		z_out;

//internal layout and registers
reg		[1:0]	state;
wire	[1:0]	next_state;
wire	[2:0]	address, data_out;

always	@ (posedge clk)
	if (reset) 
		begin
			state <= 2'b00;
			z_out <= 1'b0;
		end 
	else
		begin
			state <= next_state;
			z_out <= z;
		end
		
//combinationa logic to find the next_state and z 
assign	address		= {state, x_in};				//if state=00 and x_in=1 then address=001
assign	next_state	= data_out [2:1];				// from above comment next_state=00
assign  z 			= data_out [0]					

//instantiate the lookUpTable 
ROM lookUpTable	(.address(address),
				 .data_out(data_out)
				 );
endmodule


/*---------------------------------------ROM module for the lookUpTable-----------------------*/

module	ROM (address, data_out);

//define input and output
input	[2:0]	address;
output	[2:0]	data_out;

//internal register
reg		[2:0]	ROM_reg		[7:0];

//define the content of each slot in the ROM_reg this can also be read from a text file 
initial
	begin
		ROM_reg [0] = 3'b000;
		ROM_reg [1] = 3'b010;
		ROM_reg [2] = 3'b100;
		ROM_reg [3] = 3'b010;
		ROM_reg [4] = 3'b110;
		ROM_reg [5] = 3'b010;
		ROM_reg [6] = 3'b001;
		ROM_reg [7] = 3'b010;
	end 
endmodule