/*----------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 09 HW Question 2 
Group: Ron Kalin/ Lamin Jammeh
Project Description: This module is Differentiator, it finds the difference between
adjacent sample
-------------------------------------------------------------------------------------*/

module Differentiator #(parameter word_size = 8) 
							  (
 							   output  [word_size-1:0] Data_out,
							   input   [word_size-1:0] Data_in,
                        input                  hold, clock, reset
				  			  );

// Internal registers and wires
reg [word_size-1:0] buffer; // Internal register for buffer

// Assign the formula for Data_out
assign Data_out = Data_in - buffer;

always @(posedge clock)
	begin
		if (reset)
			/*---------------------------------------------------------------------------------------------------
			@ high reset the following will occur
			** buffer goes to zero
			** Data_in will keep its value since it is an external input but the buffer will remain zero
			** Data_out will still be [Data_in - buffer] but since buffer is zero therefore Data_out will be Data_in
			** This Means that no filtering is occurring at high reset
			-----------------------------------------------------------------------------------------------------*/
			
          buffer <= 0; // When reset is high, and clock is rising, buffer <= 0
      else if (hold)
			/*-----------------------------------------------
			@ low rest and hold = 1 the following will happen
			**buffer Keeps it current value
			** Data_in is not transfered to buffer
			** Data_out is still equal to [Data_in - buffer] but 
			** therefore @ hold = 1 the buffer is not updated
			-------------------------------------------------*/
          buffer <= buffer; // When hold is high, reset is low, and clock is rising, buffer remains unchanged
      else
			 /*-------------------------------------------------------------
			 @ hold = 0 and reset = 0 the following will occur
			 ** buffer will store the previous Data_in value
			 ** Data_out will be (Data_in - buffer)
			 ** therefore the buffer is update when hold is low and reset is low 
			 -------------------------------------------------------------------*/
          buffer <= Data_in; // When hold is low, reset is low, and clock is rising, buffer <= Data_in
   end

endmodule