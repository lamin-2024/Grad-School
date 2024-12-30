/*-------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 03 HW Question 3 Part1
Group: Ron Kalin/ Lamin Jammeh
Main design was done by Ron Kalin
TestBench was done by Lamin Jammeh
--------------------------------------------------------------------------*/

//Step1 define a name for the test-bench
module SevenSegDisplay2Digits_tb;

//Step2 define the inputs as registers and outputs as wires 
reg [3:0] V;
wire [6:0] d1, d0;

//Step3 define the Unit under test UUT with all inputs and outputs
SevenSegDisplay2Digits UUT ( 
											.d1(d1),
											.d0(d0),
											.V(V)
											);

//Step4 open an initial block and define all the possible input combination for the BCD from 0-15 using 4bits
initial
	begin
		   V = 4'b0000;  //0
    #100 V = 4'b0001;  //1
    #100 V = 4'b0010;  //2
    #100 V = 4'b0011;  //3
    #100 V = 4'b0100;  //4
    #100 V = 4'b0101;  //5
    #100 V = 4'b0110;  //6
    #100 V = 4'b0111;  //7
    #100 V = 4'b1000;  //8
    #100 V = 4'b1001;  //9
	
	 #100 V = 4'b1010;  //10
    #100 V = 4'b1011;  //11
    #100 V = 4'b1100;  //12
    #100 V = 4'b1101;  //13
    #100 V = 4'b1110;  //14
	 #100 V = 4'b1111;  //15
    #100;
		end
//Display the results 
initial begin
			$display("________________________________output_didplay = --d1---_--d0---");
        $monitor("V = %b: 	Decimal_Input = %d:		Output_Display = %b_%b ", V, V, d1, d0);
    end
endmodule