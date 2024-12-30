//module TopModule #(parameter WIDTH = 8, parameter CYCLES = 18) (
//    input clk,
//    input reset,
//    output [WIDTH-1:0] count
//);
//
//wire shift_en, load, done;
//
//DataPath #(WIDTH, CYCLES) datapath (
//    .clk(clk),
//    .reset(reset),
//    .shift_en(shift_en),
//    .load(load),
//    .count(count),
//    .done(done)
//);
//
//Controller controller (
//    .clk(clk),
//    .reset(reset),
//    .done(done),
//    .shift_en(shift_en),
//    .load(load)
//);
//
//endmodule




/*-----------------------up/down counter-----------------------*/
//module TopModule #(parameter WIDTH = 8, parameter CYCLES = 18) (
//    input clk,
//    input reset,
//    output [WIDTH-1:0] count
//);
//
//wire shift_en, load, done, up;
//
//DataPath #(WIDTH, CYCLES) datapath (
//    .clk(clk),
//    .reset(reset),
//    .shift_en(shift_en),
//    .load(load),
//    .up(up),
//    .count(count),
//    .done(done)
//);
//
//Controller controller (
//    .clk(clk),
//    .reset(reset),
//    .done(done),
//    .shift_en(shift_en),
//    .load(load),
//    .up(up)
//);
//
//endmodule






/******************************shift left or right-------------------*/
module TopModule #(parameter WIDTH = 8, parameter CYCLES = 18) (
    input clk,
    input reset,
    output [WIDTH-1:0] count
);

wire shift_left, shift_right, load, done;

DataPath #(WIDTH, CYCLES) datapath (
    .clk(clk),
    .reset(reset),
    .shift_left(shift_left),
    .shift_right(shift_right),
    .load(load),
    .count(count),
    .done(done)
);

Controller controller (
    .clk(clk),
    .reset(reset),
    .done(done),
    .shift_left(shift_left),
    .shift_right(shift_right),
    .load(load)
);

endmodule
