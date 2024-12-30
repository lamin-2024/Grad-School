module controller (
		output reg 		hold,			//internal output
		output reg		buffer,		    //internal output
		output reg 		RESET, 			//internal output
		input			enable,         //input port
		input           clock,          //input port
		input           reset);			//input port
		
reg [2:0] state, next_state;

parameter	S_rst	= 3'b000;			//resets the data_out and the integrator
parameter	S_load	= 3'b001;			//enables loading the data_in onto the data_out
parameter   S_acc1  = 3'b010;			//Accumulates 2 samples
parameter	S_acc2  = 3'b011;			//Accumulates 3 samples
parameter	S_acc3  = 3'b100;           //Accumulates 4 samples
parameter	S_hold  = 3'b101;           //holds the last value reached at the output

always @ (posedge clock)
	if (reset) state <= S_rst;
	else 	   state <= next_state;
	
always @ *
	begin
		RESET  = 1'b0;			//default value is a zero unless change of state
		buffer = 1'b0;			//We could also list all the outputs every state
		hold   = 1'b0;			//Same effect
			case (state)
				S_rst:	begin
						RESET = 1'b1;
						if (enable) next_state = S_load;
							else	next_state = S_hold;
						end
				S_load:	begin
						buffer = 1'b1;
						if (enable) next_state = S_acc1;
							else	next_state = S_hold;
						end
				S_acc1:	begin
						if (enable) next_state = S_acc2;
							else	next_state = S_hold;
						end
				S_acc2:	begin
						if (enable) next_state = S_acc3;
							else	next_state = S_hold;
						end
				S_acc3:	begin
						if (enable) next_state = S_load;
							else	next_state = S_hold;
						end
				S_hold:	begin
						hold = 1'b1;
						if (enable) next_state = S_load;
							else	next_state = S_hold;
						end
				default:  begin
						  RESET = 1'b1;					//reset the output as the default case
						  next_state = S_rst;			//reset the FSM
						  end
			endcase
	end
endmodule