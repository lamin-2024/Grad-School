`timescale 1ns / 1ps

module ALU_Controller_tb;

  reg clk, reset, en_fir;
  reg [7:0]  rj_L_data, rj_R_data;
  reg [15:0] coeff_L_data, coeff_R_data;
  reg done_shifting;

  wire        clear, clear_reg, load_adder, load_shift, shift;
  wire [7:0]  read_addr_data_L, read_addr_data_R;
  wire [3:0]  read_addr_rj_L, read_addr_rj_R;
  wire [4:0]  read_addr_coeff_L, read_addr_coeff_R;

  // Instantiate DUT
  ALU_Controller uut (
    .clk(clk),
    .reset(reset),
    .en_fir(en_fir),
    .rj_L_data(rj_L_data),
    .rj_R_data(rj_R_data),
    .coeff_L_data(coeff_L_data),
    .coeff_R_data(coeff_R_data),
    .done_shifting(done_shifting),
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
    .read_addr_coeff_R(read_addr_coeff_R)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    // Initial state
    clk = 0;
    reset = 1;
    en_fir = 0;
    rj_L_data = 8'd2;      // 2 taps
    rj_R_data = 8'd2;
    coeff_L_data = 16'h0001; // delay = 1
    coeff_R_data = 16'h0001;
    done_shifting = 0;

    // Reset pulse
    #10 reset = 0;

    // Start FIR operation
    #10 en_fir = 1;
    #10 en_fir = 0;

    // Simulate shifter done after CALC_INDEX → SHIFT → WAIT
    repeat (3) begin
      wait (load_shift);
      #10 done_shifting = 1;
      #10 done_shifting = 0;
    end

    // Allow more cycles to show control progression
    #100;
    $finish;
  end

  // Optional FSM output monitoring
  initial begin
    $monitor("T=%0t | clr=%b load_add=%b load_shf=%b shift=%b RJ_L=%d COEFF_L=%d DATA_L_ADDR=%d",
      $time, clear, load_adder, load_shift, shift,
      read_addr_rj_L, read_addr_coeff_L, read_addr_data_L);
  end

endmodule
