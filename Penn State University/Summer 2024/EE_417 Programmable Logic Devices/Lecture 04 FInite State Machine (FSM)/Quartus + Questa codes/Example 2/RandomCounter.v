/*____________________________________________________________________________________
Random Counter:
---------------
if the reset should display a count of 3'b001. If the reset is inactive and the
counter is enabled and the mode is 0, the counting sequence should be:
1 7 3 5 1 7 3 5 ... and so on.
if the counter is enabled and the mode is 1, the counting sequence should be:
1 5 3 7 1 5 3 7 ... and so on.
if the counter is not reset but the enable is not high then the counter should 
hold the last value it has reach.
This counter is synchronized by a clock. The reset and the enable are also
synchronized, meaning that their efect will only be applied at a positive clock edge.
the counter should be designed using a Moore FSM.
______________________________________________________________________________________*/

module RandomCounter (count, clk, reset, enable, mode);

output reg [2:0] count;
input			 clk, reset, enable, mode;

//intermediate the prodes or internal designed
reg [1:0] state, next_state;

//parameter for the designe
parameter	ONE		= 2'b00;
parameter	SEVEN	= 2'b01;
parameter	THREE	= 2'b10;
parameter	FIVE	= 2'b11;

//Sequence logic:
always @ (posedge clk)
	if (reset) state <= ONE;
		else   state <= next_state;
		
//combinational logic to find the next_state based on the inputs and the current state:
always @ *
case (state)
	ONE:	 if (enable & ~mode) next_state = SEVEN;		    //1 7 3 5 1 7 3 5
		else if (enable & ~mode) next_state = FIVE;			 //1 5 3 7 1 5 3 7
		else	 				next_state = ONE;                //hold
		
	SEVEN:   if (enable & ~mode) next_state = THREE;	   //1 7 3 5 1 7 3 5
	    else if (enable & ~mode) next_state = ONE;        //1 5 3 7 1 5 3 7
		else					 next_state = SEVEN;             //hold
		
	THREE:   if (enable & ~mode) next_state = FIVE;       //1 7 3 5 1 7 3 5
		else if (enable & ~mode) next_state = SEVEN;       //1 5 3 7 1 5 3 7
		else                     next_state = THREE;      //hold
		
	FIVE:    if (enable & ~mode) next_state = ONE;		  //1 7 3 5 1 7 3 5
		else if (enable & ~mode) next_state = THREE;     //1 5 3 7 1 5 3 7
		else                     next_state = FIVE;      // hold
		
	default: next_state = ONE;		//assumed to be the starting and reset case.
	endcase
	
//combination logic to determine the output based on the current state:
always @ (state)
case (state)
	ONE		: count = 3'b001;
	SEVEN	: count = 3'b111;
	THREE	: count = 3'b011;
	FIVE	: count = 3'b101;
	default : count = 3'b000;	//invalid output
	
	endcase
	
endmodule