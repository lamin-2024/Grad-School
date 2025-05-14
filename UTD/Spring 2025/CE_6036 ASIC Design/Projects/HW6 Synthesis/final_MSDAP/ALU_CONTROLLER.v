module ALU_CONTROLLER (
	input wire SCLK,
	input wire CLEAR,
	input wire EN_FIR,

	//Left Datapath
	input wire [7:0] RJ_DATA_L,
	input wire [8:0] COEFF_DATA_L,

	output reg CLEAR_SHIFT_REG_L,
	output reg LOAD_SHIFT_REG_L,
	output reg SHIFT_L,
	output reg ADDSUBTRACT_L,
	
	output reg [7:0] DATA_READ_ADDRESS_L,
	output reg DATA_READ_EN_L,

	output reg [3:0] RJ_READ_ADDRESS_L,
	output reg RJ_READ_EN_L,

	output reg [8:0] COEFF_READ_ADDRESS_L,
	output reg COEFF_READ_EN_L,

	output reg CLEAR_PISO_L,
	output reg CLEAR_PISO_R,

	output reg LOAD_PISO_L,
	output reg LOAD_PISO_R,

	output reg PISO_EN_L,
	output reg PISO_EN_R,

	//Right Datapath
	input wire [7:0] RJ_DATA_R,
	input wire [8:0] COEFF_DATA_R,

	output reg CLEAR_SHIFT_REG_R,
	output reg LOAD_SHIFT_REG_R,
	output reg SHIFT_R,
	output reg ADDSUBTRACT_R,
	
	output reg [7:0] DATA_READ_ADDRESS_R,
	output reg DATA_READ_EN_R,

	output reg [3:0] RJ_READ_ADDRESS_R,
	output reg RJ_READ_EN_R,

	output reg [8:0] COEFF_READ_ADDRESS_R,
	output reg COEFF_READ_EN_R
);
	
	localparam INIT_R = 3'd0;
	localparam READ_DATA_R = 3'd1;
	localparam READ_RJ_R = 3'd2;
	localparam READ_COEFF_R = 3'd3;
	localparam SLEEPING_R = 3'd4;
	
	reg [1:0] curr_state, next_state;

	reg [3:0] RJ_L_counter;
	reg [8:0] COEFF_L_counter;
	reg [7:0] DATA_L_counter;

	reg [3:0] RJ_R_counter;
	reg [8:0] COEFF_R_counter;
	reg [7:0] DATA_R_counter;

	//reg [7:0] RJ_R_DATA;
	reg [8:0] COEFF_R_LAST_POS;
	reg [8:0] RJ_R_Pos_counter;
	//reg [8:0] COEFF_R_DATA;
	//reg [15:0] DATA_R_DATA;
	
	always @(posedge SCLK) begin
			curr_state <= next_state;
	end

	always @(*) begin
		case (curr_state)
			INIT_R: begin //STATE 0
				if(EN_FIR)
					next_state = READ_DATA_R;
				else
					next_state = INIT_R;
			end

			READ_DATA_R: begin //STATE 1
				if(EN_FIR)
					next_state = READ_RJ_R;
				else
					next_state = SLEEPING_R;
			end
			
			READ_RJ_R: begin //STATE 2
				if(EN_FIR)
					if(RJ_R_counter == 15 && COEFF_R_counter == 0)
						next_state = READ_DATA_R;
					else
						next_state = READ_COEFF_R;
				else
					next_state = SLEEPING_R;
			end

			READ_COEFF_R: begin //STATE 3
				if(EN_FIR)
					if(COEFF_R_counter == (RJ_R_Pos_counter + RJ_DATA_R))
						next_state = READ_RJ_R;
					else
						next_state = READ_COEFF_R;
				else
					next_state = SLEEPING_R;
			end
			
			SLEEPING_R: begin //STATE 4
				if(EN_FIR)
					next_state = READ_DATA_R;
				else
					next_state = SLEEPING_R;
			end
			default: next_state = INIT_R;
		endcase
	end

	always @(*) begin
		case (curr_state)
			INIT_R: begin //STATE 0
				CLEAR_PISO_R <= 1;
				LOAD_PISO_R <= 0;
				PISO_EN_R <= 0;

				CLEAR_SHIFT_REG_R <= 1;
				LOAD_SHIFT_REG_R <= 0;
				SHIFT_R <= 0;
				ADDSUBTRACT_R <= 0;
				
				DATA_READ_ADDRESS_R <= 8'd0;
				DATA_READ_EN_R <= 0;
				DATA_R_counter <= 8'd0;
				//DATA_R_DATA <= 0;
				
				RJ_READ_ADDRESS_R <= 4'd0;
				RJ_READ_EN_R <= 0;
				RJ_R_counter <= 4'd0;
				RJ_R_Pos_counter <= 0;
				//RJ_R_DATA <= 0;

				COEFF_READ_ADDRESS_R <= 9'd0;
				COEFF_READ_EN_R <= 0;
				COEFF_R_counter <= 9'd0;
				//COEFF_R_DATA <= 0;
				COEFF_R_LAST_POS <= 0;
			end

			READ_DATA_R: begin //STATE 1
				CLEAR_SHIFT_REG_R <= 0;
				CLEAR_PISO_R <= 0;

				DATA_READ_EN_R <= 1;
				DATA_READ_ADDRESS_R <= DATA_R_counter;
				
				SHIFT_R <= 0;
			end

			READ_RJ_R: begin //STATE 2
				DATA_READ_EN_R <= 0;

				RJ_READ_ADDRESS_R <= RJ_R_counter;
				RJ_READ_EN_R <= 1;

				COEFF_READ_EN_R <= 0;

				SHIFT_R <= 1;
				LOAD_SHIFT_REG_R <= 0;

			end

			READ_COEFF_R: begin //STATE 3
				RJ_READ_EN_R <= 0;

				COEFF_READ_EN_R <= 1;
				COEFF_READ_ADDRESS_R <= COEFF_R_counter;

				SHIFT_R <= 0;
				LOAD_SHIFT_REG_R <= 0;

				if((DATA_R_counter - COEFF_DATA_R[7:0]) >= 0) begin
					DATA_READ_ADDRESS_R <= (DATA_R_counter - COEFF_DATA_R[7:0]);
					DATA_READ_EN_R <= 1;
					LOAD_SHIFT_REG_R <= 1;
					SHIFT_R <= 1;
					if(COEFF_DATA_R[8] == 1) begin
						ADDSUBTRACT_R <= 1;
					end else if (COEFF_DATA_R[8] == 0) begin
						ADDSUBTRACT_R <= 0;
					end
				end
			end
		endcase
	end

	always @(posedge SCLK) begin
		case(curr_state)
			INIT_R: begin //STATE 0

			end

			READ_DATA_R: begin //STATE 1
				//DATA_R_counter <= DATA_R_counter + 1;
			end

			READ_RJ_R: begin //STATE 2
				RJ_R_counter <= RJ_R_counter + 1;
				RJ_R_Pos_counter <= RJ_R_Pos_counter + RJ_DATA_R;
			end

			READ_COEFF_R: begin //STATE 3
				COEFF_R_counter <= COEFF_R_counter + 1;
				
			end
		endcase
	end
endmodule
