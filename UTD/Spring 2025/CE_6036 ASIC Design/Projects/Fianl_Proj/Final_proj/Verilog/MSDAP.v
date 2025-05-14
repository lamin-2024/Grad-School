module MSDAP(
  input Sclk, Dclk,
  input Start, Reset_n, Frame, InputL, InputR,
  output InReady, OutReady, OutputL, OutputR
);
  wire uni_reset_n;  
  assign uni_reset_n = ~(Start | ~Reset_n);
  
  // Serail to Parallel Converter
  wire in_data_ready,all_zero;
  wire [15:0] in_data_L, in_data_R;
  // Main Control
  wire Frame_sync,in_data_ready_sync;
  wire ALU_calc, mem_clear_data, mem_R_en, mem_Co_en, mem_In_en, mem_r0w1;
  wire [8:0] main_ctrl_mem_addr;
  wire [7:0] input_cnt;
  // Memory
  reg [3:0] R_mem_L_addr, R_mem_R_addr;
  wire [7:0] R_mem_L_data, R_mem_R_data;
  reg [8:0] Co_mem_L_addr, Co_mem_R_addr;
  wire [8:0] Co_mem_L_data, Co_mem_R_data;
  reg [7:0] Data_mem_L_addr, Data_mem_R_addr;
  wire [15:0] Data_mem_L_data, Data_mem_R_data;
  // ALU
  wire [3:0] ALU_R_mem_L_addr, ALU_R_mem_R_addr;
  wire [8:0] ALU_Co_mem_L_addr, ALU_Co_mem_R_addr;
  wire [7:0] ALU_Data_mem_L_addr, ALU_Data_mem_R_addr;
  wire ppl_stall_L,ppl_stall_R, ALU_finish_L, ALU_finish_R;
  wire [39:0] ALU_out_L, ALU_out_R;
  
  // Serail to Parallel Converter
  SERIAL_2_PARALLEL s2p(
    .Dclk(Dclk), .uni_reset_n(uni_reset_n), .Frame(Frame), .InputL(InputL), .InputR(InputR),
    .in_data_ready(in_data_ready), .all_zero(all_zero), .in_data_L(in_data_L), .in_data_R(in_data_R)
  );
  
  // Synchronizers
  SYNC Frame_sync_u(.clk(Sclk), .uni_reset_n(uni_reset_n), .sync_in(Frame), .sync_out(Frame_sync));
  SYNC in_data_ready_sync_u(.clk(Sclk), .uni_reset_n(uni_reset_n), .sync_in(in_data_ready), .sync_out(in_data_ready_sync));
  
  // Main Control
  MAIN_CTRL main_control(
    .Sclk(Sclk), .Start(Start), .Reset_n(Reset_n), .Frame_sync(Frame_sync), .all_zero(all_zero), .in_data_ready_sync(in_data_ready_sync),
    .InReady(InReady), .ALU_calc(ALU_calc), .mem_clear_data(mem_clear_data), .mem_R_en(mem_R_en), .mem_Co_en(mem_Co_en), .mem_In_en(mem_In_en), .mem_r0w1(mem_r0w1), .mem_addr(main_ctrl_mem_addr)
  );
  assign input_cnt = main_ctrl_mem_addr[7:0];

  // Memories
  always@(mem_r0w1, main_ctrl_mem_addr, ALU_R_mem_L_addr, ALU_R_mem_R_addr, ALU_Co_mem_L_addr, ALU_Co_mem_R_addr, ALU_Data_mem_L_addr, ALU_Data_mem_R_addr) begin
    if(~mem_r0w1) begin
      R_mem_L_addr = ALU_R_mem_L_addr;      R_mem_R_addr = ALU_R_mem_R_addr;
      Co_mem_L_addr = ALU_Co_mem_L_addr;    Co_mem_R_addr = ALU_Co_mem_R_addr;
      Data_mem_L_addr = ALU_Data_mem_L_addr;Data_mem_R_addr = ALU_Data_mem_R_addr;
    end
    else begin
      R_mem_L_addr = main_ctrl_mem_addr[3:0];   R_mem_R_addr = main_ctrl_mem_addr[3:0];
      Co_mem_L_addr = main_ctrl_mem_addr;       Co_mem_R_addr = main_ctrl_mem_addr;
      Data_mem_L_addr = main_ctrl_mem_addr[7:0];Data_mem_R_addr = main_ctrl_mem_addr[7:0];
    end
  end
  
  wire mem_Co_en_L,mem_Co_en_R, mem_In_en_L,mem_In_en_R;
  assign mem_Co_en_L= mem_Co_en & ~ppl_stall_L;
  assign mem_Co_en_R= mem_Co_en & ~ppl_stall_R;
  assign mem_In_en_L= mem_In_en & ~ppl_stall_L; 
  assign mem_In_en_R= mem_In_en & ~ppl_stall_R;

  R_MEM R_mem_L(.RW0_clk(Sclk), .RW0_addr(R_mem_L_addr), .RW0_wdata(in_data_L[7:0] & {8{~mem_clear_data}}), .RW0_rdata(R_mem_L_data), .RW0_en(mem_R_en), .RW0_wmode(mem_r0w1));
  R_MEM R_mem_R(.RW0_clk(Sclk), .RW0_addr(R_mem_R_addr), .RW0_wdata(in_data_R[7:0] & {8{~mem_clear_data}}), .RW0_rdata(R_mem_R_data), .RW0_en(mem_R_en), .RW0_wmode(mem_r0w1));
  CO_MEM Co_mem_L(.RW0_clk(Sclk), .RW0_addr(Co_mem_L_addr), .RW0_wdata(in_data_L[8:0] & {9{~mem_clear_data}}), .RW0_rdata(Co_mem_L_data), .RW0_en(mem_Co_en_L), .RW0_wmode(mem_r0w1));
  CO_MEM Co_mem_R(.RW0_clk(Sclk), .RW0_addr(Co_mem_R_addr), .RW0_wdata(in_data_R[8:0] & {9{~mem_clear_data}}), .RW0_rdata(Co_mem_R_data), .RW0_en(mem_Co_en_R), .RW0_wmode(mem_r0w1));
  DATA_MEM Data_mem_L(.RW0_clk(Sclk), .RW0_addr(Data_mem_L_addr), .RW0_wdata(in_data_L & {16{~mem_clear_data}}), .RW0_rdata(Data_mem_L_data), .RW0_en(mem_In_en_L), .RW0_wmode(mem_r0w1));
  DATA_MEM Data_mem_R(.RW0_clk(Sclk), .RW0_addr(Data_mem_R_addr), .RW0_wdata(in_data_R & {16{~mem_clear_data}}), .RW0_rdata(Data_mem_R_data), .RW0_en(mem_In_en_R), .RW0_wmode(mem_r0w1));
  
  //ALU
  ALU ALU_L(.Sclk(Sclk), .uni_reset_n(uni_reset_n), .ALU_calc(ALU_calc), .input_cnt(input_cnt), .ppl_stall(ppl_stall_L), .ALU_finish(ALU_finish_L), .output_data(ALU_out_L), 
            .R_mem_data(R_mem_L_data), .Co_mem_data(Co_mem_L_data), .Data_mem_data(Data_mem_L_data), .R_mem_addr(ALU_R_mem_L_addr), .Co_mem_addr(ALU_Co_mem_L_addr), .Data_mem_addr(ALU_Data_mem_L_addr));
  ALU ALU_R(.Sclk(Sclk), .uni_reset_n(uni_reset_n), .ALU_calc(ALU_calc), .input_cnt(input_cnt), .ppl_stall(ppl_stall_R), .ALU_finish(ALU_finish_R), .output_data(ALU_out_R), 
            .R_mem_data(R_mem_R_data), .Co_mem_data(Co_mem_R_data), .Data_mem_data(Data_mem_R_data), .R_mem_addr(ALU_R_mem_R_addr), .Co_mem_addr(ALU_Co_mem_R_addr), .Data_mem_addr(ALU_Data_mem_R_addr));
  
  // Serail to Parallel Converter
  PARALLEL_2_SERIAL p2s(.Sclk(Sclk), .uni_reset_n(uni_reset_n), .ALU_finish_L(ALU_finish_L), .ALU_finish_R(ALU_finish_R), .ALU_out_L(ALU_out_L), .ALU_out_R(ALU_out_R), .OutReady(OutReady), .OutputL(OutputL), .OutputR(OutputR));
endmodule

