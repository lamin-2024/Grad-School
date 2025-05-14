`timescale 1ns / 1ps

module SignExtender_tb;

  reg  [31:0] datain;
  wire [23:0] sign_out_L;
  wire [23:0] sign_out_R;

  // Instantiate the DUT
  SignExtender UUT (
    .datain(datain),
    .sign_out_L(sign_out_L),
    .sign_out_R(sign_out_R)
  );

  // Test vector procedure
  initial begin
    $display("Starting SignExtender Testbench...");
    $monitor("Time=%0t | datain=0x%h | sign_out_L=0x%h | sign_out_R=0x%h",
              $time, datain, sign_out_L, sign_out_R);

    // Test cases
    datain = 32'h4BC812A4; #10; // Left=4BC8, Right=12A4
    datain = 32'h910F368C; #10; // Left=910F, Right=368C
    datain = 32'h1EDDAFB9; #10; // Left=1EDD, Right=AFB9
    datain = 32'h80000000; #10; // Edge case: both halves MSB=1
    datain = 32'h7FFF7FFF; #10; // Edge case: both halves MSB=0
    datain = 32'hFFFF0000; #10; // Left=-1, Right=0
    datain = 32'h0000FFFF; #10; // Left=0, Right=-1
    datain = 32'h1234ABCD; #10; // Random example

    $display("Testbench finished.");
    #10 $finish;
  end

endmodule
