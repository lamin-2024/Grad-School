// SignExtender module for stereo data
// Takes a 32-bit input and splits it into Left and Right 16-bit halves,
// then sign-extends each half to 24 bits independently.

module SignExtender (
  input  wire [31:0] datain,
  output wire [23:0] sign_out_L,
  output wire [23:0] sign_out_R
);
  // Sign-extend left half (bits 31:16) using bit 31
  assign sign_out_L = {{8{datain[31]}}, datain[31:16]};

  // Sign-extend right half (bits 15:0) using bit 15
  assign sign_out_R = {{8{datain[15]}}, datain[15:0]};
endmodule
