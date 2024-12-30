// ee417 lesson 7 Assignment 1 L7A1
// Name: Ron Kalin, Date: 06-25-24  Group: Kalin/Jammeh
// Design: Sequential_multiplier
// top level module raises a ready flag when ready to load new input words
// user should activate a start input to indicate a new multiplication operation starts
module Sequential_multiplier (product, final_product,
                              Ready, start,
										word1, word2,
										clk, rst);
parameter                 L_WORD =4;  //Datapathsize
output    [2*L_WORD-1: 0] product, final_product;
output                    Ready;
input     [L_WORD -1: 0]  word1, word2;
input                     start, clk, rst;

reg [L_WORD-1:0] mcand, mult;

wire multiplier_LSB, Load_words, shift, Add, latch, zero_flag;
wire [L_WORD-2:0] state;

Datapath M1   (product, final_product,
               Ready, multiplier_LSB, zero_flag,
				   word1, word2,
				   Load_words, shift, Add, latch,
				   clk, rst);
					
controller M2 (Load_words, shift, Add, latch, state,
               Ready, multiplier_LSB, start, zero_flag,
					clk, rst);
					
endmodule

//Datapath
module Datapath (product, final_product, 
                 Ready, multiplier_LSB, zero_flag,
					  word1, word2,
					  Load_words, shift, Add, latch,
					  clk, rst);

parameter L_WORD= 4;  //declare parameter values

//declare outputs and input
output reg [2*L_WORD-1:0] product, final_product;
output reg                Ready;
output                    multiplier_LSB, zero_flag;
input      [ L_WORD-1:0]  word1, word2;
input                     Load_words, shift, Add, latch;
input                     clk, rst;
//declare internal wires
reg    [2*L_WORD-1: 0]    multiplicand;
reg    [  L_WORD-1: 0]    multiplier;
//assign values
assign multiplier_LSB = multiplier[0];    //least significant bit of multiplier
assign zero_flag      = (multiplier == 0);//if multiplier=all zeros, zero_flag=1

//create always block
always @ (posedge clk)
 begin
       if (rst)        begin multiplier    <= 0;//if reset =1 then zero
                             multiplicand  <= 0;
		                       product       <= 0;
									  final_product <= 0; 
									  Ready         <= 1; end//ready high= accept input words
  else if (Load_words) begin multiplicand  <= word1;//Load_words=1 
	                          multiplier    <= word2;//then m..cand gets value of word1
									  product       <= 0;    //mult gets value word2 
									  final_product <= 0;    //prod and final_prod=0
									  Ready         <= 0; end//ready low means calculate
  else if (shift)      begin multiplier    <= multiplier >> 1;   //shift right 1
                             multiplicand  <= multiplicand << 1; //shift left 1
									  Ready         <= 0; end
  else if (Add)        begin product       <= product + multiplicand;
                             Ready         <= 0; end
  else if (latch)      begin final_product <= product; //adding done
                             Ready         <= 1; end   //ready for new input
  else                 begin end
 end
  
endmodule
										
//controller
module controller (Load_words, shift, Add, latch, state,
            Ready, multiplier_LSB, start, zero_flag,
			   clk, rst);
//parameter L_WORD= 4;  //declare parameter values

//declare outputs/inputs, control unit only handles single bit inputs and outputs
output reg Load_words, shift, Add, latch;
output reg [2:0] state;
input      Ready, multiplier_LSB, start, zero_flag;
input      clk, rst;	

reg [2:0]  next_state; //3 bits for up to 8 states
//build code from FSM diagram

//declare states from FSM
parameter idle    = 3'b000;
parameter loading = 3'b001;
parameter loaded  = 3'b010;
parameter add     = 3'b011;
parameter shft    = 3'b100;
parameter buff    = 3'b101;
parameter ltch    = 3'b110;

always @ (posedge clk)
if (rst) state <= idle;
   else  state <= next_state;
	
always @ *
  //assign probe <= state;
  case (state)
    idle: begin
				Load_words = 1'b0;
				latch      = 1'b0;
				Add        = 1'b0;
				shift      = 1'b0;
				if (Ready && start) next_state = loading;
				             else   next_state = idle;    end		 
	 loading: begin
		      Load_words = 1'b1;
				latch      = 1'b0;
				Add        = 1'b0;
				shift      = 1'b0;
				next_state = loaded;   end
	 loaded: begin  //2nd load stage is needed because input data changes
		      Load_words = 1'b0;  //1 cycle is needed to look at the change
				latch      = 1'b0;
				Add        = 1'b0;
				shift      = 1'b0;
				if (multiplier_LSB) next_state = add;
				             else   next_state = shft;    end
    add: begin
		      Load_words = 1'b0;
				latch      = 1'b0;
				Add        = 1'b1;    //output changes
				shift      = 1'b0;
				next_state = shft;     end  //shift always follows after an add
	 shft: begin
		      Load_words = 1'b0;
		      latch      = 1'b0;		
				Add        = 1'b0;
				shift      = 1'b1;
				next_state = buff;     end
	 buff: begin //buffer state needed after shift because input data changes
		      Load_words = 1'b0; //1 cycle is needed to take a look at the change
		      latch      = 1'b0;		
				Add        = 1'b0;
				shift      = 1'b0;
				if (multiplier_LSB) next_state = add;
			   else if (zero_flag) next_state = ltch;	
				             else   next_state = shft; end							 						 
    ltch: begin
		      Load_words = 1'b0;		
				Add        = 1'b0;
				shift      = 1'b0;
				latch      = 1'b1;
				next_state = loading;    end	//cycle back to loading stage		

//below is initial pseudocode				
//if rst=1 then load_words=0, shift=add=latch=0
//if rst=0 and start=1 and ready=1 then load_words=1, shift=0, add=0, latch=0
//if rst=0 and start=1 and ready=0 then
  //if multiplier_LSB=0 then load_words=0, shift=1, add=0, latch=0
  //
  //else if multiplier_LSB=1 then load_words=0, shift=0, add=1, latch=0
  //
  //else if zero_flag=1      then load_words=0, shift=0, Add=0, latch=1, ready=1 ...done
  endcase																	
endmodule										
										
										