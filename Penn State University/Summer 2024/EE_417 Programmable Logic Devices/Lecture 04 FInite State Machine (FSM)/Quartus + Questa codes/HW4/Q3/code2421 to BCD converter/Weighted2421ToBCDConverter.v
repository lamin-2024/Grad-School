/*---------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 04 HW Question 4 Part 4
Group: Ron Kalin/ Lamin Jammeh
Project Description: This portion takes the code2421 and convert it to BCD conter
------------------------------------------------------------------------------------*/
// Weighted 2421 to BCD Converter	
module Weighted2421ToBCDConverter (	
 input [3:0] weighted2421, // Input in weighted 2421 format	
 output reg [3:0] bcd ); // output in BCD format	
	
    always @ (weighted2421)	 //put input only in sesitivity list
       case (weighted2421)	
            4'b0000: bcd = 4'b0000; // 0	
            4'b0001: bcd = 4'b0001; // 1	
            4'b0010: bcd = 4'b0010; // 2	
            4'b0011: bcd = 4'b0011; // 3	
            4'b0100: bcd = 4'b0100; // 4	
            4'b1011: bcd = 4'b0101; // 5	
            4'b1100: bcd = 4'b0110; // 6	
            4'b1101: bcd = 4'b0111; // 7	
            4'b1110: bcd = 4'b1000; // 8	
            4'b1111: bcd = 4'b1001; // 9	
            default: bcd = 4'b1111; // Default to unique value so invalid input code can be recognized	
        endcase	
// Alternative description is given below	
//assign bcd = (weighted2421 < 5) ? weighted2421 : weighted2421 - 6;	
endmodule	