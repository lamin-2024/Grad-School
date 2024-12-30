module integrator #(parameter word_size = 3) (
		output reg [word_size+1:0] data_out,
		input	   [word_size-1:0] data_in,
		input					   hold,
		input					   clock, reset,
		input					   buffer);
		
always @ (posedge clock)
	begin
		 if (reset)	 data_out <= 0;
	else if (buffer) data_out <= data_in;
	else if (hold)	 data_out <= data_out;
	else             data_out <= data_out + data_in;
	end
endmodule