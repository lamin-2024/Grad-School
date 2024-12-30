/*----------------------------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 12 HW Question 1
Group: Ron Kalin/ Lamin Jammeh
Project Description: Simple Timing analysis using an Synopsus Design Constraint ((SDC) file in Quartus
the circuit is run by a single clock name clock which has timing cntraints change from 1ns to 4ns
-----------------------------------------------------------------------------------------------------*/

module add_three_numbers (clock, A, B, C, sum);

//define the inputs and outputs
input				clock;
input	[7:0]		A, B, C;
output	[9:0]		sum;

//define the internal registers
reg		[7:0]		reg_A, reg_B, reg_C;		//synthesis keep
reg		[9:0]		reg_sum;					//synthesis keep

//combination logics
always @(posedge clock)
	begin
		reg_A	<= A;
		reg_B	<= B;
		reg_C	<= C;
		reg_sum	<= reg_A + reg_B + reg_C;
	end
	
//assign the reg_sum to the output
assign		sum = reg_sum;
endmodule