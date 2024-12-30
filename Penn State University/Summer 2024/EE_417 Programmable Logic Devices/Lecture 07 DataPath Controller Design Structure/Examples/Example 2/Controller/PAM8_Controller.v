/*--------------------------PAM8_Controller-------------------------------------------*/
module PAM8_Controller (start, load, enable, reset, clock);

output reg	start, load;
input		enable, reset, clock;

reg [2:0]	state, next_state;

parameter	idle		= 3'b000;
parameter	starting	= 3'b100;
parameter	shift1		= 3'b001;
parameter	shift2		= 3'b010;
parameter	loading		= 3'b011;

always	@ (posedge clock)
	if (reset)	state <= idle;
		else	state <= next_state;
		
always	@ *
	case (state)
	idle	: begin
			  start = 1'b0;
			  load  = 1'b0;
			  if  (enable) next_state = starting;
					else  next_state = idle;
			  end
	starting: begin
				 start = 1'b1;					//The LSB of the first symbol is loaded
				 load  = 1'b0;					//The output remains 0
				 next_state = shift1;
			  end
	shift1	: begin
				 start = 1'b0;					//The second bit is received 
				 load  = 1'b0;
				 next_state = shift2;
			  end
	shift2	: begin 
				 start = 1'b0;					//The MSB is received
				 load  = 1'b0;
				 next_state = loading;
			  end
	loading  : begin								//The symbol is loaded to the output
				 start = 1'b0;					//And the next LSB is loaded
				 load  = 1'b1;
				 if (enable) next_state = shift1;
					else	 next_state = idle; 
			  end
	endcase
endmodule