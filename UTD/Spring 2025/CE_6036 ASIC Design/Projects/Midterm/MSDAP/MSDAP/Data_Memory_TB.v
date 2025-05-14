`timescale 1ns / 1ps

module Data_Memory_tb;
    // Inputs
    reg CLK;
    reg CLEAR;
    reg LOAD;
    reg [15:0] PDATA_IN;
    reg [7:0] WRITE_ADDRESS;
    reg WRITE_EN;
    reg [7:0] READ_ADDRESS;

    // Outputs
    wire [15:0] DATAOUT;
    wire ZERO_DETECTED;

    // Instantiate the module
    Data_Memory uut (
        .CLK(CLK),
        .CLEAR(CLEAR),
        .LOAD(LOAD),
        .PDATA_IN(PDATA_IN),
        .WRITE_ADDRESS(WRITE_ADDRESS),
        .WRITE_EN(WRITE_EN),
        .READ_ADDRESS(READ_ADDRESS),
        .DATAOUT(DATAOUT),
        .ZERO_DETECTED(ZERO_DETECTED)
    );

    // Clock generation for 786kHz -> 1272ns period
    initial CLK = 0;
    always #636 CLK = ~CLK;

    integer i;
    reg [15:0] test_data [0:255];
    reg [15:0] read_data;
    integer errors;

    initial begin
        $display("Starting Data_Memory Testbench");

        // Initial values
        CLEAR = 0;
        LOAD = 0;
        WRITE_EN = 0;
        WRITE_ADDRESS = 0;
        READ_ADDRESS = 0;
        PDATA_IN = 0;
        errors = 0;

        // Wait a few clock cycles
        #20;

        // Write random data to memory
        for (i = 0; i < 256; i = i + 1) begin
            @(negedge CLK);
            test_data[i] = $random;
            PDATA_IN = test_data[i];
            WRITE_ADDRESS = i;
            WRITE_EN = 1;
        end
        @(negedge CLK);
        WRITE_EN = 0;

        // Read and validate memory contents
        $display("\nValidating memory contents after write...");
        for (i = 0; i < 256; i = i + 1) begin
            @(posedge CLK);
            READ_ADDRESS = i;
            @(negedge CLK);
            read_data = DATAOUT;
            if (read_data !== test_data[i]) begin
                $display("Mismatch at address %0d: expected %0h, got %0h", i, test_data[i], read_data);
                errors = errors + 1;
            end
        end

        // Clear memory
        @(posedge CLK);
        CLEAR = 1;
        @(posedge CLK);
        CLEAR = 0;

        // Read and validate memory contents after clear
        $display("\nValidating memory contents after clear...");
        for (i = 0; i < 256; i = i + 1) begin
            @(posedge CLK);
            READ_ADDRESS = i;
            @(negedge CLK);
            read_data = DATAOUT;
            if (read_data !== 16'b0) begin
                $display("Clear failed at address %0d: expected 0000, got %0h", i, read_data);
                errors = errors + 1;
            end
        end

        if (errors == 0) begin
            $display("\n Data_Memory Testbench PASSED.");
        end else begin
            $display("\n Data_Memory Testbench FAILED with %0d error(s).", errors);
        end

        $finish;
    end

endmodule
