// Design: Lesson 4A2: 4-BIT JERKY COUNTER
//Group: Lamin Jammeh/Ron Kalin							
// FourBitJerkyCounter testbench
//--------------------------------------------------------------------------------									
//Step1 define test bench name								
module FourBitJerkyCounterb_tb();
//original module declaration									
//FourBitJerkyCounter(output reg [7:0] count, 					
//                          input clk,						
//                           input rst );						 	
//Step2 define inputs as registers, outputs as wires									
reg clk, rst;									
wire [7:0] count;									
								
//Step3 define/instantiate unit under test UUT wth all inputs and outputs									
FourBitJerkyCounterb UUT ( .count(count),										
						        .clk(clk),			
								  .rst(rst)	
								);
//Step4 open initial block, define all possible input combinations
// Clock generation (adjust the period as needed)
initial begin	//create clock									
  clk=0;									
  forever									
  #5 clk = ~clk;								
end	 						
						
initial		//reset is active high, inactive low						
 begin									
  rst  = 1'b1;	//reset high at start								
  # 10 rst =1'b0;	//after delay reset low, count starts							
  #300 rst = 1'b1; //after delay reset								
  #50 rst = 1'b0; //after delay count again
  #100 $stop; //close debug window to view waveform viewer
  //#100 $finish; // say no when asked to exit, close debug window
 end							
									
//Step5 Display the results 									
initial begin //monitor counter value									
  $display("________________________________output_count = -count-");								
  $monitor("clk_input = %b: rst_input = %b:  output_count = %d ", clk, rst, count);
 end																	
endmodule