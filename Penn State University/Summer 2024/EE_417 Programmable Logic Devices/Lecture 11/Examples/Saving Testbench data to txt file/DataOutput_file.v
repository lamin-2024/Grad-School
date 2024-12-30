/*-------------------Saving testbench data to a text file to access using Matlab--------------------*/

module	DataOutput_file (clk, reset, out);

parameter					width = 4;
input						clk, reset;
output		reg	[width-1:0]	out;

always	@ (posedge clk)
	begin
		if (reset)
			out <= 0;
		else 
			out <= out + 1;
	end
endmodule
