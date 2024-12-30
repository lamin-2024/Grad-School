/*--------------------------------------------------------------------------
The top module, if enable, should accumulate sets of 4 consecutive samples.
if the module is not enable, it should just hold the last value it has 
reached. If the module is reset it will output zero.

After the hold is removed the controller will load a new sample as the first 
value in the 4 samples to accumulate.
----------------------------------------------------------------------------*/

module integrator_DataPath_controller #(parameter word_size = 3) (
		output		[word_size+1:0] data_out,
		input 		[word_size-1:0] data_in,
		input						clock, reset, enable);
		
wire hold, buffer, RESET;

//instantiation of the dataPath module
integrator dataPath (
					 .data_out (data_out),			//output port
					 .data_in  (data_in),			//input port
					 .hold	   (hold),				//internal input
					 .clock    (clock),				//input port 
					 .reset    (RESET),             //input reset
					 .buffer   (buffer)             //internal input
					 );
					 
controller control_unit (
						 .hold     (hold),			 //internal output
						 .buffer   (buffer),		 //internal output
						 .RESET    (RESET),			 //internal output
						 .enable   (enable),		 //input port
						 .clock    (clock),          //input port
						 .reset    (reset)           //input port
						 );
endmodule