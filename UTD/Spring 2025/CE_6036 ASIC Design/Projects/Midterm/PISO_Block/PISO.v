module PISO (
    input wire SCLK,                 // System clock
    input wire CLR,                  // Clear signal
    input wire LOAD,                 // Load 40-bit parallel word
    input wire EN,                   // Enable

    input wire [39:0] PDATAIN_L,     // 40-bit parallel input data - Left
    input wire [39:0] PDATAIN_R,     // 40-bit parallel input data - Right

    output reg DATAOUT_L,            // Serial output - Left (Single-bit output)
    output reg DATAOUT_R             // Serial output - Right (Single-bit output)
);

    reg [39:0] shift_reg_L;
    reg [39:0] shift_reg_R;
    reg [5:0] bit_cnt;

    always @(posedge SCLK or posedge CLR) begin
        if (CLR) begin
            shift_reg_L <= 40'b0;
            shift_reg_R <= 40'b0;
            bit_cnt <= 6'b0;
            DATAOUT_L <= 1'b0;
            DATAOUT_R <= 1'b0;
        end else if (LOAD) begin
            shift_reg_L <= PDATAIN_L;
            shift_reg_R <= PDATAIN_R;
            bit_cnt <= 6'b101000;   // 40 in decimal
        end else if (EN && bit_cnt != 0) begin
            DATAOUT_L <= shift_reg_L[39];  // Output MSB of the shift register
            DATAOUT_R <= shift_reg_R[39];  // Output MSB of the shift register
            shift_reg_L <= shift_reg_L << 1; // Shift left to push MSB out
            shift_reg_R <= shift_reg_R << 1; // Shift left to push MSB out
            bit_cnt <= bit_cnt - 1;
        end
    end

endmodule
