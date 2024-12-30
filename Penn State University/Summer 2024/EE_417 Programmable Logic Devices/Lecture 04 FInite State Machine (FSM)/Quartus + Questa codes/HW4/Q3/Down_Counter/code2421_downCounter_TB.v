//ee417 Lesson 4 Assignment 3 Part 1, L4A3P1 
//Name: Ron Kalin, Date: 06-08-24
//Group: Kalin/Jammeh
//code2421_down_counter using Moore FSM with case structure testbench
//Step1 define test bench name
module code2421_downCounter_TB();
/* original module declaration
//module code2421_downCounter (output reg [3:0] count,
                             input clk,
                             input reset,
									  input enable);*/
//Step2 define inputs as registers, outputs as wires
reg clk, rst,enable;
wire [3:0] count;
//internal probe wires: observe change in state..this gives Questa error if not enough digits
wire [2:0] state, next_state;

//Step3 define unit under test
code2421_downCounter UUT (count, clk,rst,enable);

//internal probes to track logic and troubleshoot
assign state= UUT.state;
assign next_state= UUT.next_state;

//Step4 open initial block, define all possible input combinations
// Clock generation (adjust the period as needed)
initial begin
  clk=0;
  forever
  #5 clk = ~clk;
end

initial			//reset is active low, need to have longer time when reset is inactive (high)	
 begin				
  rst  = 1'b1;	//reset on			
  # 20 rst = 1'b0; enable=1'b1; //reset off, enable on		
  #120 rst = 1'b1;  //reset on
  # 20 rst = 1'b0; enable=1'b1; //reset off, enable on
  # 60 enable=1'b0;  //enable off freeze count
  #100 $stop; //close debug window to view waveform viewer
 end				
				
//Step5 Display the results 				
initial begin //monitor counter value				
  $display("________________________________output_count = -count-");				
  $monitor("clk_input = %b: rst_input = %b:  enable_input=%b: output_count = %d ", clk, rst, enable, count);							
 end				
endmodule				
