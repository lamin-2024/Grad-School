// Name:  Ron Kalin, Date: 5-31-24, Design: Lesson3A3P2: 7-seg display 2 digits   	
// Group: Ron Kalin/Lamin Jammeh _____	
module SevenSegDisplay2Digits(output [6:0] d1,d0, input [3:0] V);	  
	  wire [3:0] A;
	  wire [3:0] muxout;
	  wire [3:0] z;
	  wire gr;
//instantiate submodules, cannot use if statements to instantiate
comp4bit COMP9 (z, V, gr); //if V>9, gr=1, else gr=0
CircuitA CIRA (V, A); //input V output A, A=V if V<=9, else A=V-10
mux2to1_4bit MUX (V, A, gr, muxout);//z=0, select V, else select A
//assign z1 = (z==1) ? z : 4'b1111; //if gr=1 then z1=1, else z1=blank
Seven_Seg_Disp SEV1 (d1,z); //d1 output, z1 input (either 1 or 0), blank =4'b1111
Seven_Seg_Disp SEV0 (d0, muxout);//display data from MUX

endmodule

//4-bit comparator
module comp4bit(B, V, z);
    input [3:0] V; // 4-bit inputs
    output reg [3:0] B; // 4-bit output
	 output z;
	 //wire eq, ls;
    //assign eq = (a == 9) ? 1 : 0; // Equal condition
    assign z = (V > 9) ? 1 : 0; // Greater than condition
    //assign ls = (a < 9) ? 1 : 0; // Less than condition
    always @ (V)
	   if (V>9) begin
		  //V>9 so display 1
		   B=4'b0001;
			//b=V;
			end
		else begin //V<9 so blank
	      B=4'b1111;	
		   end
endmodule

//4-bit wide 2 to 1 multiplexer
module mux2to1_4bit(
    input [3:0] data0, // 4-bit input data 0
    input [3:0] data1, // 4-bit input data 1
    input select,      // Select signal (0 or 1), z
    output reg [3:0] muxout); //4-bit output
    always @ (data0, data1)  //put input only in sensitivity list
        if (select)  //select = 1
            muxout = data1;  //data1 from circuit A
        else
            muxout = data0;  //data from V
endmodule 

//Circuit A
module CircuitA (
 input [3:0] V, // Input V 4-bit word
 output reg [3:0] A ); // output 4-bit word

    always @ (V)
       case (V)
          4'b1010: A = 4'b0000; // 10 returns 0
          4'b1011: A = 4'b0001; // 11 returns 1
		    4'b1100: A = 4'b0010; // 12 returns 2
          4'b1101: A = 4'b0011; // 13 returns 3
          4'b1110: A = 4'b0100; // 14 returns 4
          4'b1111: A = 4'b0101; // 15 returns 5
          default: A = 4'b1111; // Default unique value, detect invalid input 
        endcase
endmodule

// 7-segment display	
module Seven_Seg_Disp ( output reg [6:0] Disp, input [3:0] BCD); //input BCD	
//               output Disp   abc_defg (seven segments, not including dec. pt)	
parameter      BLANK      = 7'b111_1111;  //blank	
parameter      ZERO       = 7'b000_0001;  //h01 hexadecimal 1st 3-digits = 0 = 000	
parameter      ONE        = 7'b100_1111;  //h4F hexadecimal 2nd 4-digits = F = 1111	
parameter      TWO        = 7'b001_0010;  //h12	
parameter      THREE      = 7'b000_0110;  //h06	
parameter      FOUR       = 7'b100_1100;  //h4c	
parameter      FIVE       = 7'b010_0100;  //h24	
parameter      SIX        = 7'b010_0000;  //h20	
parameter      SEVEN      = 7'b000_1111;  //h0f	
parameter      EIGHT      = 7'b000_0000;  //h00	
parameter      NINE       = 7'b000_0100;  //h04	
always @ (BCD)	
  case (BCD) //BCD is decimal value	
   0:          Disp = ZERO;	
	1:          Disp = ONE;
	2:          Disp = TWO;
	3:          Disp = THREE;
	4:          Disp = FOUR;
	5:          Disp = FIVE;
	6:          Disp = SIX;
	7:          Disp = SEVEN;
	8:          Disp = EIGHT;
	9:          Disp = NINE;
	default:    Disp = BLANK;
  endcase	
endmodule	
