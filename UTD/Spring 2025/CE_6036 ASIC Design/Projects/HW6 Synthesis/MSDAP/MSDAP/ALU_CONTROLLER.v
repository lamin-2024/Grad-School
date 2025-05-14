module ALU_CONTROLLER (
	input wire SCLK,
	input wire CLEAR,
	input wire EN_FIR,

	input wire [7:0] RJ_DATA_L,
	input wire [7:0] RJ_DATA_R,

	input wire [8:0] COEFF_DATA_L,
	input wire [8:0] COEFF_DATA_R,

	output reg CLEAR_REG,
	output reg LOAD,
	output reg SHIFT,
	
	output reg [7:0] READ_DATA_ADDR_L,
	output reg [7:0] READ_DATA_ADDR_R,

	output reg [3:0] READ_RJ_ADDR_L,
	output reg [3:0] READ_RJ_ADDR_R,

	output reg [8:0] READ_COEFF_ADDR_L,
	output reg [8:0] READ_COEFF_ADDR_R
);
	//FSM STATES
    	localparam IDLE = 3'd0;
	localparam LOAD_X2  = 3'd1;
	localparam PROCESS_RJ = 3'd2;
    	localparam PROCESS_COEFF = 3'd3;
	localparam SHIFT_SUM  = 3'd4;
	localparam DONE = 3'd5;

	//Local Variables
	reg [2:0] curr_state, next_state;
	reg [3:0] RJ_Counter;
	reg [8:0] COEFF_Counter; 
	

	always @(posedge SCLK) begin
		curr_state <= next_state;
	end



	always @(*) begin
		case(curr_state) 
			INIT: begin
				CLEAR_REG <= 1;
				LOAD <= 0;
				SHIFT <= 0;

				READ_DATA_ADDR_L <= 0;
				READ_DATA_ADDR_R <= 0;
				
				READ_RJ_ADDR_L <= 0;
				READ_RJ_ADDR_R <= 0;
				
				READ_COEFF_ADDR_L <= 0;
				READ_COEFF_ADDR_R <= 0;
				
				RJ_Counter <= 0;
				COEFF_Counter <= 0;
			end
			
			WORKING: begin
				CLEAR_REG <= 0;
			end
		endcase
	end

