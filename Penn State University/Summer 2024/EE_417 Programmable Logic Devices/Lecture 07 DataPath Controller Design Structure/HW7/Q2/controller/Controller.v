/*----------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 07 HW Question 2
Group: Ron Kalin/ Lamin Jammeh
Project Description: COntroller module sends control command to the Datapath to shift
the value 1 left or right in an input data
-------------------------------------------------------------------------------------*/

/*----------------------------up/down counter controller--------------*/
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
        SHIFT: next_state = done ? DONE : SHIFT; //keep shifting if Done is false
        DONE: next_state = IDLE;
        default: next_state = IDLE;
    endcase
end

// Output logic
always @ (*) begin
    shift_left  = 0;   // Default direction
	 shift_right = 0;
           load = 0;
    case (state)
        IDLE: begin
               load = 1;
             end
        LOAD: begin
               shift_left = 1;
              end
        SHIFT: begin
                 if (shift_left) 
					  begin
                   shift_left = 1;
                   shift_right = 0;
                end 
			  else begin
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