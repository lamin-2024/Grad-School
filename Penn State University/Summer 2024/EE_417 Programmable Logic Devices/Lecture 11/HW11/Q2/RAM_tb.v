/*----------------------------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 11 HW Question 2
Group: Ron Kalin/ Lamin Jammeh
Project Description: Testtbench for the RAM Module
-----------------------------------------------------------------------------------------------------*/
				 
module RAM_tb ();

parameter	memory_height = 8;
parameter	data_width	  = 4;

//define the wires and registers testbench
reg									clock, reset;
reg									read_or_write;
reg	[memory_height -1:0]		address;
reg	[data_width		-1:0]		data_in;
wire	[data_width		-1:0]		data_out;

//probe the each address line to determine the content 
wire	[memory_height	-1:0]		address_0, address_1, address_2, address_3, address_4, address_5, address_6, address_7;

//instantiate the Unit under test UUT
RAM UUT (clock, reset, address, read_or_write, data_in, data_out);

//assign the probes for the address to the address to lines in the UUT
assign	address_0	= UUT.memory[0];
assign	address_1	= UUT.memory[1];
assign	address_2	= UUT.memory[2];
assign	address_3	= UUT.memory[3];
assign	address_4	= UUT.memory[4];
assign	address_5	= UUT.memory[5];
assign	address_6	= UUT.memory[6];
assign	address_7	= UUT.memory[7];
	
//intantiate the clock cycle
initial
	begin
		clock   = 0;
		forever #5	clock = ~clock;
	end

//initialize the RAM
initial
	begin
		reset 		  = 1;
		read_or_write = 0;
		address		  = 0;
		data_in 		  = 4'b0000;
		
		
	
//load data to the memory
		#10;
				  reset		    = 1'b0;
				  address		 = 0;						//load address 0
		   	  data_in	    = 4'b1101;
		   	  read_or_write = 1'b1;					// write to memory
				  
		#10;
				  data_in       = 4'b0011;
				  address		 = 1;						//load address 1	
			     read_or_write = 1'b1;					// write to memory
			
		#10;
				  data_in       = 4'b1100;
				  address		 = 2;						//load address 2
				  read_or_write = 1'b1;					// write to memory
				  
		#10;
				  data_in       = 4'b1010;
				  address		 = 3;						//load address 3
				  read_or_write = 1'b1;					// write to memory
		#10;	
				  address		 = 4;						//load address 4
		   	  data_in	    = 4'b1101;
		   	  read_or_write = 1'b1;					// write to memory
				  
		#20;
				  data_in       = 4'b0011;
				  address		 = 5;						//load address 5	
			     read_or_write = 1'b1;					// write to memory
			
		#10;
				  data_in       = 4'b1100;
				  address		 = 6;						//load address 6
				  read_or_write = 1'b1;					// write to memory
				  
		#10;
				  data_in       = 4'b1010;
				  address		 = 7;						//load address 7
				  read_or_write = 1'b1;					// write to memory

//read data from memory 
		#10;
				  address = 0;
				  read_or_write = 1'b0;
		#10;
				  address = 1;
				  read_or_write = 1'b0;
		#10;
				  address = 2;
				  read_or_write = 1'b0;
		#10;
				  address = 3;
				  read_or_write = 1'b0;
		#10;
				  address = 4;
				  read_or_write = 1'b0;
		#10;
				  address = 5;
				  read_or_write = 1'b0;
		#10;
				  address = 6;
				  read_or_write = 1'b0;				  
		#10;
				  address = 7;
				  read_or_write = 1'b0;	
//check the reset function
		#10;
				 reset = 1;
		#10;
				 reset = 0;
		#20    $stop;		
	end
endmodule