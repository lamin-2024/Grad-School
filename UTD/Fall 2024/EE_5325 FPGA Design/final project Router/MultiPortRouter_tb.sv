//define testbench module and ports to test
module MultiPortRouter_tv();

  reg [15:0] data_in[19:0];
  wire [15:0] data_out[2:0];
  reg [19:0] valid_in;
  wire [3:0] valid_out;
  reg clk, reset;

//connect unit under test to top module
  MultiPortRouter UUT (
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .valid_in(valid_in),
    .valid_out(valid_out),
    .data_out(data_out)
  );

  // Probes for FIFO_full signals
  wire [15:0] FIFO_full[0:19];
  generate
    genvar i;
    for (i = 0; i < 20; i++) begin
      assign FIFO_full[i] = UUT.FIFO_full[i];
    end
  endgenerate

  // Clock signal generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset signal generation
  initial begin
    reset = 1;
    #20;  // Hold reset high for 20 time units
    reset = 0;
  end

  // Initialize inputs and drive testbench
  initial begin
    data_in = '{default: 16'b0}; // Initialize all elements to 0
    valid_in = 20'b0;

    for (int i = 0; i < 20; i++) begin
      data_in[i] = $random;
      valid_in[i] = 1;
      #10;
      valid_in[i] = 0;
      #10;
    end
    #100;
    $stop;
  end

  // Display results on every clock edge
  always @(posedge clk) begin
    $display("TIME: %0t, DATA_IN: %p, FIFO_DATA: %p, DATA_OUT: %p",
             $time, data_in, FIFO_full, data_out);
  end

endmodule