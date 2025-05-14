`timescale 1ns / 1ps

module ADDER_TB;

  // Inputs
  reg signed [23:0] X1, X2;
  reg add_sub;

  // Outputs
  wire signed [23:0] Y;

  // Instantiate DUT
  ADDER UUT (
    .X1(X1),
    .X2(X2),
    .add_sub(add_sub),
    .Y(Y)
  );

  initial begin
    $display("Starting Adder Testbench...");
    $monitor("Time=%0t | Adder: %0d %s %0d = %0d", 
              $time, 
              X2, add_sub ? "-" : "+", X1, Y);

    // Test Case 1: Add both sides
    X2 = 24'sd100;
    X1  = 24'sd25;
    add_sub  = 0;

    #10;

    // Test Case 2: Subtract both sides
    add_sub = 1;
    #10;

    // Test Case 3: Negative operands
    X2 = -24'sd100;
    X1  =  24'sd50;
    add_sub  = 0;
    #10;

    // Test Case 4: Subtract with negatives
    add_sub = 1;
    #10;

    // Test Case 5: Max and min values
    X2 = 24'sh7FFFFF; // Max positive
    X1  = 24'sh800000; // Min negative
    add_sub  = 0;
    #10;

    X2 = 24'sh800000;
    X1  = 24'sh7FFFFF;
    add_sub  = 1;
    #10;

    $display("Testbench finished.");
    #10 $finish;
  end

endmodule

