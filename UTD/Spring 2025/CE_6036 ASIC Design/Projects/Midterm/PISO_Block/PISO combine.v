module PISO (
    input wire SCLK,                 // System clock
    input wire CLR,                  // Clear signal
    input wire LOAD,                 // Load 40-bit parallel word
    input wire EN,                   // Enable

    input wire [39:0] PDATAIN_L,     // 40-bit parallel input data - Left
    input wire [39:0] PDATAIN_R,     // 40-bit parallel input data - Right

    output reg DATAOUT_L,            // Serial output - Left (Single-bit output)
    output reg DATAOUT_R             // Serial output - Right (Single-bit output)
);

    reg [39:0] shift_reg_L;
    reg [39:0] shift_reg_R;
    reg [5:0] bit_cnt;

    always @(posedge SCLK or posedge CLR) begin
        if (CLR) begin
            shift_reg_L <= 40'b0;
            shift_reg_R <= 40'b0;
            bit_cnt <= 6'b0;
            DATAOUT_L <= 1'b0;
            DATAOUT_R <= 1'b0;
        end else if (LOAD) begin
            shift_reg_L <= PDATAIN_L;
            shift_reg_R <= PDATAIN_R;
            bit_cnt <= 6'b101000;   // 40 in decimal
        end else if (EN && bit_cnt != 0) begin
            DATAOUT_L <= shift_reg_L[39];  // Output MSB of the shift register
            DATAOUT_R <= shift_reg_R[39];  // Output MSB of the shift register
            shift_reg_L <= shift_reg_L << 1; // Shift left to push MSB out
            shift_reg_R <= shift_reg_R << 1; // Shift left to push MSB out
            bit_cnt <= bit_cnt - 1;
        end
    end

endmodule


//Testbench for PISO
`timescale 1ns / 1ps

module PISO_tb;

    // Inputs
    reg SCLK;
    reg CLR;
    reg LOAD;
    reg EN;
    reg [39:0] PDATAIN_L;
    reg [39:0] PDATAIN_R;

    // Outputs
    wire DATAOUT_L;
    wire DATAOUT_R;

    // Internal capture registers (Corrected to 40 bits wide)
    reg [39:0] captured_L;
    reg [39:0] captured_R;

    integer i;

    // Instantiate the module under test
    PISO uut (
        .SCLK(SCLK),
        .CLR(CLR),
        .LOAD(LOAD),
        .EN(EN),
        .PDATAIN_L(PDATAIN_L),
        .PDATAIN_R(PDATAIN_R),
        .DATAOUT_L(DATAOUT_L),
        .DATAOUT_R(DATAOUT_R)
    );

    // Clock generation
    initial begin
        SCLK = 0;
        forever #5 SCLK = ~SCLK;  // 10ns clock period
    end

    // Stimulus and capture logic
    initial begin
        // Init
        CLR = 1;
        LOAD = 0;
        EN = 0;
        PDATAIN_L = 40'hFFFFFB4380;
        PDATAIN_R = 40'h0002546D5C;

        captured_L = 40'b0;
        captured_R = 40'b0;

        #12;
        CLR = 0;

        #10;
        LOAD = 1;
        #10;
        LOAD = 0;

        EN = 1;

        // Capture 40 serial bits
        for (i = 0; i < 40; i = i + 1) begin
            @(posedge SCLK);
            captured_L = {captured_L[38:0], DATAOUT_L};  // Shift right, capturing MSB first
            captured_R = {captured_R[38:0], DATAOUT_R};  // Shift right, capturing MSB first
        end

        EN = 0;

        // Display result
        $display("\nGenerated Serial Output:");
        $display("OutputL = %010h", captured_L);
        $display("OutputR = %010h", captured_R);

        // Expected values for comparison
        $display("ExpectedL = %010h", 40'hFFFFFB4380);
      $display("ExpectedR = %010h", 40'h0002546D5C); 

        if (captured_L == 40'hFFFFFB4380 && captured_R == 40'h0002546D5C)
            $display("Compare Result: PASS");
        else
            $display("Compare Result: FAIL");

        $stop;
    end

endmodule
