`timescale 1ns / 1ps

module ALU_tb;

    reg clk, reset, en_fir;
    reg [15:0] data_memory_in_L, data_memory_in_R;
    reg [7:0] rj_L_data, rj_R_data;
    reg [15:0] coeff_L_data, coeff_R_data;

    wire [39:0] shift_outL, shift_outR;
    wire done_shifting;

    ALU uut (
        .clk(clk),
        .reset(reset),
        .en_fir(en_fir),
        .data_memory_in_L(data_memory_in_L),
        .data_memory_in_R(data_memory_in_R),
        .rj_L_data(rj_L_data),
        .rj_R_data(rj_R_data),
        .coeff_L_data(coeff_L_data),
        .coeff_R_data(coeff_R_data),
        .shift_outL(shift_outL),
        .shift_outR(shift_outR),
        .done_shifting(done_shifting)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        reset = 1;
        en_fir = 0;

        data_memory_in_L = 16'h1234;
        data_memory_in_R = 16'hABCD;

        rj_L_data = 8'd3;
        rj_R_data = 8'd2;

        coeff_L_data = 16'h0001;
        coeff_R_data = 16'h0002;

        #20;
        reset = 0;
        en_fir = 1;

        #1000;

        $display("Shift Output L: %h", shift_outL);
        $display("Shift Output R: %h", shift_outR);
        $stop;
    end

endmodule