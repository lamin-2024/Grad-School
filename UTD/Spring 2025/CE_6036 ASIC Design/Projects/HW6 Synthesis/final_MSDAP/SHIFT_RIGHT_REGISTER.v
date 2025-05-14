module SHIFT_RIGHT_REGISTER (
    input wire SCLK,            // System clock
    input wire CLEAR,           // Asynchronous clear
    input wire LOAD,            // Load control signal
    input wire SHIFT,           // Shift control signal
    input wire [23:0] DATAIN,   // 24-bit input from the adder
    output wire [39:0] DATAOUT  // 40-bit output
);

    reg [39:0] shift_reg;

    always @(posedge SCLK or posedge CLEAR) begin
        if (CLEAR) begin
            shift_reg <= 40'b0;
        end else if (LOAD) begin
            shift_reg[39:16] <= DATAIN;   // Load 24 MSBs only
        end else if (SHIFT) begin
            shift_reg <= shift_reg >> 1;  // Shift right by 1 bit
        end
    end

    assign DATAOUT = shift_reg;

endmodule