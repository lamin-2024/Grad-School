`timescale 1ns / 1ps

module RJ_Memory_tb;
    // Inputs
    reg CLK;
    reg CLEAR;
    reg LOAD;
    reg [15:0] PDATA_IN;
    reg [3:0] WRITE_ADDRESS;
    reg WRITE_EN;
    reg [3:0] READ_ADDRESS;

    // Output
    wire [7:0] DATAOUT;

    // Instantiate the module
    RJ_Memory uut (
        .CLK(CLK),
        .CLEAR(CLEAR),
        .LOAD(LOAD),
        .PDATA_IN(PDATA_IN),
        .WRITE_ADDRESS(WRITE_ADDRESS),
        .WRITE_EN(WRITE_EN),
        .READ_ADDRESS(READ_ADDRESS),
        .DATAOUT(DATAOUT)
    );

    // Clock generation for 786kHz -> 1272ns period
    initial CLK = 0;
    always #636 CLK = ~CLK;

    integer i;
    reg [7:0] test_data [15:0];
    reg [7:0] read_data;
    integer errors;

    initial begin
        $display("Starting RJ_Memory Testbench");

        // Initial values
        CLEAR = 0;
        LOAD = 0;
        WRITE_EN = 0;
        WRITE_ADDRESS = 0;
        READ_ADDRESS = 0;
        PDATA_IN = 0;
        errors = 0;

        // Wait for a few clock cycles
        #20;

        // Write random data to memory
        for (i = 0; i < 16; i = i + 1) begin
            @(negedge CLK);
            test_data[i] = $random % 256; // 8-bit random value
            PDATA_IN = {8'b0, test_data[i]};
            WRITE_ADDRESS = i;
            WRITE_EN = 1;
        end
        @(negedge CLK);
        WRITE_EN = 0;

        // Read and validate memory content
        $display("\nValidating memory contents after write...");
        for (i = 0; i < 16; i = i + 1) begin
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

        // Read and validate memory content after clear
        $display("\nValidating memory contents after clear...");
        for (i = 0; i < 16; i = i + 1) begin
            @(posedge CLK);
            READ_ADDRESS = i;
            @(negedge CLK);
            read_data = DATAOUT;
            if (read_data !== 8'b0) begin
                $display("Clear failed at address %0d: expected 00, got %0h", i, read_data);
                errors = errors + 1;
            end
        end

        if (errors == 0) begin
            $display("\n RJ_Memory Testbench PASSED.");
        end else begin
            $display("\n RJ_Memory Testbench FAILED with %0d error(s).", errors);
        end

        $finish;
    end

endmodule

