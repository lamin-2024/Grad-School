/*----------------------------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
FINAL PROJECT: FIR MAC module
Group: Ron Kalin/ Lamin Jammeh
Project Description: This Module combines the Datapath with the controller to form a FIR_MAC. 
-----------------------------------------------------------------------------------------------------*/

module Pipeline_FIR_MAC (FIR_out, Sample_in, clock, reset);

// Define the parameter sets for the design 
parameter FIR_order       = 4;
parameter Sample_size     = 6;                        // Maximum sample value is 63
parameter weight_size     = 5;                        // Maximum value may be 31
parameter word_size_out   = Sample_size + weight_size + 3;  // log2(2^2 * 2^5 * (order+1))

//define the outputs
output [word_size_out - 1:0] FIR_out;

//define the inputs
input  [Sample_size - 1:0]   Sample_in;
input 						     clock, reset;

// Internal signals
wire enable;

// Instantiate the DataPath module
Pipeline_FIR_DataPath #(FIR_order, Sample_size, weight_size, word_size_out) datapath (
    .FIR_out(FIR_out),
    .Sample_in(Sample_in),
    .clock(clock),
    .reset(reset)
);

// Instantiate the Controller module
Pipeline_FIR_Controller controller (
    .clock(clock),
    .reset(reset),
    .enable(enable)
);

endmodule
