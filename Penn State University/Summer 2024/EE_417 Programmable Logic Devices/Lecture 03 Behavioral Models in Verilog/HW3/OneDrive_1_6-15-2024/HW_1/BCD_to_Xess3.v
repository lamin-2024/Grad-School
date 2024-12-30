// Name:  Ron Kalin, Date: 5-29-24, Design: Lesson 3A1: BCD_to_Xess3   
// Group: Ron Kalin/Lamin Jammeh _____
module BCD_to_Xess3 ( input [3:0] B,
                      output [3:0] X ); //B=BCD, X=Xcess3
wire notB0, notB1, notB2, notB3; //declare wires
wire and1X3, and2X3;
wire and1X2, and2X2, and3X2;
wire xnorX1;
							 
//not not0 (notB0, B[0]); //not gates
//not not1 (notB1, B[1]);
//not not2 (notB2, B[2]);
//not not3 (notB3, B[3]);

//and and1 (and1X3, B[0], B[2]);  //and gates
//and and2 (and2X3, B[1], B[2]);
//and and3 (and1X2, notB1, notB0, B[2]);
//and and4 (and2X2, B[0],notB2);
//and and5 (and3X2, B[1],notB2);

//xnor xnor1 (xnorX1, B[0], B[1]); //xnor gate

//or orX3 (X[3], and1X3, B[3], and2X3);  //or gates to give output bits
//or orX2 (X[2], and1X2, and2X2, and3X2);
//assign X[1] = xnorX1;
//assign X[0] = notB0;

//equations below  can be used in lieu of gate logic above
//X3 = (B0B2) + B3 + (B1B2)
assign X[3] = (B[0] & B[2]) |  B[3] | (B[1] & B[2]);
//X2 = (B1'B0'B2) + (B0B2') + (B1B2')
assign X[2] = (!B[1]& !B[0] & B[2]) | (B[0] & !B[2]) | (B[1] & !B[2]);
//X1 = B0'B1' + B0B1 = BO XNOR B1
assign X[1] = B[0] ^~ B[1];
//X0 = B0'
assign X[0] = !B[0];


endmodule