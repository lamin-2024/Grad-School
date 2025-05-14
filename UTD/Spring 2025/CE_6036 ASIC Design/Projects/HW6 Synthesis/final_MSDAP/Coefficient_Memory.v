module Coefficient_Memory (
    input wire DCLK,                      // Clock signal
    input wire SCLK,
    input wire CLEAR,                    // Synchronous clear
    input wire READ_EN,                     // Frame load signal (optional)
    input wire [15:0] PDATA_IN,           // 9-bit data input
    input wire [8:0] WRITE_ADDRESS,      // 9-bit write address (512 locations)
    input wire WRITE_EN,                 // Write enable
    input wire [8:0] READ_ADDRESS,       // 9-bit read address
    output reg [8:0] DATAOUT            // 9-bit data output
);

    // 512 x 9-bit memory array
    reg [8:0] memory [511:0];
    integer i;

    // Synchronous write and clear logic
    always @(negedge DCLK or posedge CLEAR) begin
        if (CLEAR) begin
            DATAOUT = 9'b0;
            for (i = 0; i < 512; i = i + 1) begin
                memory[i] <= 9'b0;
            end
        end else begin 
            if (WRITE_EN) begin
                memory[WRITE_ADDRESS] <= PDATA_IN[8:0];
            end
        end
    end

    always @(posedge SCLK) begin
        if (READ_EN) begin
             DATAOUT <= memory[READ_ADDRESS];
        end
    end

endmodule


