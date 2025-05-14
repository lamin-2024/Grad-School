module DATA_MEM(
  input  [7:0]  RW0_addr,
  input         RW0_clk,
  input  [15:0] RW0_wdata,
  output [15:0] RW0_rdata,
  input         RW0_en,
  input         RW0_wmode
);
  wire [7:0] mem_0_0_A;
  wire  mem_0_0_CE;
  wire [7:0] mem_0_0_I;
  wire [7:0] mem_0_0_O;
  wire  mem_0_0_CSB;
  wire  mem_0_0_OEB;
  wire  mem_0_0_WEB;
  wire [7:0] mem_0_1_A;
  wire  mem_0_1_CE;
  wire [7:0] mem_0_1_I;
  wire [7:0] mem_0_1_O;
  wire  mem_0_1_CSB;
  wire  mem_0_1_OEB;
  wire  mem_0_1_WEB;
  SRAM1RW256x8 mem_0_0 (
    .A(mem_0_0_A),
    .CE(mem_0_0_CE),
    .I(mem_0_0_I),
    .O(mem_0_0_O),
    .CSB(mem_0_0_CSB),
    .OEB(mem_0_0_OEB),
    .WEB(mem_0_0_WEB)
  );
  SRAM1RW256x8 mem_0_1 (
    .A(mem_0_1_A),
    .CE(mem_0_1_CE),
    .I(mem_0_1_I),
    .O(mem_0_1_O),
    .CSB(mem_0_1_CSB),
    .OEB(mem_0_1_OEB),
    .WEB(mem_0_1_WEB)
  );
  assign RW0_rdata = {mem_0_1_O,mem_0_0_O};
  assign mem_0_0_A = RW0_addr;
  assign mem_0_0_CE = RW0_clk;
  assign mem_0_0_I = RW0_wdata[7:0];
  assign mem_0_0_CSB = ~RW0_en;
  assign mem_0_0_OEB = ~(~RW0_wmode & RW0_en);
  assign mem_0_0_WEB = ~RW0_wmode;
  assign mem_0_1_A = RW0_addr;
  assign mem_0_1_CE = RW0_clk;
  assign mem_0_1_I = RW0_wdata[15:8];
  assign mem_0_1_CSB = ~RW0_en;
  assign mem_0_1_OEB = ~(~RW0_wmode & RW0_en);
  assign mem_0_1_WEB = ~RW0_wmode;
endmodule