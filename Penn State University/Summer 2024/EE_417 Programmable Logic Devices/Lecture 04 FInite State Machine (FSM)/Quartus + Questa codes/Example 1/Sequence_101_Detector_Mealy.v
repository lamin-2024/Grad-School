/*________________________________________________________________________________________
This Module receives a single bit input x_in. Whenever x_in performs a sequence 101
the z_out flag is raised high indicating that 101 was detected. The sequences can be 
over;apping. The design is performed using a Mealy FSM.
The explanantion of the FSM state diagram is given in video 2 of the class lecture
__________________________________________________________________________________________*/

module Sequence_101_Detector_Mealy (z_out, clk, reset, x_in);
//define the inputs and outputs
output reg z_out;
input      clk, reset;
input      x_in;

//define the states
reg [1:0] state, next_state;

//define the posible parameter and their bit values example [snone = 0 0, s1 = 0 1, and s10 = 1 0]
parameter snone = 2'b00;      //None of the correct sequence bits received
parameter s1    = 2'b01;     //A 1 was received
parameter s10   = 2'b10;     //A 10 sequence was received

//sequenctial logic (flip flop) updating the state register
always @ (posedge clk)							//trigger or check at positive clk cycle
	if (reset) state <= snone;					//reset if state is snone
	else       state <= next_state;			//check next_state if state is not snone
	
//combinational logic determining the next_state and the output
always @ *
	case (state)
	
	//case for snone
	snone		: begin z_out = 1'b0;
						if (x_in) next_state = s1;				//if input x_in=1 then output=0 and move to the next state (s1)
						else       next_state = snone;		//if input x_in=0 then output=0 and move to the snone
				  end
	
	//case for s1
	s1 		: begin z_out = 1'b0;
						if (x_in) next_state = s1;				//if input x_in=1 then output=0 and move to the next state (s1)
						else       next_state = s10;			//if input x_in=0 then output=0 and move to the next_state (s10)
				  end
				  
	//case for s10
	s10		: begin 
						if (x_in) 
							begin z_out = 1'b1; 
								next_state = s1;					//if input x_in=1 then output=1 and move to the next state (s1)
							end
						else  
							begin z_out = 1'b0; 					
								next_state = snone;				//if input x_in=0 then output=0 and move to the back to snone
							end
				  end
				  
	//default takes you to snone
	default  : begin z_out = 1'b0;
						next_state = snone;
				  end
	endcase
	
	endmodule