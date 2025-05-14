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
