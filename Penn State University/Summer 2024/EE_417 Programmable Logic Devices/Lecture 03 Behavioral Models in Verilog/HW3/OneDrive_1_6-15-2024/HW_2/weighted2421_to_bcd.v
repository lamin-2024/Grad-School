module weighted2421_to_bcd (
    input [3:0] weighted2421,
    output reg [3:0] bcd
);

always @(*) begin
    case (weighted2421)
        4'b0000: bcd = 4'b0000;  // 0 in 2421 -> 0 in BCD
        4'b0001: bcd = 4'b0001;  // 1 in 2421 -> 1 in BCD
        4'b0010: bcd = 4'b0010;  // 2 in 2421 -> 2 in BCD
        4'b0011: bcd = 4'b0011;  // 3 in 2421 -> 3 in BCD
        4'b0100: bcd = 4'b0100;  // 4 in 2421 -> 4 in BCD
        4'b1011: bcd = 4'b0101;  // 5 in 2421 -> 5 in BCD
        4'b1100: bcd = 4'b0110;  // 6 in 2421 -> 6 in BCD
        4'b1101: bcd = 4'b0111;  // 7 in 2421 -> 7 in BCD
        4'b1110: bcd = 4'b1000;  // 8 in 2421 -> 8 in BCD
        4'b1111: bcd = 4'b1001;  // 9 in 2421 -> 9 in BCD
        default: bcd = 4'b0000;  // Default case to handle any invalid input
    endcase
end

endmodule
