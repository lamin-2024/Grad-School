/*---------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 04 HW Question 4 Part 2
Group: Ron Kalin/ Lamin Jammeh
Project Description: This portion takes use the output of the code2421_downCounter
and inverts it to form an up counter. this is possible because of the complementary
characteristics of 2421 code
------------------------------------------------------------------------------------*/

//define the input as the output of the downCounter and the assign and output
// note the system is already initialize from the code2421_downCounter block
//define the output as wire since the upcount block is intermediate to enable assignment operation
module code2421_upCounter (output wire [3:0] upcount,
									input clk,
									input reset,
									input enable
									);
									
wire  [3:0]  	count;

//call the file for the code2421_downCounter
code2421_downCounter UDM_downCount(
											  .count(count),
											  .clk(clk),
											  .reset(reset),
											  .enable(enable)
											  );
									
//assign a function to the output of the upcounter
assign upcount = ~count; 

endmodule