// Design: Lesson 4A2b: 4-BIT JERKY COUNTER
//Group: Lamin Jammeh/Ron Kalin
//-----------------------------------------------------------------------------   											
module FourBitJerkyCounterb(output reg [7:0] count,						
                           input clk,						
                           input rst );
									//Declare outputs: 8bit count, inputs: clock, reset					
// Define the states						
reg [3:0] state, next_state;						
						
// State transitions						
 always @(posedge clk or posedge rst)					
    if (rst)  state <= 4'b0000; //sequential logic: flip flop, Initialize to state 0											
          else state <= next_state; //if reset is high, reset, else.. count
	 
    always @ *	   //combinational logic: from state table given
        case (state)						
            0: begin // State 0						
                next_state=1;						
                count =128;						
              end						
            1: begin // State 1						
                next_state=2;						
                count =64;						
              end						
	         2: begin // State 2	
                next_state=3;						
                count =128;						
              end						
	         3: begin // State 3	
                next_state=4;						
                count =32;						
              end						
	         4: begin // State 4	
                next_state=5;						
                count =128;						
              end						
	         5: begin // State 5	
                next_state=6;						
                count =16;						
              end						
		      6: begin // State 6	
				     next_state=7;	
                 count =128;						
              end						
		      7: begin // State 7	
                 next_state=8;						
                 count =8;						
              end						
		      8: begin // State 8	
                 next_state=9;						
                 count =128;						
              end						
		      9: begin // State 9	
                 next_state=10;						
                 count =4;						
              end						
			   10: begin // State 10	
                 next_state=11;						
                 count =128;						
              end						
		      11: begin // State 11	
                 next_state=12;						
                 count =2;						
              end						
		      12: begin // State 12	
                 next_state=13;						
                 count =128;						
              end						
	         13: begin // State 13	
                 next_state=0;						
                 count =1;						
              end						
	         default: next_state <= 0;	
         endcase	
						
endmodule						
