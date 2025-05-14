`timescale 1ns / 1ps

module SHIFT_RIGHT_REGISTER_tb;

    // Testbench signals
    reg SCLK;
    reg CLEAR;
    reg LOAD;
    reg SHIFT;
    reg [23:0] DATAIN;
    wire [39:0] DATAOUT;

    // Instantiate the module under test
    SHIFT_RIGHT_REGISTER uut (
        .SCLK(SCLK),
        .CLEAR(CLEAR),
        .LOAD(LOAD),
        .SHIFT(SHIFT),
        .DATAIN(DATAIN),
        .DATAOUT(DATAOUT)
    );

    // Generate 26.88 MHz clock (Period ~37.24ns)
    initial SCLK = 0;
    always #18.62 SCLK = ~SCLK;  // Half-period for 26.88 MHz

    integer i;

    initial begin
        $display("Starting SHIFT_RIGHT_REGISTER Testbench...");

        // Initial state
        CLEAR = 1;
        LOAD = 0;
        SHIFT = 0;
        DATAIN = 24'h000000;

        #40 CLEAR = 0;  // Release reset

        // Initialize lower 16 bits by loading and shifting once
        #20 DATAIN = 24'hABCDE0;
        LOAD = 1;
        @(posedge SCLK);
        LOAD = 0;

        $display("Initial Load:");
        $display("DATAOUT = %h", DATAOUT);

        // Main loop: Shift + Load new DATAIN each cycle
        for (i = 0; i < 10; i = i + 1) begin
            // Shift right by 1 bit
            SHIFT = 1;
            @(posedge SCLK);
            SHIFT = 0;

            // Change DATAIN for demonstration
            DATAIN = 24'hABCDE0 + i;

            // Load new DATAIN into upper 24 bits
            LOAD = 1;
            @(posedge SCLK);
            LOAD = 0;

            $display("Cycle %0d: DATAIN = %h | DATAOUT = %h", i, DATAIN, DATAOUT);
        end

        $display("Test complete.");
        $finish;
    end

endmodule
