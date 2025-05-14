/*********************************************************************************************
Name: Lamin Jammeh and Caleb Perez
Class: CE6306 ASIC Design
HW1 Part 2 Main Module
Description: Create a Verilog code for a 2 input full adder using the behavioral defination
Full Adder will have a SUM and Carry_out
Sum   = A ^ B ^ C_in
C_out = (A & B) | (A & C_in) | (B & C_in) C_out is the majority function
*********************************************************************************************/

//Step1: define the top module and the ports
module full_adder(
				  input A,
                  input B,
                  input C_in,
                  output reg Sum,
                  output reg C_out
                 );

//use an always block to check a change in any of the inputs (@*) and compute the out using blocking assignments
always @* begin
	    Sum   = A ^ B ^ C_in;										 // use a 3-input XOR (^) for the SUM A, B, and C_in
        C_out = (A & B) | (A & C_in) | (B & C_in); 				//  use AND and OR gates for the carry out
	end
endmodule