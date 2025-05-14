`timescale 1ns / 1ps

module ShiftRightRegister_tb;

  // Inputs
  reg clk, reset, load;
  reg [23:0] adder_outL, adder_outR;

  // Outputs
  wire [39:0] shift_outL, shift_outR;
  wire done_shifting;

  // Instantiate DUT
  ShiftRightRegister UUT (
    .clk(clk),
    .reset(reset),
    .load(load),
    .adder_outL(adder_outL),
    .adder_outR(adder_outR),
    .shift_outL(shift_outL),
    .shift_outR(shift_outR),
    .done_shifting(done_shifting)
  );

  // Clock generator
  always #5 clk = ~clk;  // 10 ns clock period

  initial begin
    // Initialize signals
    clk = 0;
    reset = 1;
    load = 0;
    adder_outL = 24'hABCDE0;
    adder_outR = 24'h123450;

    // Reset pulse
    #10 reset = 0;

    // Load input values
    #10 load = 1;
    #10 load = 0;  // Clear load signal

    // Wait for done_shifting
    wait (done_shifting);
    $display("Shifting done at time %0t", $time);
    $display("Final shift_outL = 0x%h", shift_outL);
    $display("Final shift_outR = 0x%h", shift_outR);

    #20 $finish;
  end

  // Monitor progress
  initial begin
    $monitor("T=%0t | load=%b | done=%b | shift_outL=0x%h | shift_outR=0x%h",
             $time, load, done_shifting, shift_outL, shift_outR);
  end

endmodule
