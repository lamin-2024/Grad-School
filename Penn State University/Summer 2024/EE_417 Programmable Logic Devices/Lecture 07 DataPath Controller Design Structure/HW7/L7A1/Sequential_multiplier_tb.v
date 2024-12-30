/*----------------------------------------------------------------------------------
Name Ron Kalin
CLass: EE417 Summer 2024
Lesson 07 HW Question 01
Group: Ron Kalin/ Lamin Jammeh
Project Description: test-bench for sequential multiplier
-------------------------------------------------------------------------------------*/
module Sequential_multiplier_tb ();

//set the parameters wires and registers
parameter		word_size = 4;  //bit length of word inputs
parameter      half_cycle = 5; //half cycle time of clock
parameter      full_cycle = 10;//full cycle time of clock
parameter      cycle_time = 160;//number of cycles before next cycle
/*top level module under test original declaration
module Sequential_multiplier (product, final_product,
                              Ready, start,
										word1, word2,
										clk, rst);*/
//define outputs as wires, inputs as registers
wire [2*word_size-1: 0] product, final_product;
wire                    Ready;
wire [word_size-2:0]    stateProbe2; //internal probe wire for troubleshooting
wire [word_size-1:0]    multiplierProbe;
wire [2*word_size-1: 0] multiplicandProbe;
reg  [word_size -1: 0]  multiplier2;
reg  [2*word_size-1: 0] multiplicand1;
reg                     start, clk, rst;
integer cycles;										
//define the unit under test UUT
Sequential_multiplier UUT (product, final_product,
                           Ready, start,
									multiplicand1, multiplier2,
									clk, rst);
//internal probes to track logic and troubleshoot
//assign stateProbe = UUT.state;
assign stateProbe2 = UUT.M2.state; //UUT=top module, M2 =submodule instance name, state is register
assign multiplierProbe   = UUT.M1.multiplier;
assign multiplicandProbe = UUT.M1.multiplicand;

//instantiate clock
initial 
    begin: clock_loop
		clk = 1'b1;
		cycles = 0;
		forever begin
			#half_cycle		clk = ~clk;
			cycles = cycles + 1;
		end
		if (cycles == cycle_time) disable clock_loop;
	 end

//define input words and observe the outputs
initial begin
  start = 1;  //start to high means start process
  rst = 1;    //reset high will set everything to zero and ready to high
  multiplicand1 = 8'b0000_0101; //initialize both words random test values
  multiplier2   = 4'b0101;
  #10 rst = 0;//reset low
  #cycle_time
  rst =1;
  multiplicand1 = 8'b0000_1111; //initialize both words random test values
  multiplier2   = 4'b1101;
  #10 rst = 0;
  #cycle_time //disable clock_loop;
//end
  multiplier2 = 4'b0000;
  multiplicand1 = 8'b0000_0000;
  forever begin: input_loop
	multiplier2 = multiplier2 + 1'b1;  //increment multiplier
	if (multiplier2 == 4'b1111) begin      //if multiplier reaches max value
		 multiplier2 = 4'b0001;               //reset multiplier to one
		 multiplicand1 = multiplicand1 + 1'b1;//incr multiplicand
   end
	if (multiplicand1 == 8'b1111_1111 && multiplier2 == 4'b1111) begin //both reach max value
		disable input_loop; disable clock_loop; end
	#cycle_time;
  end
end  
////monitor and display the output 		  
initial begin
$monitor("multiplicand1 = %b: multiplier2 = %b: stateProbe2=%d: product=%d: final_product=%d:",multiplicand1, multiplier2, 
	stateProbe2,product, final_product);  
	end
endmodule