// ee417 lesson 9 Assignment 1 L9A1
// Name: Ron Kalin, Date: 07-10-24  Group: Kalin/Jammeh
// Design: moving average FIR filter of overlapping windows of 4 input samples
// FIR order will be a power of 2, paramterized with word_size
// top level module
module moving_average_filter #(parameter word_size=8, order=4, n=2)(
    output reg [2*word_size-1:0] filtered_sample,
	 input      [word_size-1:0]   sample_in,
	 input                        enable, clk, reset
);
    // Coefficient values for a 4-tap moving average filter
    //reg [word_size-1:0] coeff [0:order] = {16'h1000, 16'h1000, 16'h1000, 16'h1000};
	 reg [word_size-1:0] coeff0 = 4'd1; //coefficients of one were selected 
	 reg [word_size-1:0] coeff1 = 4'd1; //because for moving average they aren't needed
	 reg [word_size-1:0] coeff2 = 4'd1;
	 reg [word_size-1:0] coeff3 = 4'd1;
	 reg [word_size-1:0] tap_outputs [0:3];

    // Circular buffer to store input samples
    reg [word_size-1:0] buffer0, buffer1, buffer2, buffer3; 
	 reg [word_size-1:0] buffer [0:order-1];
    always @(posedge clk) begin
        if (reset  || ~enable) begin
            buffer0 = 0;
				buffer1 = 0;
				buffer2 = 0;
				buffer3 = 0;
        end else if (enable) begin
            buffer3 = buffer2;
				buffer2 = buffer1;
				buffer1 = buffer0;
				buffer0 = sample_in;
        end
	   // Multipliers and accumulator
      tap_outputs[0] = buffer0 * coeff0; //coeff[0];
      tap_outputs[1] = buffer1 * coeff1; //coeff[1];
      tap_outputs[2] = buffer2 * coeff2; //coeff[2];
      tap_outputs[3] = buffer3 * coeff3; //coeff[3];
    
	   filtered_sample = (buffer0 + buffer1 + buffer2 + buffer3); // >> 2;
	 //filtered_sample = buffer[0] + buffer[1] + buffer[2] + buffer[3];
    //filtered_sample <= (tap_outputs[0] + tap_outputs[1] + tap_outputs[2] + tap_outputs[3]);
	 // Right shift by 2 bits to approximate division by 4
      filtered_sample = (filtered_sample >> n); //shift n places to divide by 2^n
		//shift n places requires 2^n samples (buffers and coefficients)
    end
endmodule

