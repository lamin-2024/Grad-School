`timescale 1ns / 1ps

module fsm_tb;

    // Inputs
    reg clk;
    reg reset;
    reg X;

    // Outputs
    wire Z1;
    wire Z2;

    // Instantiate the FSM
    fsm uut (
        .clk(clk),
        .reset(reset),
        .X(X),
        .Z1(Z1),
        .Z2(Z2)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns period clock
    end

    // Stimulus
    initial begin
        // Initialize Inputs
        reset = 1;
        X = 0;
        #10;

        // Apply reset
        reset = 0;
        #10;

        // Sequence: 0 -> 1 -> 0 -> (Z1 should be 1)
        X = 0;
        #10;
        X = 1;
        #10;
        X = 0;
        #10;

        // Sequence: 1 -> 0 -> 0 -> (Z2 should be 1)
        X = 1;
        #10;
        X = 0;
        #10;
        X = 0;
        #10;

        // Continue with more sequences as needed for thorough testing
        X = 0;
        #10;
        X = 1;
        #10;
        X = 0;
        #10;
    end

    // Monitor outputs
    initial begin
        $monitor("At time %t, X = %b, Z1 = %b, Z2 = %b", $time, X, Z1, Z2);
    end

endmodule
