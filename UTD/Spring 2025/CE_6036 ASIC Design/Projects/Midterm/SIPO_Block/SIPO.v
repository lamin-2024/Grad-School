module SIPO (
    input wire DCLK,               // Data clock
    input wire CLR,                // Clear signal
    input wire EN,                 // Enable signal
    input wire DATA_IN,            // Serial 1-bit input (MSB first)

    output reg [15:0] PDATA_IN_L,  // Upper 16 bits of input
    output reg [15:0] PDATA_IN_R   // Lower 16 bits of input
);

    reg [31:0] shift_reg = 32'b0;
    reg [5:0] bit_count = 0;

    always @(posedge DCLK or posedge CLR) begin
        if (CLR) begin
            shift_reg    <= 32'b0;
            bit_count    <= 0;
            PDATA_IN_L   <= 16'b0;
            PDATA_IN_R   <= 16'b0;
        end else if (EN) begin
            //  Shift left: MSB first (new bit enters at LSB)
            shift_reg <= (shift_reg << 1) | DATA_IN;
            bit_count <= bit_count + 1;

            //  Latch output after 32 bits
            if (bit_count == 31) begin
                PDATA_IN_L <= shift_reg[31:16];
                PDATA_IN_R <= shift_reg[15:0];
                bit_count  <= 0;
            end
        end
    end

endmodule
