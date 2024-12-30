/*----------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 07 HW Question 2
Group: Ron Kalin/ Lamin Jammeh
Project Description: This is testbench shows the outputs and how the value 1 is shifting 
-------------------------------------------------------------------------------------*/

/*-----------------------TestBench for up/down count---------------*/
module DataPath_controller_tb ();

//define registers and wires
reg clk;
reg reset;
reg  [7:0] data_in;
wire [7:0] count;
wire shift_left;
wire shift_right;

//define the units under test UUT
DataPath_controller #(8, 18) UUT (
														.clk(clk),
														.reset(reset),
														.data_in(data_in),
														.count(count)
														);

//monitor internal probe
assign count_up   = UUT.controller.shift_left;
assign count_down = UUT.controller.shift_right;														
//clock cycle
initial 
	begin
		clk = 0;
		forever #10 clk = ~clk;
	end
	
//count output is base on posedge of clk and reset
//initialie reset and run enough clk cycle to get all desired counts
initial	
	begin
		reset = 1;
		data_in = 8'b00000001;  //load initial value
		#10 reset = 0; 
		#800 $stop; 			//run clk for 100 time units change if necessary
	end
	
//display results for each change in count
initial
	begin
		$monitor ("Time: %0t	|	Count_up: %b |	Count_down: %b	|	count: %b", $time, count_up, count_down, count);
	end
endmodule