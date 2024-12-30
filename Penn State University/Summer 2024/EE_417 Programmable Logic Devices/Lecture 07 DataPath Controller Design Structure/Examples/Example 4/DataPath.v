module DataPath #(parameter WORD_SIZE = 8, parameter NUM_CYCLES = 18) (
    input wire clk,
    input wire reset,
    input wire enable,
    output reg [WORD_SIZE-1:0] count
);

    reg [4:0] cycle_count;  // 5-bit counter to count up to 18

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            cycle_count <= 0;
            count <= 8'b0000_0001;  // Initial count value
        end else if (enable) begin
            if (cycle_count == NUM_CYCLES - 1) begin
                cycle_count <= 0;
            end else begin
                cycle_count <= cycle_count + 1;
            end

            // Update the count based on the cycle count
            count <= {count[WORD_SIZE-2:0], count[WORD_SIZE-1]};
        end
    end
endmodule
