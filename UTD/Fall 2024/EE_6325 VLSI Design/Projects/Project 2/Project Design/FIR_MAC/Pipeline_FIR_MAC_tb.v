/*----------------------------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
FINAL PROJECT: FIR MAC module
Group: Ron Kalin/ Lamin Jammeh
Project Description: testbench for the FIR_MAC with Pipelining
-----------------------------------------------------------------------------------------------------*/

module Pipeline_FIR_MAC_tb;

// Define the parameter sets for the design 
parameter FIR_order         = 4;
parameter Sample_size       = 6;   // maximum sample value is 63
parameter weight_size       = 5;   // maximum value may be 31
parameter word_size_out     = 2 * Sample_size + 2;  // maximum possible output 63*31*(4+1)

// Define the wires and registers for the test bench
wire    [word_size_out -1:0]    FIR_out;
reg     [Sample_size -1:0]      Sample_in;
reg                             clock, reset;

// Define the unit under test UUT
Pipeline_FIR_MAC UUT (FIR_out, Sample_in, clock, reset);

// Define Probes to observe the Pipeline register PR0 
wire    [word_size_out -1:0]    PR00;   assign PR00 = UUT.datapath.PR0[0];
wire    [word_size_out -1:0]    PR01;   assign PR01 = UUT.datapath.PR0[1];
wire    [word_size_out -1:0]    PR02;   assign PR02 = UUT.datapath.PR0[2];
wire    [word_size_out -1:0]    PR03;   assign PR03 = UUT.datapath.PR0[3];
wire    [word_size_out -1:0]    PR04;   assign PR04 = UUT.datapath.PR0[4];

// Define Probes to observe the Pipeline register PR1
wire    [word_size_out -1:0]    PR11;   assign PR11 = UUT.datapath.PR1[1];
wire    [word_size_out -1:0]    PR12;   assign PR12 = UUT.datapath.PR1[2];
wire    [word_size_out -1:0]    PR13;   assign PR13 = UUT.datapath.PR1[3];
wire    [word_size_out -1:0]    PR14;   assign PR14 = UUT.datapath.PR1[4];

// Define Probes to observe the Pipeline register PR2
wire    [word_size_out -1:0]    PR22;   assign PR22 = UUT.datapath.PR2[2];
wire    [word_size_out -1:0]    PR23;   assign PR23 = UUT.datapath.PR2[3];
wire    [word_size_out -1:0]    PR24;   assign PR24 = UUT.datapath.PR2[4];

// Define Probes to observe the Pipeline register PR3
wire    [word_size_out -1:0]    PR33;   assign PR33 = UUT.datapath.PR3[3];
wire    [word_size_out -1:0]    PR34;   assign PR34 = UUT.datapath.PR3[4];

// Instantiate the clock signal
initial 
	begin
		clock = 0;
		forever #5 clock = ~clock;
   end 

// Instantiate and toggle the reset signal
initial 
	begin
		reset = 1; 
      #10 reset = 0;
   end 

// Integer for file handle
integer f;
integer i;

// Apply different input samples and observe the outputs
initial
	begin
		f = $fopen("output.txt", "w"); 
      $fwrite(f, "\t\tTime\tSample_in\tFIR_out\n");

      // Apply the input samples and log the output
      for (i = 0; i < 10; i = i + 1)
			begin
            case (i)
                0:  Sample_in = 0;
                1:  Sample_in = 1;
                2:  Sample_in = 0;
                3:  Sample_in = 10;
                4:  Sample_in = 0;
                5:  Sample_in = 1;
                6:  Sample_in = 2;
                7:  Sample_in = 8;
                8:  Sample_in = 2;
                9:  Sample_in = 1;
                10: Sample_in = 0;
                11: Sample_in = 63;
                12: Sample_in = 0;
                default: Sample_in = 0;
            endcase
            #10; // Wait for the output to settle
            $fwrite(f, "%d\t   %d\t      %d\n", $time, Sample_in, FIR_out);
        end

        $fclose(f);
        #100 $stop;
    end 

endmodule
