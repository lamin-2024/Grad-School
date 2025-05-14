/*********************************************************************************************
Name: Lamin Jammeh and Caleb Perez
Class: CE6306 ASIC Design 
HW1 Part 1 Testbench
Description: Create a Verilog code for a 2 input full adder using the structural defination
Full Adder will have a SUM and Carry_out
Sum   = A ^ B ^ C_in
C_out = (A & B) | (A & C_in) | (B & C_in) C_out is the majority function
*********************************************************************************************/
`timescale 1ns/1ps

module full_adder_tb();

// Define the reg and wires
reg A;
reg B;
reg C_in;
wire C_out;
wire Sum; 

// Instantiate the unit under test
full_adder UUT(
    .A(A),
    .B(B),
    .C_in(C_in),
    .C_out(C_out),
    .Sum(Sum)
);

// Test the possible input sequence combination to form the different states
initial begin
    A = 1'b0; B = 1'b0; C_in = 1'b0; #10; // S_000 sequence
    A = 1'b0; B = 1'b0; C_in = 1'b1; #10; // S_001 sequence
    A = 1'b0; B = 1'b1; C_in = 1'b0; #10; // S_010 sequence
    A = 1'b0; B = 1'b1; C_in = 1'b1; #10; // S_011 sequence
    A = 1'b1; B = 1'b0; C_in = 1'b0; #10; // S_100 sequence
    A = 1'b1; B = 1'b0; C_in = 1'b1; #10; // S_101 sequence
    A = 1'b1; B = 1'b1; C_in = 1'b0; #10; // S_110 sequence
    A = 1'b1; B = 1'b1; C_in = 1'b1; #10; // S_111 sequence
    $stop;
end

// Monitor outputs
initial begin
  $display("Time     A    B    C_in    C_out    Sum");
  $monitor("%5t    %b    %b      %b       %b       %b", $time, A, B, C_in, C_out, Sum);
end

endmodule