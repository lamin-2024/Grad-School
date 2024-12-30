/*---------------------------------------Binary 7segment---------------------------*/

module	Binary_7segment (BCD, SevenSegment);

input		[3:0]	BCD;
output	reg	[6:0]	SevenSegment;

parameter	BLANK	= 7'b111_1111;	//127
parameter	ZERO	= 7'b100_0000;	//64
parameter	ONE		= 7'b111_1001;	//121
parameter	TWO		= 7'b010_0100;	//36
parameter	THREE	= 7'b011_0000;	//48
parameter	FOUR	= 7'b001_1001;	//25
parameter	FIVE	= 7'b001_0010;	//18
parameter	SIX		= 7'b000_0001;	//1
parameter	SEVEN 	= 7'b111_1000;	//120
parameter	EIGHT	= 7'b000_0000;	//0
parameter	NINE	= 7'b001_1000;	//24

always	@*
	case (BCD)
		4'b0000	: SevenSegment = ZERO;
		4'b0001 : SevenSegment = ONE;
		4'b0010 : SevenSegment = TWO;
		4'b0011 : SevenSegment = THREE;
		4'b0100 : SevenSegment = FOUR;
		4'b0101 : SevenSegment = FIVE;
		4'b0110 : SevenSegment = SIX;
		4'b0111 : SevenSegment = SEVEN;
		4'b1000 : SevenSegment = EIGHT;
		4'b1001 : SevenSegment = NINE;
		default : SevenSegment = BLANK;
	endcase
endmodule



/*----------------------------------Binary 7segment ROM--------------------------------*/

module Binary_7segment_ROM (ROM_address, ROM_data);

input		[3:0]	ROM_address;
output		[6:0]	ROM_data;

reg		[6:0]		ROM[15:0];				//width is seven bits and depth is 16 words

parameter	BLANK	= 7'b111_1111;	//127
parameter	ZERO	= 7'b100_0000;	//64
parameter	ONE		= 7'b111_1001;	//121
parameter	TWO		= 7'b010_0100;	//36
parameter	THREE	= 7'b011_0000;	//48
parameter	FOUR	= 7'b001_1001;	//25
parameter	FIVE	= 7'b001_0010;	//18
parameter	SIX		= 7'b000_0001;	//1
parameter	SEVEN 	= 7'b111_1000;	//120
parameter	EIGHT	= 7'b000_0000;	//0
parameter	NINE	= 7'b001_1000;	//24


initial
	begin
		ROM[0]	= ZERO;
		ROM[1] 	= ONE;
		ROM[2]	= TWO;
		ROM[3]	= THREE;
		ROM[4]	= FOUR;
		ROM[5]	= FIVE;
		ROM[6]	= SIX;
		ROM[7]  = SEVEN;
		ROM[8]	= EIGHT;
		ROM[9]	= NINE;
		ROM[10] = BLANK;
		ROM[11] = BLANK;
		ROM[12] = BLANK;
		ROM[13] = BLANK;
		ROM[14] = BLANK;
		ROM[15] = BLANK;
	end 
endmodule



/*---------------------------------------Binary 7segment COnverter-------------------------------------*/

module	Binary_7segment_converter	(BCD, SevenSegment);

input	[3:0]	BCD;
output	[6:0]	SevenSegment;

//Instantiation of the ROM look-up-table
Binary_7segment_ROM		lookUpTable (.ROM_address(BCD),
									 .ROM_data   (SevenSegment)
									 );
endmodule