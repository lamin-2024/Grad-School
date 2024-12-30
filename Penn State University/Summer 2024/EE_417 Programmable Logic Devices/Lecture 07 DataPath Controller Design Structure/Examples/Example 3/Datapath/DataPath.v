//module DataPath #(parameter WIDTH = 8, parameter CYCLES = 18) (
//    input clk,
//    input reset,
//    input shift_en,
//    input load,
//    output reg [WIDTH-1:0] count,
//    output reg done
//);
//
//reg [4:0] cycle_count; // 5-bit counter to count up to 18 cycles
//
//always @ (posedge clk or posedge reset) begin
//    if (reset) begin
//        count <= 0;
//        cycle_count <= 0;
//        done <= 0;
//    end else if (load) begin
//        count <= 8'b00000001; // Load initial value
//        cycle_count <= 1;
//        done <= 0;
//    end else if (shift_en) begin
//        count <= {count[WIDTH-2:0], count[WIDTH-1]}; // Shift left
//        cycle_count <= cycle_count + 1;
//        if (cycle_count == CYCLES - 1) begin
//            done <= 1;
//        end else begin
//            done <= 0;
//        end
//    end
//end
//
//endmodule



//module DataPath #(parameter WIDTH = 8, parameter CYCLES = 18) (
//    input clk,
//    input reset,
//    input shift_en,
//    input load,
//    output reg [WIDTH-1:0] count,
//    output reg done
//);
//
//reg [4:0] cycle_count; // 5-bit counter to count up to 18 cycles
//
//always @ (posedge clk or posedge reset) begin
//    if (reset) begin
//        count <= 8'b00000001; // Initialize count to the first state
//        cycle_count <= 0;
//        done <= 0;
//    end else if (load) begin
//        count <= 8'b00000001; // Load initial value
//        cycle_count <= 1;
//        done <= 0;
//    end else if (shift_en) begin
//        if (cycle_count == CYCLES) begin
//            cycle_count <= 1;
//            count <= 8'b00000001;
//        end else begin
//            cycle_count <= cycle_count + 1;
//            if (count[WIDTH-1] == 1) begin
//                count <= 8'b00000001; // Reset to initial value after overflow
//            end else begin
//                count <= count << 1; // Shift left
//            end
//        end
//        done <= (cycle_count == CYCLES);
//    end
//end
//
//endmodule



/*------------up/down count------------------------------*/
//module DataPath #(parameter WIDTH = 8, parameter CYCLES = 18) (
//    input clk,
//    input reset,
//    input shift_en,
//    input load,
//    input up, // up/down control signal
//    output reg [WIDTH-1:0] count,
//    output reg done
//);
//
//reg [4:0] cycle_count; // 5-bit counter to count up to 18 cycles
//
//always @ (posedge clk or posedge reset) begin
//    if (reset) begin
//        count <= 8'b00000001; // Initialize count to the first state
//        cycle_count <= 0;
//        done <= 0;
//    end else if (load) begin
//        count <= 8'b00000001; // Load initial value
//        cycle_count <= 1;
//        done <= 0;
//    end else if (shift_en) begin
//        if (cycle_count == CYCLES) begin
//            cycle_count <= 1;
//            count <= 8'b00000001;
//        end else begin
//            cycle_count <= cycle_count + 1;
//            if (up) begin
//                if (count[WIDTH-1] == 1) begin
//                    count <= 8'b00000001; // Reset to initial value after overflow
//                end else begin
//                    count <= count << 1; // Shift left for up count
//                end
//            end else begin
//                if (count[0] == 1) begin
//                    count <= 8'b10000000; // Reset to the highest bit
//                end else begin
//                    count <= count >> 1; // Shift right for down count
//                end
//            end
//        end
//        done <= (cycle_count == CYCLES);
//    end
//end
//
//endmodule


/*----------------------------shift left or right-------------------------------*/

module DataPath #(parameter WIDTH = 8, parameter CYCLES = 18) (
    input clk,
    input reset,
    input shift_left,
    input shift_right,
    input load,
    output reg [WIDTH-1:0] count,
    output reg done
);

reg [4:0] cycle_count; // 5-bit counter to count up to 18 cycles

always @ (posedge clk or posedge reset) begin
    if (reset) begin
        count <= 8'b00000001; // Initialize count to the first state
        cycle_count <= 0;
        done <= 0;
    end else if (load) begin
        count <= 8'b00000001; // Load initial value
        cycle_count <= 1;
        done <= 0;
    end else if (shift_left || shift_right) begin
        if (cycle_count == CYCLES) begin
            cycle_count <= 1;
            count <= 8'b00000001;
        end else begin
            cycle_count <= cycle_count + 1;
            if (shift_left) begin
                if (count[WIDTH-1] == 1) begin
                    count <= 8'b00000001; // Reset to initial value after overflow
                end else begin
                    count <= count << 1; // Shift left
                end
            end else if (shift_right) begin
                if (count[0] == 1) begin
                    count <= 8'b10000000; // Reset to the highest bit
                end else begin
                    count <= count >> 1; // Shift right
                end
            end
        end
        done <= (cycle_count == CYCLES);
    end
end

endmodule
