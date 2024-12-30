/*-------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 03 HW Question 1
Group: Ron Kalin/ Lamin Jammeh
Main design was done by Ron Kalin
TestBench was done by Lamin Jammeh
--------------------------------------------------------------------------*/

//Step1 define a name for the test-bench
module BCD_to_Xess3_tb;

//Step2 define the inputs as registers and outputs as wires 
reg [3:0] B;
wire [3:0] X;

//Step3 define the Unit under test UUT with all inputs and outputs
BCD_to_Xess3 UUT ( 
								.B(B),
								.X(X)
								);

//Step4 open an initial block and define all the possible input conbination the BCD to Xess3 from 0-9
initial
	begin
		     B = 4'b0000; 					//define the input B as 4 bits with all zero binary at the start
	   #100 B = 4'b0001;  
      #100 B = 4'b0010;  
      #100 B = 4'b0011;   
      #100 B = 4'b0100;  
      #100 B = 4'b0101;   
      #100 B = 4'b0110;         
      #100 B = 4'b1000;  
      #100 B = 4'b1001;   
		end
initial 
	begin
        $monitor("At time %t, B = %b, X = %b", $time, B, X);
    end
endmodule	