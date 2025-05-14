module R_MEM(
  input  [3:0]  RW0_addr,
  input         RW0_clk,
  input  [7:0]  RW0_wdata,
  output [7:0]  RW0_rdata,
  input         RW0_en,
  input         RW0_wmode
);
  wire [3:0] mem_0_0_A1;
  wire  mem_0_0_CE1;
  wire [7:0] mem_0_0_I1;
  wire [7:0] mem_0_0_O1;
  wire  mem_0_0_CSB1;
  wire  mem_0_0_OEB1;
  wire  mem_0_0_WEB1;
  wire [3:0] mem_0_0_A2;
  wire  mem_0_0_CE2;
  wire [7:0] mem_0_0_I2;
  wire [7:0] mem_0_0_O2;
  wire  mem_0_0_CSB2;
  wire  mem_0_0_OEB2;
  wire  mem_0_0_WEB2;
  SRAM2RW16x8 mem_0_0 (
    .A1(mem_0_0_A1),
    .CE1(mem_0_0_CE1),
    .I1(mem_0_0_I1),
    .O1(mem_0_0_O1),
    .CSB1(mem_0_0_CSB1),
    .OEB1(mem_0_0_OEB1),
    .WEB1(mem_0_0_WEB1),
    .A2(mem_0_0_A2),
    .CE2(mem_0_0_CE2),
    .I2(mem_0_0_I2),
    .O2(mem_0_0_O2),
    .CSB2(mem_0_0_CSB2),
    .OEB2(mem_0_0_OEB2),
    .WEB2(mem_0_0_WEB2)
  );
  assign RW0_rdata = mem_0_0_O1;
  assign mem_0_0_A1 = RW0_addr;
  assign mem_0_0_CE1 = RW0_clk;
  assign mem_0_0_I1 = RW0_wdata[7:0];
  assign mem_0_0_CSB1 = ~RW0_en;
  assign mem_0_0_OEB1 = ~(~RW0_wmode & RW0_en);
  assign mem_0_0_WEB1 = ~RW0_wmode;
  assign mem_0_0_A2 = RW0_addr;
  assign mem_0_0_CE2 = 'b1;
  assign mem_0_0_I2 = RW0_wdata[7:0];
  assign mem_0_0_CSB2 = 'b1;
  assign mem_0_0_OEB2 = 'b1;
  assign mem_0_0_WEB2 = 'b1;
endmodule
/*
  SRAM2RW128x32 mem_0_0 (
    .A1(mem_0_0_A1),
    .CE1(mem_0_0_CE1),
    .I1(mem_0_0_I1),
    .O1(mem_0_0_O1),
    .CSB1(mem_0_0_CSB1),
    .OEB1(mem_0_0_OEB1),
    .WEB1(mem_0_0_WEB1),
    .A2(mem_0_0_A2),
    .CE2(mem_0_0_CE2),
    .I2(mem_0_0_I2),
    .O2(mem_0_0_O2),
    .CSB2(mem_0_0_CSB2),
    .OEB2(mem_0_0_OEB2),
    .WEB2(mem_0_0_WEB2)
  );
*/