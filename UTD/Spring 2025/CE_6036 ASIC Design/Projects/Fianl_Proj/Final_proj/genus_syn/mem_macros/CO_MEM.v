module CO_MEM(
  input  [8:0]  RW0_addr,
  input         RW0_clk,
  input  [8:0] RW0_wdata,
  output [8:0] RW0_rdata,
  input         RW0_en,
  input         RW0_wmode
);
  wire [6:0] mem_0_0_A;
  wire  mem_0_0_CE;
  wire [11:0] mem_0_0_I;
  wire [11:0] mem_0_0_O;
  wire  mem_0_0_CSB;
  wire  mem_0_0_OEB;
  wire  mem_0_0_WEB; //
  wire [6:0] mem_0_1_A;
  wire  mem_0_1_CE;
  wire [11:0] mem_0_1_I;
  wire [11:0] mem_0_1_O;
  wire  mem_0_1_CSB;
  wire  mem_0_1_OEB;
  wire  mem_0_1_WEB; //
  wire [6:0] mem_0_2_A;
  wire  mem_0_2_CE;
  wire [11:0] mem_0_2_I;
  wire [11:0] mem_0_2_O;
  wire  mem_0_2_CSB;
  wire  mem_0_2_OEB;
  wire  mem_0_2_WEB; //
  wire [6:0] mem_0_3_A;
  wire  mem_0_3_CE;
  wire [11:0] mem_0_3_I;
  wire [11:0] mem_0_3_O;
  wire  mem_0_3_CSB;
  wire  mem_0_3_OEB;
  wire  mem_0_3_WEB;
  SRAM1RW128x12 mem_0_0 (
    .A(mem_0_0_A),
    .CE(mem_0_0_CE),
    .I(mem_0_0_I),
    .O(mem_0_0_O),
    .CSB(mem_0_0_CSB),
    .OEB(mem_0_0_OEB),
    .WEB(mem_0_0_WEB)
  );
  SRAM1RW128x12 mem_0_1 (
    .A(mem_0_1_A),
    .CE(mem_0_1_CE),
    .I(mem_0_1_I),
    .O(mem_0_1_O),
    .CSB(mem_0_1_CSB),
    .OEB(mem_0_1_OEB),
    .WEB(mem_0_1_WEB)
  );
  SRAM1RW128x12 mem_0_2 (
    .A(mem_0_2_A),
    .CE(mem_0_2_CE),
    .I(mem_0_2_I),
    .O(mem_0_2_O),
    .CSB(mem_0_2_CSB),
    .OEB(mem_0_2_OEB),
    .WEB(mem_0_2_WEB)
  );
  SRAM1RW128x12 mem_0_3 (
    .A(mem_0_3_A),
    .CE(mem_0_3_CE),
    .I(mem_0_3_I),
    .O(mem_0_3_O),
    .CSB(mem_0_3_CSB),
    .OEB(mem_0_3_OEB),
    .WEB(mem_0_3_WEB)
  );
  assign RW0_rdata = (mem_0_0_O[8:0] & {9{~mem_0_0_CSB}}) | (mem_0_1_O[8:0] & {9{~mem_0_1_CSB}})|(mem_0_2_O[8:0] & {9{~mem_0_2_CSB}})|(mem_0_3_O[8:0] & {9{~mem_0_3_CSB}});
  assign mem_0_0_A = RW0_addr[6:0];
  assign mem_0_0_CE = RW0_clk;
  assign mem_0_0_I = {3'b0,RW0_wdata};
  assign mem_0_0_CSB = ~(~RW0_addr[8] & ~RW0_addr[7]);
  assign mem_0_0_OEB = ~(~RW0_wmode & RW0_en);
  assign mem_0_0_WEB = ~RW0_wmode;
  assign mem_0_1_A = RW0_addr[6:0];
  assign mem_0_1_CE = RW0_clk;
  assign mem_0_1_I = {3'b0,RW0_wdata};
  assign mem_0_1_CSB = ~(~RW0_addr[8] & RW0_addr[7]);
  assign mem_0_1_OEB = ~(~RW0_wmode & RW0_en);
  assign mem_0_1_WEB = ~RW0_wmode;
  assign mem_0_2_A = RW0_addr[6:0];
  assign mem_0_2_CE = RW0_clk;
  assign mem_0_2_I = {3'b0,RW0_wdata};
  assign mem_0_2_CSB = ~(RW0_addr[8] & ~RW0_addr[7]);
  assign mem_0_2_OEB = ~(~RW0_wmode & RW0_en);
  assign mem_0_2_WEB = ~RW0_wmode;
  assign mem_0_3_A = RW0_addr[6:0];
  assign mem_0_3_CE = RW0_clk;
  assign mem_0_3_I = {3'b0,RW0_wdata};
  assign mem_0_3_CSB = ~(RW0_addr[8] & RW0_addr[7]);
  assign mem_0_3_OEB = ~(~RW0_wmode & RW0_en);
  assign mem_0_3_WEB = ~RW0_wmode;
endmodule