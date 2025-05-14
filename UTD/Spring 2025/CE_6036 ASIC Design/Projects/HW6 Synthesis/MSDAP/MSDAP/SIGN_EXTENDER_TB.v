`timescale 1ns / 1ps

module SignExtender_tb;

  reg  [15:0] DATAIN;
  wire [23:0] DATAOUT;

  // Instantiate the DUT
  SignExtender UUT (
    .DATAIN(DATAIN),
    .DATAOUT(DATAOUT)
  );

  // Test vector procedure
  initial begin
    $display("Starting SignExtender Testbench...");
    $monitor("Time=%0t | DATAIN=0x%h | DATAOUT=0x%h",
              $time, DATAIN, DATAOUT);

    // Test cases
    DATAIN = 16'h12A4; #10; // Left=4BC8, Right=12A4
    DATAIN = 16'h368C; #10; // Left=910F, Right=368C
    DATAIN = 16'hAFB9; #10; // Left=1EDD, Right=AFB9
    DATAIN = 16'h8000; #10; // Edge case: both halves MSB=1
    DATAIN = 16'h7FFF; #10; // Edge case: both halves MSB=0
    DATAIN = 16'h0000; #10; // Left=-1, Right=0
    DATAIN = 16'hFFFF; #10; // Left=0, Right=-1
    DATAIN = 16'hABCD; #10; // Random example
    DATAIN = 16'hD3F2; #10;

    $display("Testbench finished.");
    #10 $finish;
  end

endmodule

