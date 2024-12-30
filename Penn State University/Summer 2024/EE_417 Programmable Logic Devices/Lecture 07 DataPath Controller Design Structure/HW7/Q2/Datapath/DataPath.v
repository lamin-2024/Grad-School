/*----------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 07 HW Question 2
Group: Ron Kalin/ Lamin Jammeh
Project Description: Datapath module takes comman from controoler module and counts 
use a one hot count by shifting the value 1 left and right in an 8 bit input
-------------------------------------------------------------------------------------*/

/*------------up/down count------------------------------*/
module DataPath #(parameter WIDTH = 8, parameter CYCLES = 18) (
    input clk,
    input reset,
    input shift_left,
	 input shift_right,
    input load,
	 input [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] count,
    output reg done
);

reg [4:0] shift_reg; // 5-bit counter to count up to 18 CYCLES

always @ (posedge clk or posedge reset) 
begin
	 //condition for reset
    if (reset) 
	 begin
        count <= 8'b00000001; // output count at reset is the first state of the counter
        shift_reg <= 0;
        done <= 0;
    end 
	 //condition to start loading the output
	 else if (load) 								
	 begin
        count <= data_in; // count is still 1 when load comes on
        shift_reg <= 1;
        done <= 0;
    end 
	 //condition to shift 1 left and right in count
	 else if (shift_left || shift_right) 
	 begin
        if (shift_reg == CYCLES) 
		  begin
            shift_reg <= 1;
            count <= 8'b00000001;
				//done <= 1;
        end 
		  else begin
            shift_reg <= shift_reg + 1;				//all start conditions are active, increment shift_reg
				//define a condition for counting up
            if (shift_left) 
				begin
					count <= {count[WIDTH-2:0], count[WIDTH-1]}; // Shift left by joining count[6:0] to count[7]
            end 
				else if (shift_right) 
				begin
					count <= {count[0], count[WIDTH-1:1]}; // Shift right by joining count[0] to count[7:1]
            end
        end
        done <= (shift_reg == CYCLES);
    end
end

endmodule
