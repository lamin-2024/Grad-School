module Controller (
    input wire clk,
    input wire reset,
    output reg enable
);

    typedef enum reg [1:0] {IDLE, RUNNING} state_t;
    state_t current_state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            IDLE: begin
                enable = 0;
                if (!reset) begin
                    next_state = RUNNING;
                end else begin
                    next_state = IDLE;
                end
            end
            RUNNING: begin
                enable = 1;
                if (reset) begin
                    next_state = IDLE;
                end else begin
                    next_state = RUNNING;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
