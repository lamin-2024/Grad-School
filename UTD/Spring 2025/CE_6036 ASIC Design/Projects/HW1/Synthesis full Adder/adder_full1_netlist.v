/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Fri Jan 31 04:41:03 2025
/////////////////////////////////////////////////////////////
`include "18m.v"
`timescale 1ns/1ps

module full_adder ( A, B, C_in, Sum, C_out );
  input A, B, C_in;
  output Sum, C_out;
  wire   n2;

  XOR2X1M U4 ( .A(C_in), .B(n2), .Y(Sum) );
  AO22X1M U5 ( .A0(B), .A1(A), .B0(n2), .B1(C_in), .Y(C_out) );
  XOR2X1M U6 ( .A(A), .B(B), .Y(n2) );
endmodule
