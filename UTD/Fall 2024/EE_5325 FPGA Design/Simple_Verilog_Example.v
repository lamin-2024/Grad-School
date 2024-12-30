//A simple example of 2 input AND gate
module and2 (a, b, c);		//module name and port list

//Step1 port decalarations
input	a, b;
output	c;

//Step2 body
assign	c = a & b;

endmodule				//end module