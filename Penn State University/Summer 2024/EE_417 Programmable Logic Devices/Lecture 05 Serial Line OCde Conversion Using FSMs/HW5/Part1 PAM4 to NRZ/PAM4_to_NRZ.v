/*-----------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 04 HW Question 5 Q2 Part1
Group: Ron Kalin/ Lamin Jammeh
Project Description: the portion takes in PAM4_in with 2 bits input and 4 different
levels and converts it to NRZ 
-------------------------------------------------------------------------------*/

module PAM4_to_NRZ (
							NRZ_out,
							PAM4_in,
							clk,
							reset
							);
//assigen the inputs and putputs as registers and wires
input wire clk, reset;				//clk and reset signal 
input wire [1:0] PAM4_in;				//2 bits PAM4_in input signal
output reg NRZ_out;

//4 different PAM4_in levels
reg [1:0] PAM4_in_level;

//diffrent PAM4_in states
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

//sequential logic updating the state
always @ (posedge clk or posedge reset)		//asynchronous reset
	if (reset) PAM4_in_level <= S0;			  
	else       PAM4_in_level <= PAM4_in;
	
 // Next state logic and output logic
    always @(*) begin
        case (PAM4_in_level)
            S0:	NRZ_out = 1'b0; 
				S1:	NRZ_out = 1'b1;
				S2:	NRZ_out = 1'b0;
				S3:	NRZ_out = 1'b1;
        endcase
    end

endmodule