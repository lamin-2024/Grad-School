// ee417 Final Project L12A2
// Name: Ron Kalin/Lamin Jammeh, Date: 07-30-24  Group: Kalin/Jammeh
// Design: Moving Average Filtet of overlapping windows of 4 input sameples
// module has reset and enable input signals
// filter is parametrized order as a power of 2 (for right shifting) and sample size
module FIR_MovingAverage ( FIR_out, sample_in, enable, clock, reset );

parameter FIR_order     = 4;
parameter sample_size   = 8;	                //max sample size is 15
parameter word_size_out = sample_size;	       // average size = sample size
parameter Acc_size      = FIR_order*sample_size; 
parameter shift_steps   = $clog2(FIR_order);  // division by right shift (2^n=FIR_order)

output [word_size_out -1: 0] FIR_out;

input  [sample_size   -1: 0] sample_in;
input                        clock, enable, reset;

reg    [Acc_size      -1: 0] Acc;			// adding sameples
reg	 [sample_size -1: 0]   sample_array [1: FIR_order];

assign FIR_out = Acc[sample_size-1 : 0];
integer c,k;    // integer counters

//combinational logic
always @ (sample_array)
 begin
  Acc= 0;
  for (c=1; c<=FIR_order; c=c+1)
    begin
	   Acc = Acc + sample_array[c]; // add samples together parametrized for any no. of samples
	 end
	 Acc = Acc >> shift_steps;   // shift right (division operation)
 end
 
//sequential logic
always @ (posedge clock)
   if (reset)  // reset high set all samples to zero
	  begin
	    for (k = 1; k <= FIR_order; k=k+1)
		   sample_array[k] <= 0;
	  end
	else if (enable) 
	  begin
	    sample_array [1] <= sample_in;
		 for (k = 2; k <= FIR_order; k = k+1)
		  sample_array[k] <= sample_array[k-1];
	  end  
endmodule