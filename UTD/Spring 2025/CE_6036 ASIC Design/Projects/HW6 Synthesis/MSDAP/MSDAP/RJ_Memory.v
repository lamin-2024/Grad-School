module RJ_Memory (
    input wire CLK,                      // Clock signal
    input wire CLEAR,                    // Synchronous clear
    input wire LOAD,                     // Frame load signal (optional)
    input wire [15:0] PDATA_IN,           // 8-bit data input
    input wire [3:0] WRITE_ADDRESS,      // 4-bit write address (16 locations)
    input wire WRITE_EN,                 // Write enable
    input wire [3:0] READ_ADDRESS,       // 4-bit read address
    output wire [7:0] DATAOUT            // 8-bit data output
);

    // 16 x 8-bit memory array
    reg [7:0] memory [15:0];
    integer i;

    // Synchronous write and clear logic
    always @(negedge CLK or posedge CLEAR) begin
        if (CLEAR) begin
            for (i = 0; i < 16; i = i + 1) begin
                memory[i] <= 8'b0;
            end
        end else if (WRITE_EN) begin
            memory[WRITE_ADDRESS] <= PDATA_IN[7:0];
        end
    end

    // Combinational read
    assign DATAOUT = memory[READ_ADDRESS];

endmodule
