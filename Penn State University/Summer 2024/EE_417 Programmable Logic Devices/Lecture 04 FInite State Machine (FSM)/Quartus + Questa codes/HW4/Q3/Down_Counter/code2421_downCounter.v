//ee417 //ee417 Lesson 4 Assignment 3 Part 1, L4A3P1
// Name: Ron Kalin  Date: 06-08-24  Group: Kalin/Jammeh
//code2421_down_counter using Moore FSM with case structure
module code2421_downCounter (output reg [3:0] count,
                             input clk,
                             input reset,
									  input enable);
//define the states									
reg [3:0] state, next_state;

//define parameters


//sequential logic
always @(posedge clk or posedge reset)
   if (reset)
         state <= 4'b1111;
   else if (enable) state<= next_state; //if reset high, reset, else..countdown
	
	always @ * //any variable changes, combinational logic from given state table
	  case (state)
	    0: begin //state 0
		     next_state =1;
		     count=4'b1111;
			end
	    1: begin //state 1
		     next_state =2;
		     count=4'b1110;
			end
	    2: begin //state 2
		     next_state =3;
		     count=4'b1101;
			end
	    3: begin //state 3
		     next_state =4;
		     count=4'b1100;
			end
	    4: begin //state 4
		     next_state =5;
		     count=4'b1011;
			end
	    5: begin //state 5
		     next_state =6;
		     count=4'b0100;
			end
	    6: begin //state 6
		     next_state =7;
		     count=4'b0011;
			end
	    7: begin //state 7
		     next_state =8;
		     count=4'b0010;
			end
	    8: begin //state 8
		     next_state =9;
		     count=4'b0001;
			end
	    9: begin //state 9
		     next_state =0;
		     count=4'b0000;
			end
  default: next_state <=0;
				//count=4'b1111;
    endcase
endmodule