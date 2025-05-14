// Code your testbench here
// or browse Examples
module ALU (
    input  wire        clk,
    input  wire        reset,
    input  wire        en_fir,

    input  wire [15:0] data_memory_in_L,
    input  wire [15:0] data_memory_in_R,
    input  wire [7:0]  rj_L_data,
    input  wire [7:0]  rj_R_data,
    input  wire [15:0] coeff_L_data,
    input  wire [15:0] coeff_R_data,

    output wire [39:0] shift_outL,
    output wire [39:0] shift_outR,
    output wire        done_shifting
);

    wire [23:0] sign_ext_L, sign_ext_R;
    wire [23:0] adder_out_L, adder_out_R;

    wire clear, clear_reg, load_adder, load_shift, shift;
    wire [3:0] read_addr_rj_L, read_addr_rj_R;
    wire [4:0] read_addr_coeff_L, read_addr_coeff_R;
    wire [7:0] read_addr_data_L, read_addr_data_R;

    // Sign Extension
    SignExtender sign_ext (
        .datain({data_memory_in_L, data_memory_in_R}),
        .dataout_L(sign_ext_L),
        .dataout_R(sign_ext_R)
    );

    // Adder
    Adder adder (
        .dataout_L(sign_ext_L),
        .shift_outL(shift_outL[39:16]),
        .add_sub_L(1'b0),
        .adder_outL(adder_out_L),
        .dataout_R(sign_ext_R),
        .shift_outR(shift_outR[39:16]),
        .add_sub_R(1'b0),
        .adder_outR(adder_out_R)
    );

    // Shift Register
    ShiftRightRegister shift_reg (
        .clk(clk),
        .reset(reset),
        .load(load_shift),
        .adder_outL(adder_out_L),
        .adder_outR(adder_out_R),
        .shift_outL(shift_outL),
        .shift_outR(shift_outR),
        .done_shifting(done_shifting)
    );

    // Controller
    ALU_Controller controller (
        .clk(clk),
        .reset(reset),
        .en_fir(en_fir),
        .rj_L_data(rj_L_data),
        .rj_R_data(rj_R_data),
        .coeff_L_data(coeff_L_data),
        .coeff_R_data(coeff_R_data),
        .clear(clear),
        .clear_reg(clear_reg),
        .load_adder(load_adder),
        .load_shift(load_shift),
        .shift(shift),
        .read_addr_data_L(read_addr_data_L),
        .read_addr_data_R(read_addr_data_R),
        .read_addr_rj_L(read_addr_rj_L),
        .read_addr_rj_R(read_addr_rj_R),
        .read_addr_coeff_L(read_addr_coeff_L),
        .read_addr_coeff_R(read_addr_coeff_R),
        .done_shifting(done_shifting)
    );

endmodule

module ALU_Controller (
    input  wire        clk,
    input  wire        reset,
    input  wire        en_fir,
    input  wire [7:0]  rj_L_data,
    input  wire [7:0]  rj_R_data,
    input  wire [15:0] coeff_L_data,
    input  wire [15:0] coeff_R_data,
    input  wire        done_shifting,

    output reg         clear,
    output reg         clear_reg,
    output reg         load_adder,
    output reg         load_shift,
    output reg         shift,

    output reg  [7:0]  read_addr_data_L,
    output reg  [7:0]  read_addr_data_R,
    output reg  [3:0]  read_addr_rj_L,
    output reg  [3:0]  read_addr_rj_R,
    output reg  [4:0]  read_addr_coeff_L,
    output reg  [4:0]  read_addr_coeff_R
);

    // FSM state definitions
    reg [2:0] state, next_state;
    localparam IDLE            = 3'd0,
               LOAD_RJ         = 3'd1,
               LOAD_COEFF      = 3'd2,
               CALC_INDEX      = 3'd3,
               SHIFT_DATA      = 3'd4,
               WAIT_SHIFT_DONE = 3'd5,
               INCREMENT       = 3'd6,
               DONE            = 3'd7;

    // Internal registers
    reg [9:0] n_L, n_R;
    reg [3:0] tap_L, tap_R;
    reg [4:0] coeff_L_count, coeff_R_count;
    reg [7:0] rj_L_value, rj_R_value;
    reg [7:0] coeff_delay_L, coeff_delay_R;
    reg signed [8:0] index_L, index_R;

    // Sequential logic: FSM state and counters
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            n_L <= 0; n_R <= 0;
            tap_L <= 0; tap_R <= 0;
            coeff_L_count <= 0; coeff_R_count <= 0;
            rj_L_value <= 0; rj_R_value <= 0;
            coeff_delay_L <= 0; coeff_delay_R <= 0;
            index_L <= 0; index_R <= 0;
        end else begin
            state <= next_state;

            case (state)
                LOAD_RJ: begin
                    rj_L_value <= rj_L_data;
                    rj_R_value <= rj_R_data;
                end

                LOAD_COEFF: begin
                    coeff_delay_L <= coeff_L_data[7:0];
                    coeff_delay_R <= coeff_R_data[7:0];
                end

                CALC_INDEX: begin
                    index_L <= n_L - coeff_delay_L;
                    index_R <= n_R - coeff_delay_R;
                end

                INCREMENT: begin
                    // LEFT loop logic
                    if (coeff_L_count < rj_L_value - 1)
                        coeff_L_count <= coeff_L_count + 1;
                    else begin
                        coeff_L_count <= 0;
                        if (tap_L < 15)
                            tap_L <= tap_L + 1;
                        else begin
                            tap_L <= 0;
                            if (n_L < 999)
                                n_L <= n_L + 1;
                        end
                    end

                    // RIGHT loop logic
                    if (coeff_R_count < rj_R_value - 1)
                        coeff_R_count <= coeff_R_count + 1;
                    else begin
                        coeff_R_count <= 0;
                        if (tap_R < 15)
                            tap_R <= tap_R + 1;
                        else begin
                            tap_R <= 0;
                            if (n_R < 999)
                                n_R <= n_R + 1;
                        end
                    end
                end
            endcase
        end
    end

    // Combinational FSM logic
    always @(*) begin
        // Default outputs
        clear = 0;
        clear_reg = 0;
        load_adder = 0;
        load_shift = 0;
        shift = 0;

        read_addr_rj_L = tap_L;
        read_addr_rj_R = tap_R;
        read_addr_coeff_L = coeff_L_count;
        read_addr_coeff_R = coeff_R_count;
        read_addr_data_L = 8'd0;
        read_addr_data_R = 8'd0;

        next_state = state;

        case (state)
            IDLE: begin
                if (en_fir) begin
                    clear = 1;
                    clear_reg = 1;
                    next_state = LOAD_RJ;
                end
            end

            LOAD_RJ: begin
                next_state = LOAD_COEFF;
            end

            LOAD_COEFF: begin
                next_state = CALC_INDEX;
            end

            CALC_INDEX: begin
                load_adder = 1;
                read_addr_data_L = index_L[7:0];
                read_addr_data_R = index_R[7:0];
                next_state = SHIFT_DATA;
            end

            SHIFT_DATA: begin
                load_shift = 1;
                next_state = WAIT_SHIFT_DONE;
            end

            WAIT_SHIFT_DONE: begin
                if (done_shifting)
                    next_state = INCREMENT;
            end

            INCREMENT: begin
                if (n_L >= 999 && n_R >= 999)
                    next_state = DONE;
                else
                    next_state = LOAD_RJ;
            end

            DONE: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule



module SignExtender (
  input  wire [31:0] datain,
  output wire [23:0] dataout_L,
  output wire [23:0] dataout_R
);
  // Sign-extend left half (bits 31:16) using bit 31
  assign dataout_L = {{8{datain[31]}}, datain[31:16]};

  // Sign-extend right half (bits 15:0) using bit 15
  assign dataout_R = {{8{datain[15]}}, datain[15:0]};
endmodule


//adder is been updated to do add on both Left and Right 
module Adder (
  //Left side of the adder
  input  wire [23:0] dataout_L,
  input  wire [23:0] shift_outL,
  input  wire        add_sub_L, // 0: add, 1: subtract
  output wire [23:0] adder_outL,
  
  //Right side of the adder
  input  wire [23:0] dataout_R,
  input  wire [23:0] shift_outR,
  input  wire        add_sub_R, // 0: add, 1: subtract
  output wire [23:0] adder_outR
);
    assign adder_outL = add_sub_L ? (shift_outL - dataout_L) : (shift_outL + dataout_L);
    assign adder_outR = add_sub_R ? (shift_outR - dataout_R) : (shift_outR + dataout_R);
endmodule



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


//Testbench for ALU_Top Module
// Code your testbench here
// or browse Examples
module ALU (
    input  wire        clk,
    input  wire        reset,
    input  wire        en_fir,

    input  wire [15:0] data_memory_in_L,
    input  wire [15:0] data_memory_in_R,
    input  wire [7:0]  rj_L_data,
    input  wire [7:0]  rj_R_data,
    input  wire [15:0] coeff_L_data,
    input  wire [15:0] coeff_R_data,

    output wire [39:0] shift_outL,
    output wire [39:0] shift_outR,
    output wire        done_shifting
);

    wire [23:0] sign_ext_L, sign_ext_R;
    wire [23:0] adder_out_L, adder_out_R;

    wire clear, clear_reg, load_adder, load_shift, shift;
    wire [3:0] read_addr_rj_L, read_addr_rj_R;
    wire [4:0] read_addr_coeff_L, read_addr_coeff_R;
    wire [7:0] read_addr_data_L, read_addr_data_R;

    // Sign Extension
    SignExtender sign_ext (
        .datain({data_memory_in_L, data_memory_in_R}),
        .dataout_L(sign_ext_L),
        .dataout_R(sign_ext_R)
    );

    // Adder
    Adder adder (
        .dataout_L(sign_ext_L),
        .shift_outL(shift_outL[39:16]),
        .add_sub_L(1'b0),
        .adder_outL(adder_out_L),
        .dataout_R(sign_ext_R),
        .shift_outR(shift_outR[39:16]),
        .add_sub_R(1'b0),
        .adder_outR(adder_out_R)
    );

    // Shift Register
    ShiftRightRegister shift_reg (
        .clk(clk),
        .reset(reset),
        .load(load_shift),
        .adder_outL(adder_out_L),
        .adder_outR(adder_out_R),
        .shift_outL(shift_outL),
        .shift_outR(shift_outR),
        .done_shifting(done_shifting)
    );

    // Controller
    ALU_Controller controller (
        .clk(clk),
        .reset(reset),
        .en_fir(en_fir),
        .rj_L_data(rj_L_data),
        .rj_R_data(rj_R_data),
        .coeff_L_data(coeff_L_data),
        .coeff_R_data(coeff_R_data),
        .clear(clear),
        .clear_reg(clear_reg),
        .load_adder(load_adder),
        .load_shift(load_shift),
        .shift(shift),
        .read_addr_data_L(read_addr_data_L),
        .read_addr_data_R(read_addr_data_R),
        .read_addr_rj_L(read_addr_rj_L),
        .read_addr_rj_R(read_addr_rj_R),
        .read_addr_coeff_L(read_addr_coeff_L),
        .read_addr_coeff_R(read_addr_coeff_R),
        .done_shifting(done_shifting)
    );

endmodule

module ALU_Controller (
    input  wire        clk,
    input  wire        reset,
    input  wire        en_fir,
    input  wire [7:0]  rj_L_data,
    input  wire [7:0]  rj_R_data,
    input  wire [15:0] coeff_L_data,
    input  wire [15:0] coeff_R_data,
    input  wire        done_shifting,

    output reg         clear,
    output reg         clear_reg,
    output reg         load_adder,
    output reg         load_shift,
    output reg         shift,

    output reg  [7:0]  read_addr_data_L,
    output reg  [7:0]  read_addr_data_R,
    output reg  [3:0]  read_addr_rj_L,
    output reg  [3:0]  read_addr_rj_R,
    output reg  [4:0]  read_addr_coeff_L,
    output reg  [4:0]  read_addr_coeff_R
);

    // FSM state definitions
    reg [2:0] state, next_state;
    localparam IDLE            = 3'd0,
               LOAD_RJ         = 3'd1,
               LOAD_COEFF      = 3'd2,
               CALC_INDEX      = 3'd3,
               SHIFT_DATA      = 3'd4,
               WAIT_SHIFT_DONE = 3'd5,
               INCREMENT       = 3'd6,
               DONE            = 3'd7;

    // Internal registers
    reg [9:0] n_L, n_R;
    reg [3:0] tap_L, tap_R;
    reg [4:0] coeff_L_count, coeff_R_count;
    reg [7:0] rj_L_value, rj_R_value;
    reg [7:0] coeff_delay_L, coeff_delay_R;
    reg signed [8:0] index_L, index_R;

    // Sequential logic: FSM state and counters
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            n_L <= 0; n_R <= 0;
            tap_L <= 0; tap_R <= 0;
            coeff_L_count <= 0; coeff_R_count <= 0;
            rj_L_value <= 0; rj_R_value <= 0;
            coeff_delay_L <= 0; coeff_delay_R <= 0;
            index_L <= 0; index_R <= 0;
        end else begin
            state <= next_state;

            case (state)
                LOAD_RJ: begin
                    rj_L_value <= rj_L_data;
                    rj_R_value <= rj_R_data;
                end

                LOAD_COEFF: begin
                    coeff_delay_L <= coeff_L_data[7:0];
                    coeff_delay_R <= coeff_R_data[7:0];
                end

                CALC_INDEX: begin
                    index_L <= n_L - coeff_delay_L;
                    index_R <= n_R - coeff_delay_R;
                end

                INCREMENT: begin
                    // LEFT loop logic
                    if (coeff_L_count < rj_L_value - 1)
                        coeff_L_count <= coeff_L_count + 1;
                    else begin
                        coeff_L_count <= 0;
                        if (tap_L < 15)
                            tap_L <= tap_L + 1;
                        else begin
                            tap_L <= 0;
                            if (n_L < 999)
                                n_L <= n_L + 1;
                        end
                    end

                    // RIGHT loop logic
                    if (coeff_R_count < rj_R_value - 1)
                        coeff_R_count <= coeff_R_count + 1;
                    else begin
                        coeff_R_count <= 0;
                        if (tap_R < 15)
                            tap_R <= tap_R + 1;
                        else begin
                            tap_R <= 0;
                            if (n_R < 999)
                                n_R <= n_R + 1;
                        end
                    end
                end
            endcase
        end
    end

    // Combinational FSM logic
    always @(*) begin
        // Default outputs
        clear = 0;
        clear_reg = 0;
        load_adder = 0;
        load_shift = 0;
        shift = 0;

        read_addr_rj_L = tap_L;
        read_addr_rj_R = tap_R;
        read_addr_coeff_L = coeff_L_count;
        read_addr_coeff_R = coeff_R_count;
        read_addr_data_L = 8'd0;
        read_addr_data_R = 8'd0;

        next_state = state;

        case (state)
            IDLE: begin
                if (en_fir) begin
                    clear = 1;
                    clear_reg = 1;
                    next_state = LOAD_RJ;
                end
            end

            LOAD_RJ: begin
                next_state = LOAD_COEFF;
            end

            LOAD_COEFF: begin
                next_state = CALC_INDEX;
            end

            CALC_INDEX: begin
                load_adder = 1;
                read_addr_data_L = index_L[7:0];
                read_addr_data_R = index_R[7:0];
                next_state = SHIFT_DATA;
            end

            SHIFT_DATA: begin
                load_shift = 1;
                next_state = WAIT_SHIFT_DONE;
            end

            WAIT_SHIFT_DONE: begin
                if (done_shifting)
                    next_state = INCREMENT;
            end

            INCREMENT: begin
                if (n_L >= 999 && n_R >= 999)
                    next_state = DONE;
                else
                    next_state = LOAD_RJ;
            end

            DONE: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule



module SignExtender (
  input  wire [31:0] datain,
  output wire [23:0] dataout_L,
  output wire [23:0] dataout_R
);
  // Sign-extend left half (bits 31:16) using bit 31
  assign dataout_L = {{8{datain[31]}}, datain[31:16]};

  // Sign-extend right half (bits 15:0) using bit 15
  assign dataout_R = {{8{datain[15]}}, datain[15:0]};
endmodule


//adder is been updated to do add on both Left and Right 
module Adder (
  //Left side of the adder
  input  wire [23:0] dataout_L,
  input  wire [23:0] shift_outL,
  input  wire        add_sub_L, // 0: add, 1: subtract
  output wire [23:0] adder_outL,
  
  //Right side of the adder
  input  wire [23:0] dataout_R,
  input  wire [23:0] shift_outR,
  input  wire        add_sub_R, // 0: add, 1: subtract
  output wire [23:0] adder_outR
);
    assign adder_outL = add_sub_L ? (shift_outL - dataout_L) : (shift_outL + dataout_L);
    assign adder_outR = add_sub_R ? (shift_outR - dataout_R) : (shift_outR + dataout_R);
endmodule



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
