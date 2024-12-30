//Name: Ron Kalin  EE417 Summer 2024, Date: 07/25/24
//Group: Ron Kalin/ Lamin Jammeh
//Lesson 11 HW Question 01. Project: test-bench for FIFO
module FIFO_tb ();
parameter   stack_width =  5;   // width of stack and data paths (word length)
parameter   stack_height = 8;   // height of stack (# of words)
parameter stack_ptr_width = $clog2(stack_height); //3;// width of pointer to address stack
//declare outputs and inputs
wire  [stack_width -1 : 0]  Data_out;
wire                        stack_empty, stack_full;
wire    					     	 stack_almost_empty, stack_almost_full;
reg   [stack_width -1 : 0]  Data_in;
reg   [stack_width -1 : 0]  Data_in_array [stack_height-1 : 0]; //internal register array of data
reg                         clk, rst;
reg                         write_to_stack, read_from_stack;

wire  [stack_width-1: 0]    stack0, stack1, stack2, stack3,
                            stack4, stack5, stack6, stack7;
wire [stack_ptr_width-1: 0] read_ptr, write_ptr;
wire [stack_ptr_width  : 0] ptr_diff; //pointer difference
integer                     j;

//initialize the unit under test	M1									  
FIFO  M1 ( Data_out, stack_empty, stack_almost_empty, stack_almost_full, stack_full, Data_in, 
           write_to_stack, read_from_stack, clk, rst );
// assign probe wires for troubleshooting and visibility			  
assign   stack0  = M1.stack [0]; 
assign   stack1  = M1.stack [1]; 
assign   stack2  = M1.stack [2]; 
assign   stack3  = M1.stack [3]; 
assign   stack4  = M1.stack [4]; 
assign   stack5  = M1.stack [5]; 
assign   stack6  = M1.stack [6]; 
assign   stack7  = M1.stack [7];
assign  read_ptr = M1.read_ptr;
assign write_ptr = M1.write_ptr;
assign  ptr_diff = M1.ptr_diff;

always begin clk = 0; forever #5 clk = ~clk; end  // create clock
initial  #1500 $stop;

initial begin
   #10   rst = 1;   #40 rst = 0;    #420  rst = 1;   # 460 rst = 0;  end  // cycle reset

initial begin
   $readmemb ("FIFO_Input_Data.txt", Data_in_array); // read data to Data_in_array from text file saved in simulation path
	end

initial begin	
//#80 Data_in = 1; forever #10 Data_in = Data_in + 1;  //manual method for creating Data_in
   #80 Data_in = 1; 
   for (j=0; j<stack_height; j=j+1)
	  begin
	    Data_in = Data_in_array[j]; // data in coming from text file
		 $display("Data_out: %u, Data_in: %u", Data_out, Data_in );
	  end //for
end

initial fork  // cycling read/write inputs
   # 80 write_to_stack  = 1;
   #180 write_to_stack  = 0;
   #250 read_from_stack = 1;
   #350 read_from_stack = 0;
   #420 write_to_stack  = 1;
   #480 write_to_stack  = 0;
  join
	 
//display results
always @(posedge clk)
begin
  $display("Data_out: %u, Data_in: %u, Data_in_array: %u, write_to_stack: %b, read_from_stack: %b, stack_empty: %b, stack_full: %b", 
            Data_out, Data_in, Data_in_array, write_to_stack, read_from_stack, stack_empty, stack_full );
end

endmodule