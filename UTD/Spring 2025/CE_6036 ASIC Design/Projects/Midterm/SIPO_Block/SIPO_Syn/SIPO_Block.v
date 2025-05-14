module SIPO_Block (
    input wire DCLK,
    input wire CLR,
    input wire EN,
    input wire DATA_IN,
    output reg [15:0] PDATA_IN_L,
    output reg [15:0] PDATA_IN_R
);

    reg [31:0] shift_reg = 32'b0;
    reg [5:0] bit_count = 0;
    reg [2:0] wait_count = 0;
    reg waiting_after_32 = 0; // 4-cycle wait after 32 bits
    reg wait_per_bit = 0;     // 1-cycle wait between bits

    always @(posedge DCLK or posedge CLR) begin
        if (CLR) begin
            shift_reg       <= 32'b0;
            bit_count       <= 0;
            wait_count      <= 0;
            waiting_after_32<= 0;
            wait_per_bit    <= 0;
            PDATA_IN_L      <= 16'b0;
            PDATA_IN_R      <= 16'b0;
        end else if (EN) begin
            if (waiting_after_32) begin
                // 4-cycle wait after 32-bit shift is complete
                wait_count <= wait_count + 1;

                if (wait_count == 3) begin
                    PDATA_IN_L <= shift_reg[31:16];
                    PDATA_IN_R <= shift_reg[15:0];
                    waiting_after_32 <= 0;
                    wait_count <= 0;
                end
            end else if (wait_per_bit) begin
                // Just wait 1 cycle between shifts
                wait_per_bit <= 0;
            end else begin
                // Shift in a bit
                shift_reg <= (shift_reg << 1) | DATA_IN;
                bit_count <= bit_count + 1;
                wait_per_bit <= 1;  // Trigger 1-cycle pause

                if (bit_count == 31) begin
                    waiting_after_32 <= 1;
                    bit_count <= 0;
                end
            end
        end
    end

endmodule
