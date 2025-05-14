//adder is been updated to do add on both Left and Right 
module Adder (
  //Left side of the adder
  input  wire [23:0] dataout_L,
  input  wire [23:0] shift_outL,
  input  wire        add_sub_L, // 0: add, 1: subtract
  output wire [23:0] adder_outL,
  
  //Right side of the adder
  input  wire [23:0] dataout_R,
  input  wire [23:0] shift_outR,
  input  wire        add_sub_R, // 0: add, 1: subtract
  output wire [23:0] adder_outR
);
    assign adder_outL = add_sub_L ? (shift_outL - dataout_L) : (shift_outL + dataout_L);
    assign adder_outR = add_sub_R ? (shift_outR - dataout_R) : (shift_outR + dataout_R);
endmodule
