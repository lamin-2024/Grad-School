//ee417 lesson 5 Assignment 1, L5A1
// Name: Ron Kalin, Date: 06-13-24  Group: Kalin/Jammeh
// Testbench for Design: manchester to PAM4 converter using 
// manchester to NRZ converter then NRZ to PAM4 converter
//Step1 define test bench name
module manchester_to_pam4_tb();

/*original module declaration
module manchester_to_pam4 (  
    output[2:0] PAM_out, // 3-bit PAM4 output
	 input clk, // Clock for sampling
    input rst, // Reset
    input manchester_in); // Manchester-encoded 1bit serial input*/
//Step2 define inputs as registers, outputs as wires			
reg clk, rst, manchester_in;	
reg [3:0] a;		
wire [1:0] PAM_out;			
//internal probe wires: observe change in state..Questa error if not correct no. of bits			
wire NRZ_out;						
			
//Step3 define unit under test			
manchester_to_pam4 UUT (PAM_out,clk,rst,manchester_in);			
			
//internal probes to track logic and troubleshoot			
assign NRZ_out= UUT.NRZ_out;			
			
//Step4 open initial block, define all possible input combinations			
// Clock generation (adjust the period as needed)			
initial begin			
  clk=0;			
  forever			
  #5 clk = ~clk;			
end			
			
initial	//reset is active high, longer time to count when reset is inactive (low)		
 begin	//4 cases with two selects		
  rst  = 1'b1;	//reset on	
  a=4'b0000; 
  # 10 rst = 1'b0;  //reset off	
//start manchester sequence
  repeat (2) begin  // repeat x times
  #5   manchester_in=1'b1;
  #10  manchester_in=1'b0;
  #10  manchester_in=1'b0;
  #10  manchester_in=1'b1;  //PAM 4=2
  
  #10  manchester_in=1'b1;
  #10  manchester_in=1'b0;
  #10  manchester_in=1'b1;
  #10  manchester_in=1'b0; //PAM 4=3
  
  #10  manchester_in=1'b0;
  #10  manchester_in=1'b1;
  #10  manchester_in=1'b0;
  #10  manchester_in=1'b1; //PAM 4=0
  
  #10  manchester_in=1'b0;
  #10  manchester_in=1'b1;
  #10  manchester_in=1'b1;
  #10  manchester_in=1'b0; //PAM 4=1
  #10;  
  end
  
  rst = 1'b1;
  #20 rst=1'b0;
  
  repeat (15) begin //cycle thru every possible combination of four series inputs
	 #10 manchester_in=a[3];
	 #10 manchester_in=a[2];
	 #10 manchester_in=a[1];
    #10 manchester_in=a[0];
	 a=a+1;
  end
  			
  #100 $stop; //close debug window to view waveform viewer			
 end			
			
//Step5 Display the results 			
initial begin //monitor counter value			
  $display("________________________________output_PAM_out = -PAM4-");			
  $monitor("clk_in = %b: rst_in = %b:  output_PAM_out = %d ", 			
  clk, rst, PAM_out);			
 end			
endmodule			