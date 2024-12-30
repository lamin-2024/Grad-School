/*----------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 07 HW Question 2
Group: Ron Kalin/ Lamin Jammeh
Project Description: This module combines submodule DataPath and Controller to perform 
the shift functions. It is the top module for the design
-------------------------------------------------------------------------------------*/

/*-----------------------up/down counter-----------------------*/
module DataPath_controller #(parameter WIDTH = 8, parameter CYCLES = 18) (
    input clk,
    input reset,
	 input  [WIDTH-1:0] data_in,
    output [WIDTH-1:0] count
);

wire shift_left, shift_right, load, done;

DataPath #(WIDTH, CYCLES) datapath (
    .clk(clk),
    .reset(reset),
    .shift_left(shift_left),
    .shift_right(shift_right),
    .load(load),
	 .data_in(data_in),
    .count(count),
    .done(done)
);

Controller controller (
    .clk(clk),
    .reset(reset),
    .done(done),
    .shift_left(shift_left),
    .shift_right(shift_right),
    .load(load)
);

endmodule
