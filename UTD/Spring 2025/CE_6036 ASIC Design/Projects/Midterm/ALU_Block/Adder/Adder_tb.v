`timescale 1ns / 1ps

module Adder_tb;

  // Inputs
  reg signed [23:0] dataout_L, shift_outL;
  reg signed [23:0] dataout_R, shift_outR;
  reg add_sub_L, add_sub_R;

  // Outputs
  wire signed [23:0] adder_outL, adder_outR;

  // Instantiate DUT
  Adder UUT (
    .dataout_L(dataout_L),
    .shift_outL(shift_outL),
    .add_sub_L(add_sub_L),
    .adder_outL(adder_outL),

    .dataout_R(dataout_R),
    .shift_outR(shift_outR),
    .add_sub_R(add_sub_R),
    .adder_outR(adder_outR)
  );

  initial begin
    $display("Starting Adder Testbench...");
    $monitor("Time=%0t | L: %0d %s %0d = %0d | R: %0d %s %0d = %0d", 
              $time, 
              shift_outL, add_sub_L ? "-" : "+", dataout_L, adder_outL,
              shift_outR, add_sub_R ? "-" : "+", dataout_R, adder_outR);

    // Test Case 1: Add both sides
    shift_outL = 24'sd100;
    dataout_L  = 24'sd25;
    add_sub_L  = 0;

    shift_outR = 24'sd200;
    dataout_R  = 24'sd50;
    add_sub_R  = 0;
    #10;

    // Test Case 2: Subtract both sides
    add_sub_L = 1;
    add_sub_R = 1;
    #10;

    // Test Case 3: Negative operands
    shift_outL = -24'sd100;
    dataout_L  =  24'sd50;
    add_sub_L  = 0;

    shift_outR = -24'sd80;
    dataout_R  = -24'sd20;
    add_sub_R  = 0;
    #10;

    // Test Case 4: Subtract with negatives
    add_sub_L = 1;
    add_sub_R = 1;
    #10;

    // Test Case 5: Max and min values
    shift_outL = 24'sh7FFFFF; // Max positive
    dataout_L  = 24'sh800000; // Min negative
    add_sub_L  = 0;

    shift_outR = 24'sh800000;
    dataout_R  = 24'sh7FFFFF;
    add_sub_R  = 1;
    #10;

    $display("Testbench finished.");
    #10 $finish;
  end

endmodule
