module pam4_to_nrz (
    input wire clk,           // Clock input
    input wire rst_n,         // Active low reset input
    input wire [1:0] pam4_symbol, // 2-bit PAM4 symbol input
    output reg nrz_bit        // NRZ bit output
);

    reg [1:0] pam4_reg; // Register to store the PAM4 symbol

    // Sequential block for capturing the PAM4 symbol
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pam4_reg <= 2'b00;
        end else begin
            pam4_reg <= pam4_symbol;
        end
    end

    // Combinational block for converting PAM4 to NRZ
    always @(*) begin
        case (pam4_reg)
            2'b00: nrz_bit = 1'b0; // PAM4 Level 0 -> Binary 00 -> NRZ Low
            2'b01: nrz_bit = 1'b1; // PAM4 Level 1 -> Binary 01 -> NRZ High
            2'b10: nrz_bit = 1'b0; // PAM4 Level 2 -> Binary 10 -> NRZ Low
            2'b11: nrz_bit = 1'b1; // PAM4 Level 3 -> Binary 11 -> NRZ High
            default: nrz_bit = 1'b0;
        endcase
    end

endmodule
