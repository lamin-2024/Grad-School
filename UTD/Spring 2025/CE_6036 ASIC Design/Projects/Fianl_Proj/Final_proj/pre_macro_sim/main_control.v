module MAIN_CTRL(
  input Sclk, Start, Reset_n, Frame_sync, 
  input all_zero, 
  input in_data_ready_sync,//Synchronized
  output reg InReady,
  output ALU_calc,
  output reg mem_clear_data, mem_R_en, mem_Co_en, mem_In_en, mem_r0w1, 
  output [8:0] mem_addr
  //output [7:0] input_cnt
);
  parameter INIT=0;
  parameter WAIT_R=1;
  parameter READ_R=2;
  parameter WAIT_CO=3;
  parameter READ_CO=4;
  parameter WAIT_IN=5;
  parameter WORK=6;
  parameter CLEAR=7;
  parameter SLEEP=8;
  
  
  reg [3:0] state, next_state;
  reg ctrl_incr_addr, ctrl_reset_addr, ctrl_reset_zero_cnt, ctrl_incr_zero_cnt;
  
  reg [9:0] addr_iter, zero_cnt;
  reg in_data_ready_d0;
  wire in_data_ready_pules;
  
  // FSM control signal
  always@(state, Frame_sync, addr_iter, in_data_ready_pules, all_zero, zero_cnt) begin
    case(state)
      INIT: begin
        ctrl_incr_addr = 1;
        ctrl_reset_addr = 0;
        ctrl_incr_zero_cnt = 'bX;
        ctrl_reset_zero_cnt = 1;
        {mem_R_en, mem_Co_en, mem_In_en} = 'b111;
        mem_r0w1 = 1;
        mem_clear_data = 1;
        InReady = 0;
        if('h1FF == addr_iter)
          next_state = WAIT_R;
       	else
		      next_state = INIT;
      end
      WAIT_R: begin
        ctrl_incr_addr = 0;
        ctrl_reset_addr = 1;
        ctrl_incr_zero_cnt = 'bX;
        ctrl_reset_zero_cnt = 1;
        {mem_R_en, mem_Co_en, mem_In_en} = 'b000;
        mem_r0w1 = 0;
        mem_clear_data = 0;
        InReady = 1;
        if(Frame_sync)
          next_state = READ_R;
        else
          next_state = WAIT_R;
      end
      READ_R: begin
        ctrl_incr_addr = in_data_ready_pules;
        ctrl_reset_addr = 0;
        ctrl_incr_zero_cnt = 'bX;
        ctrl_reset_zero_cnt = 1;
        {mem_R_en, mem_Co_en, mem_In_en} = {in_data_ready_pules, 1'b0, 1'b0};
        mem_r0w1 = 1;
        mem_clear_data = 0;
        InReady = 1;
        if(16 == addr_iter)
          next_state = WAIT_CO;
       	else
		      next_state = READ_R;
      end
      WAIT_CO: begin
        ctrl_incr_addr = 0;
        ctrl_reset_addr = 1;
        ctrl_incr_zero_cnt = 'bX;
        ctrl_reset_zero_cnt = 1;
        {mem_R_en, mem_Co_en, mem_In_en} = 'b000;
        mem_r0w1 = 0;
        mem_clear_data = 0;
        InReady = 1;
        if(Frame_sync)
          next_state = READ_CO;
        else
          next_state = WAIT_CO;
      end
      READ_CO: begin
        ctrl_incr_addr = in_data_ready_pules;
        ctrl_reset_addr = 0;
        ctrl_incr_zero_cnt = 'bX;
        ctrl_reset_zero_cnt = 1;
        {mem_R_en, mem_Co_en, mem_In_en} = {1'b0, in_data_ready_pules, 1'b0};
        mem_r0w1 = 1;
        mem_clear_data = 0;
        InReady = 1;
        if(512 == addr_iter)
          next_state = WAIT_IN;
       	else
		      next_state = READ_CO;
      end
      WAIT_IN: begin
        ctrl_incr_addr = 0;
        ctrl_reset_addr = 1;
        ctrl_incr_zero_cnt = 'bX;
        ctrl_reset_zero_cnt = 1; 
        {mem_R_en, mem_Co_en, mem_In_en} = 'b000;
        mem_r0w1 = 0;
        mem_clear_data = 0;
        InReady = 1;
        if(Frame_sync)
          next_state = WORK;
        else
          next_state = WAIT_IN;
      end
      WORK: begin
        ctrl_incr_addr = in_data_ready_pules;
        ctrl_reset_addr = 0;
        ctrl_incr_zero_cnt = in_data_ready_pules & all_zero;
        ctrl_reset_zero_cnt = in_data_ready_pules & ~all_zero;
        {mem_R_en, mem_Co_en, mem_In_en} = {{2{~in_data_ready_pules}}, 1'b1};
        mem_r0w1 = in_data_ready_pules;
        mem_clear_data = 0;
        InReady = 1;
        if(800 == zero_cnt)
          next_state = SLEEP;
       	else
		      next_state = WORK;
      end
      CLEAR: begin
        ctrl_incr_addr = 1;
        ctrl_reset_addr = 0;
        ctrl_incr_zero_cnt = 'bX;
        ctrl_reset_zero_cnt = 1;
        {mem_R_en, mem_Co_en, mem_In_en} = 3'b001;
        mem_r0w1 = 1;
        mem_clear_data = 1;
        InReady = 0;
        if('hFF == addr_iter)
          next_state = WAIT_IN;
       	else
		      next_state = CLEAR;
      end
      SLEEP: begin
        ctrl_incr_addr = in_data_ready_pules;
        ctrl_reset_addr = 0;
        ctrl_incr_zero_cnt = 0;
        ctrl_reset_zero_cnt = in_data_ready_pules & ~all_zero;
        {mem_R_en, mem_Co_en, mem_In_en} = {{2{~in_data_ready_pules}}, ~all_zero};
        mem_r0w1 = in_data_ready_pules;
        mem_clear_data = 0;
        InReady = 1;
        if(in_data_ready_pules & ~all_zero)
          next_state = WORK;
       	else
		      next_state = SLEEP;
      end
      default: begin
        ctrl_incr_addr = 'bX;
        ctrl_reset_addr = 'bX;
        ctrl_incr_zero_cnt = 'bX;
        ctrl_reset_zero_cnt = 'bX;
        {mem_R_en, mem_Co_en, mem_In_en} = 'bXXX;
        mem_r0w1 = 'bX;
        mem_clear_data = 'bX;
        InReady = 'bX;
        next_state = INIT;
      end
    endcase
  end
  
  assign mem_addr = addr_iter;
  assign ALU_calc = (state == WORK) & in_data_ready_pules;
  
  // State register
  always@(posedge Sclk or posedge Start) begin
    if(Start)
      state <=INIT;
    else if(~Reset_n)
      state <=CLEAR;
    else
      state <= next_state;
  end
  
  // Address iterator
  always@(posedge Sclk or posedge Start) begin
    if(Start)
      addr_iter <=0;
    else if(ctrl_reset_addr | ~Reset_n)
      addr_iter <=0;
    else if(ctrl_incr_addr)
      addr_iter <= addr_iter+1;
  end
  
  // All zero input counter
  always@(posedge Sclk or posedge Start) begin
    if(Start)
      zero_cnt <=0;
    else if(ctrl_reset_zero_cnt | ~Reset_n)
      zero_cnt <=0;
    else if(ctrl_incr_zero_cnt)
      zero_cnt <= zero_cnt+1;
  end
  
  // InDataReady delayed by 1 cycle
  always@(posedge Sclk or posedge Start) begin
    if(Start)
      in_data_ready_d0 <=0;
    else if(~Reset_n)
      in_data_ready_d0 <=0;
    else
      in_data_ready_d0 <= in_data_ready_sync;
  end
  assign in_data_ready_pules = in_data_ready_sync & ~in_data_ready_d0;
  
endmodule
