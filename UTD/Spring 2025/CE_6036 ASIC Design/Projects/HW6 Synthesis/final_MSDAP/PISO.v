module PISO (
    input wire SCLK,          // Clock signal
    input wire CLR,          // Asynchronous reset
    input wire LOAD,         // Load parallel data
    input wire EN,		//Enable Shifting
    input wire [39:0] PDATA_IN,  // 40-bit parallel input
    output wire SERIAL_OUT        // Serial output (bit 0 first)
);

    reg [39:0] shift_reg;

    always @(posedge SCLK or posedge CLR or posedge LOAD) begin
        if (CLR) begin
            shift_reg <= 40'b0;
        end else if (LOAD) begin
            shift_reg <= PDATA_IN;
        end else if (EN) begin
            shift_reg <= shift_reg >> 1; // Shift right: bit 0 comes out first
        end
    end

    assign SERIAL_OUT = shift_reg[0]; // Output LSB first

endmodule
