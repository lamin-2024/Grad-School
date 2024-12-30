module fsm (
    input wire clk,
    input wire reset,
    input wire X,
    output reg Z1,
    output reg Z2
);

    reg [2:0] state, next_state;
        parameter S0 = 3'b000;
        parameter S1 = 3'b001;
        parameter S2 = 3'b010;
        parameter S3 = 3'b011;
        parameter S4 = 3'b100;
        parameter S5 = 3'b101;
        parameter S6 = 3'b110;
        parameter S7 = 3'b111;
    
    

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        Z1 = 0;
        Z2 = 0;
        case (state)
            S0: begin
                if (X)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (X)
                    next_state = S2;
            end
            S2: begin
                if (X)
                    next_state = S4;
                else begin
                    next_state = S3;
                    Z1 = (state != S7) ? 1 : 0;
                end
            end
            S3: begin
                if (X)
                    next_state = S4;
                else
                    next_state = S1;
            end
            S4: begin
                if (!X)
                    next_state = S5;
            end
            S5: begin
                if (X)
                    next_state = S4;
                else begin
                    next_state = S6;
                    Z2 = 1;
                end
            end
            S6: begin
                next_state = S7;
            end
            S7: begin
                next_state = S7;
            end
        endcase
    end

endmodule
