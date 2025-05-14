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
