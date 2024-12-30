/*----------------------Testbench module------------------------------------------------------------------*/

module DataOutput_file_tb ();

parameter					width = 4;
reg							clk, reset;
wire		[width-1:0]		out;
reg			[width-1:0]		counter[13:0];

integer		f,i;

//instantiate the UUT
DataOutput_file	UUT (clk, reset, out);

always	#5	clk = ~clk;

//clock and reset release
initial
	begin
		clk = 0;  reset = 1;					//clock low at time zero
		@(posedge clk);
		@(posedge clk);
		reset = 0;
	end
	
//instantiate opening of the txt file using $fopen
initial
	begin
		f = $fopen ("output.txt", "w");
		
		@(negedge reset);						//wait for reset to be released
		@(posedge clk);							//wait for first clock out of the reset
		
		for (i=0; i<14; i = i+1)
			begin
				@(posedge clk);
					counter[i] <= out;
					$display("counter %b", out);
					$fwrite(f, "%d	%d\n", i, out);
			end
			
			$fclose(f);
			$finish;
	end
endmodule