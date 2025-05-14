module ShiftRightRegister (
    input  wire        clk,
    input  wire        reset,
    input  wire        load,
    input  wire [23:0] adder_outL,
    input  wire [23:0] adder_outR,
    output reg  [39:0] shift_outL,
    output reg  [39:0] shift_outR,
    output reg         done_shifting
);

    reg [5:0] shift_count;
    reg       shifting;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_outL     <= 40'd0;
            shift_outR     <= 40'd0;
            shift_count    <= 6'd0;
            shifting       <= 1'b0;
            done_shifting  <= 1'b0;
        end else begin
            done_shifting <= 1'b0;

            if (load) begin
                shift_outL[39:16] <= adder_outL;
                shift_outL[15:0]  <= 16'd0;
                shift_outR[39:16] <= adder_outR;
                shift_outR[15:0]  <= 16'd0;
                shift_count       <= 6'd0;
                shifting          <= 1'b1;
            end else if (shifting) begin
                shift_outL <= {1'b0, shift_outL[39:1]};
                shift_outR <= {1'b0, shift_outR[39:1]};
                shift_count <= shift_count + 1;

                if (shift_count == 6'd31) begin
                    shifting      <= 1'b0;
                    done_shifting <= 1'b1;
                end
            end
        end
    end

endmodule



//Testbench for the ShiftRightRegister
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
