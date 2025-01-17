/*---------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 04 HW Question 4 Part 3
Group: Ron Kalin/ Lamin Jammeh
Project Description: This portion takes uses a 2-to-1 MUX to select between up and down
counter. when the sel bit is high the upcounter output is transfered to the next stage
else the downcounter output is transfered to the next state
------------------------------------------------------------------------------------*/
//Step1: define the module and (port list)
	module selectorBlock_A (output reg [3:0] y, 
									input sel,
									input clk,
									input reset,
									input enable);
	
	wire [3:0] count;
	wire [3:0] upcount;
	
	//step 2 call the file for the code2421_downCounter
	code2421_downCounter UDM_downCount(
											  .count(count),
											  .clk(clk),
											  .reset(reset),
											  .enable(enable)
											  );
											  
	//call the file for the code2421_upCounter
	code2421_upCounter UDM_upCount(
											  .upcount(upcount),
											  .clk(clk),
											  .reset(reset),
											  .enable(enable)
											  );
	//Instantiate the wire and logic gates
	//note when sel is high we count up and when low we count down
	//equation for output of mux Y = (In_1 & sel) | (In_2 & ~sel)
	begin
		y = (upcount & sel) | (count & ~sel);
	end
	endmodule