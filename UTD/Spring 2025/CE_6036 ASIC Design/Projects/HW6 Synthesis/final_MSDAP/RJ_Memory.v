module RJ_Memory (
    input wire DCLK,                      // Clock signal
    input wire SCLK,
    input wire CLEAR,                    // Synchronous clear
    input wire READ_EN,                     // Frame load signal (optional)
    input wire [15:0] PDATA_IN,           // 8-bit data input
    input wire [3:0] WRITE_ADDRESS,      // 4-bit write address (16 locations)
    input wire WRITE_EN,                 // Write enable
    input wire [3:0] READ_ADDRESS,       // 4-bit read address
    output reg [7:0] DATAOUT            // 8-bit data output
);

    // 16 x 8-bit memory array
    reg [7:0] memory [15:0];
    integer i;

    // Synchronous write and clear logic
    always @(negedge DCLK or posedge CLEAR) begin
        if (CLEAR) begin
            DATAOUT = 8'b0;
            for (i = 0; i < 16; i = i + 1) begin
                memory[i] <= 8'b0;
            end
        end else begin 
            if (WRITE_EN) begin
                memory[WRITE_ADDRESS] <= PDATA_IN[7:0];
            end
        end
    end

    always @(posedge SCLK) begin
        if (READ_EN) begin
             DATAOUT <= memory[READ_ADDRESS];
        end
    end

endmodule
