module moore_down_counter (
    input wire clk,       // Clock signal
    input wire reset,     // Reset signal (active low)
    input wire enable,    // Enable signal
    output reg [3:0] count // 4-bit count output
);

reg [2:0] current_state, next_state;

// State encoding
parameter	 S1111 = 4'b1111;
parameter    S1110 = 4'b1110;
parameter    S1101 = 4'b1101;
parameter    S1100 = 4'b1100;
parameter    S1011 = 4'b1011;
parameter    S1010 = 4'b1010;
parameter    S1001 = 4'b1001;
parameter    S1000 = 4'b1000;
parameter    S0111 = 4'b0111;
parameter    S0110 = 4'b0110;
parameter    S0101 = 4'b0101;
parameter    S0100 = 4'b0100;
parameter    S0011 = 4'b0011;
parameter    S0010 = 4'b0010;
parameter    S0001 = 4'b0001;
parameter    S0000 = 4'b0000;



// State transition logic
always @(posedge clk or negedge reset) begin
    if (!reset)
        current_state <= S1111; // Initialize state to S1111 when reset is low
    else
        current_state <= next_state;
end

// Next state logic
always @(*) begin
    case (current_state)
        S1111: next_state = (enable) ? S1000 : S1111;
        S1110: next_state = (enable) ? S0111 : S1110;
        S1101: next_state = (enable) ? S0110 : S1101;
        S1100: next_state = (enable) ? S0101 : S1100;
        S1011: next_state = (enable) ? S0100 : S1011;
        S0100: next_state = (enable) ? S0011 : S0100;
        S0011: next_state = (enable) ? S0010 : S0011;
        S0010: next_state = (enable) ? S0001 : S0010;
        S0001: next_state = (enable) ? S0000 : S0001;
        S0000: next_state = (enable) ? S1111 : S0000;
        //default: next_state = S1111;
    endcase
end

// Output logic
always @(posedge clk or negedge reset) begin
    if (!reset)
        count <= 4'b1111; // Initialize count to 1111 when reset is low
    else
        count <= current_state; // Output the current state as count
end

endmodule
