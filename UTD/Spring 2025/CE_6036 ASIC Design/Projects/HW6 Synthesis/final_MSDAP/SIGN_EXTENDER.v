module SignExtender (
  input  wire [15:0] DATAIN,
  output wire [23:0] DATAOUT
);
  // Sign-extend right half (bits 15:0) using bit 15
  assign DATAOUT = {{8{DATAIN[15]}}, DATAIN[15:0]};
endmodule

