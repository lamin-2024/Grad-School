//module Controller (
//    input clk,
//    input reset,
//    input done,
//    output reg shift_en,
//    output reg load
//);
//
//reg [1:0] state, next_state;
//
//parameter    IDLE  = 2'b00;
//parameter    LOAD  = 2'b01;
//parameter    SHIFT = 2'b10;
//parameter    DONE  = 2'b11;
//
//
//// State transition logic
//always @ (posedge clk or posedge reset) begin
//    if (reset)
//        state <= IDLE;
//    else
//        state <= next_state;
//end
//
//// Next state logic
//always @ (*) begin
//    case (state)
//        IDLE: next_state = LOAD;
//        LOAD: next_state = SHIFT;
//        SHIFT: next_state = done ? DONE : SHIFT;
//        DONE: next_state = IDLE;
//        default: next_state = IDLE;
//    endcase
//end
//
//// Output logic
//always @ (*) begin
//    shift_en = 0;
//    load = 0;
//    case (state)
//        IDLE: begin
//            load = 1;
//        end
//        LOAD: begin
//            shift_en = 1;
//        end
//        SHIFT: begin
//            shift_en = 1;
//        end
//        DONE: begin
//            // No control signals
//        end
//    endcase
//end
//
//endmodule





/*----------------------------up/down counter controller--------------*/
//module Controller (
//    input clk,
//    input reset,
//    input done,
//    output reg shift_en,
//    output reg load,
//    output reg up // up/down control signal
//);
//
//reg [1:0] state, next_state;
//
//parameter    IDLE  = 2'b00;
//parameter    LOAD  = 2'b01;
//parameter    SHIFT = 2'b10;
//parameter    DONE  = 2'b11;
//
//// State transition logic
//always @ (posedge clk or posedge reset) begin
//    if (reset)
//        state <= IDLE;
//    else
//        state <= next_state;
//end
//
//// Next state logic
//always @ (*) begin
//    case (state)
//        IDLE: next_state = LOAD;
//        LOAD: next_state = SHIFT;
//        SHIFT: next_state = done ? DONE : SHIFT;
//        DONE: next_state = IDLE;
//        default: next_state = IDLE;
//    endcase
//end
//
//// Output logic
//always @ (*) begin
//    shift_en = 0;
//    load = 0;
//    up = 1; // Default direction is up
//    case (state)
//        IDLE: begin
//            load = 1;
//        end
//        LOAD: begin
//            shift_en = 1;
//        end
//        SHIFT: begin
//            shift_en = 1;
//        end
//        DONE: begin
//            // No control signals
//        end
//    endcase
//end
//
//endmodule




/*--------------------------add shift-left or right--------------------------*/
module Controller (
    input clk,
    input reset,
    input done,
    output reg shift_left,
    output reg shift_right,
    output reg load
);

reg [1:0] state, next_state;

parameter    IDLE  = 2'b00;
parameter    LOAD  = 2'b01;
parameter    SHIFT = 2'b10;
parameter    DONE  = 2'b11;

// State transition logic
always @ (posedge clk or posedge reset) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

// Next state logic
always @ (*) begin
    case (state)
        IDLE: next_state = LOAD;
        LOAD: next_state = SHIFT;
        SHIFT: next_state = done ? DONE : SHIFT;
        DONE: next_state = IDLE;
        default: next_state = IDLE;
    endcase
end

// Output logic
always @ (*) begin
    shift_left = 0;
    shift_right = 0;
    load = 0;
    case (state)
        IDLE: begin
            load = 1;
        end
        LOAD: begin
            shift_left = 1; // Start with shift left
        end
        SHIFT: begin
            // Alternate between shift left and shift right
            if (shift_left) begin
                shift_left = 1;
                shift_right = 0;
            end else begin
                shift_left = 0;
                shift_right = 1;
            end
        end
        DONE: begin
            // No control signals
        end
    endcase
end

endmodule


