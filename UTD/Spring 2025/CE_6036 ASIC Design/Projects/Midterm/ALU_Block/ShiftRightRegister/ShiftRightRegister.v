module ShiftRightRegister (
    input  wire        clk,
    input  wire        reset,
    input  wire        load,
    input  wire [23:0] adder_outL,
    input  wire [23:0] adder_outR,
    output reg  [39:0] shift_outL,
    output reg  [39:0] shift_outR,
    output reg         done_shifting
);

    reg [5:0] shift_count;
    reg       shifting;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_outL     <= 40'd0;
            shift_outR     <= 40'd0;
            shift_count    <= 6'd0;
            shifting       <= 1'b0;
            done_shifting  <= 1'b0;
        end else begin
            done_shifting <= 1'b0;

            if (load) begin
                shift_outL[39:16] <= adder_outL;
                shift_outL[15:0]  <= 16'd0;
                shift_outR[39:16] <= adder_outR;
                shift_outR[15:0]  <= 16'd0;
                shift_count       <= 6'd0;
                shifting          <= 1'b1;
            end else if (shifting) begin
                shift_outL <= {1'b0, shift_outL[39:1]};
                shift_outR <= {1'b0, shift_outR[39:1]};
                shift_count <= shift_count + 1;

                if (shift_count == 6'd31) begin
                    shifting      <= 1'b0;
                    done_shifting <= 1'b1;
                end
            end
        end
    end

endmodule