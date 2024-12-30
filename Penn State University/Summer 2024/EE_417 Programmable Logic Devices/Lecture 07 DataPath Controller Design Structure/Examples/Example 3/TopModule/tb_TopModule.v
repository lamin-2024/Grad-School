//module tb_TopModule;
//
//reg clk;
//reg reset;
//wire [7:0] count;
//
//TopModule #(8, 18) uut (
//    .clk(clk),
//    .reset(reset),
//    .count(count)
//);
//
//// Clock generation
//initial begin
//    clk = 0;
//    forever #5 clk = ~clk; // 10 time units period
//end
//
//// Test sequence
//initial begin
//    reset = 1;
//    #10 reset = 0; // Deassert reset after 10 time units
//
//    // Run the counter for 200 time units
//    #200 $stop;
//end
//
//// Monitor output
//initial begin
//    $monitor("Time: %0t | count: %b", $time, count);
//end
//
//endmodule

/*---------------------up/down count tb--------------------*/
//module tb_TopModule;
//
//reg clk;
//reg reset;
//wire [7:0] count;
//
//TopModule #(8, 18) uut (
//    .clk(clk),
//    .reset(reset),
//    .count(count)
//);
//
//// Clock generation
//initial begin
//    clk = 0;
//    forever #5 clk = ~clk; // 10 time units period
//end
//
//// Test sequence
//initial begin
//    reset = 1;
//    #10 reset = 0; // Deassert reset after 10 time units
//
//    // Run the counter for 200 time units
//    #200 $stop;
//end
//
//// Monitor output
//initial begin
//    $monitor("Time: %0t | count: %b", $time, count);
//end
//
//endmodule


/*---------------------------------------------------------------------*/
module tb_TopModule;

reg clk;
reg reset;
wire [7:0] count;
wire shift_left;
wire shift_right;

TopModule #(8, 18) uut (
    .clk(clk),
    .reset(reset),
    .count(count)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 time units period
end

// Test sequence
initial begin
    reset = 1;
    #10 reset = 0; // Deassert reset after 10 time units

    // Run the counter for 500 time units
    #500 $stop;
end

// Monitor output
initial begin
    $monitor("Time: %0t | count: %b | shift_left: %b | shift_right: %b", $time, count, uut.controller.shift_left, uut.controller.shift_right);
end

endmodule
