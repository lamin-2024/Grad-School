/*-------------------------------------------------------------------------------------------
     UART transmitter design parametrizable (Datapath - Controller)	  
--------------------------------------------------------------------------------------------*/
  module UART_TX #( parameter word_size = 8)(                   // size of data: 8 bits   
      // ports connected to data-path	
		output                          Serial_out,                             // serial output of data channel
	   input    [word_size-1 : 0]      Data_Bus,                 // Host data bus holding data word	
     // ports connected to the controller		
	   input                           Load_XMT_datareg,         // used by host to load the data register
	   input                           Byte_ready,                   // used by host to signal ready
	   input	                      T_byte,                           // used by host to signal start of transmission
	 	input                           clock,                                // bit clock of the transmitter
		input                           rst_b                                 // rst_bs internal registers and loads the XMT_shftreg with ones for idle state 
		);
   
                 Control_Unit   M0   (
                          Load_XMT_DR,                 // loads Data_Bus into Tx_datareg             - internal_out
                          Load_XMT_shftreg,                  // loads Tx_datareg into XMT_siftreg          - internal_out
		        start,                               // launches shifting of bits in XMT_shftreg   - internal_out
		        shift,                               // shifts bits in XMT_shiftreg                             - internal_out
		       clear,                               // clears bit_count after last bit is sent        - internal_out
		       Load_XMT_datareg,          // asserts Load_XMT_DR in state idle             - port_in
		       Byte_ready,                      // asserts Load_XMT_shftreg in state idle              - port_in
		       T_byte,                            // asserts start signal in state waiting          - port_in
                         BC_lt_BCmax,                 // indicates status of bit counter                   - internal_in
                         clock,                                //                                                                            port_in
		       rst_b                                 //                                                                            port_in            );
												  
	Datapath_Unit  M1   (
	                       Serial_out,                             // serial output of data channel              - port_out
			     BC_lt_BCmax,                       // indicates status of bit counter            - internal_out
			     Data_Bus,                              // data bus holding data_word                 - port_in
			     Load_XMT_DR,                    // loads Data_Bus into Tx_datareg             - internal_in
			     Load_XMT_shftreg,              // loads Tx_datareg into XMT_shftreg          - internal_in
			      start,                                      // launches shifting of bits in XMT_shftreg   - internal_in
			      shift,                                       // shifts bits in XMT_shftreg                 - internal_in
			      clear,                                      // clears bit_count after last bit is sent    - internal_in
			      clock,                                     //                                              port_in
			      rst_b                                      //                                              port_in                                   );
					
	endmodule
	
	

		module Control_Unit   #(
		                  parameter        one_hot_count = 3,                  // number of one-hot states
			parameter        state_count   = one_hot_count,      // number of bits in state register	
			parameter        idle          = 3'b001,
			                            waiting  = 3'b010,
			                            sending  = 3'b100		
			)(	
                                 output  reg      Load_XMT_DR,      // loads Data_Bus into Tx_datareg             - internal_out
                                 output  reg      Load_XMT_shftreg,      // loads Tx_datareg into XMT_shftreg          - internal_out
			output  reg   	  start,           // launches shifting of bits in XMT_shftreg   - internal_out
			output  reg  	  shift,           // shifts bits in XMT_shftreg                 - internal_out
			output  reg 	  clear,           // clears bit_count after last bit is sent    - internal_out		
			input				  Load_XMT_datareg, // asserts Load_XMT_DR in state idle           - port_in
			input				  Byte_ready,       // asserts Load_XMT_shftreg in state idle                 - port_in
			input				  T_byte,          // asserts start signal in state waiting                 - port_in
			input				  BC_lt_BCmax,     // indicates status of bit counter                  - internal_in
			input				  clock,           //                                              port_in
			input				  rst_b            //                                              port_in
			 );
	 reg   [state_count-1 : 0]  state, next_state;        // state machine controller
	 
	 always @ (posedge clock, negedge rst_b) 
				begin: State_transition
		                                  	if (rst_b == 1'b0)
                                                                               state <= idle; else
	                                                               state <= next_state;  end
		 always @ (state, Load_XMT_datareg, Byte_ready, T_byte, BC_lt_BCmax)
	 	    begin: Output_and_next_state
	                    Load_XMT_DR = 0;                    Load_XMT_shftreg = 0;
			  start      = 0;         shift      = 0;       clear      = 0;
			  next_state = idle;
			  
			  case (state)		  
			  idle: if (Load_XMT_datareg == 1'b1) begin
			                 Load_XMT_DR = 1;
			                 next_state = idle;        end
				else if (Byte_ready == 1'b1) begin
						        Load_XMT_shftreg = 1;
						        next_state = waiting;          end  
			waiting: if (T_byte == 1'b1) begin
				              start = 1;
				              next_state = sending;     end
				              else next_state = waiting;
                sending: if (BC_lt_BCmax) begin
				              shift = 1;
                                              next_state = sending;     end
				             else begin
				                     clear = 1;
                                                                       next_state = idle;      end
				default: next_state = idle;
				endcase
			end
			
                     endmodule 
			
			
 	module Datapath_Unit  #(
	
	     parameter     word_size = 8,
		                           size_bit_count = 3,                            // size of the bit counter. Must count word_size + 1
			           all_ones = {(word_size+1){1'b1}}    // 9 bits of ones
								 )(				 
	    output                                   Serial_out,      // serial output of data channel        - port_out
		  output             	                  BC_lt_BCmax,     // indicates status of bit counter      - internal_out
		  input    [word_size-1 : 0] 	   Data_Bus,        // data bus holding data_word           - port_in
		  input		                   Load_XMT_DR,      // loads Data_Bus into Tx_datareg             - internal_in
		  input		                   Load_XMT_shftreg,      // loads Tx_datareg into XMT_shftreg          - internal_in
		  input			   start,           // launches shifting of bits in XMT_shftreg   - internal_in
		  input			   shift,           // shifts bits in XMT_shftreg                 - internal_in
		  input			   clear,           // clears bit_count after last bit is sent    - internal_in
		  input			   clock,           //                                              port_in
		  input			   rst_b            //                                              port_in
                        );
	 
	   reg  [word_size -1 : 0]    Tx_datareg;           // transmit data register
                   reg  [word_size    : 0]     XMT_shftreg;            // transmit shift register {data, start bit}
	   reg  [size_bit_count : 0] bit_count;             // counts the bits that are transmitted
	
                  assign Serial_out       = XMT_shftreg[0];
		assign BC_lt_BCmax = (bit_count < word_size+1);
		
		always @ (posedge clock, negedge rst_b)
		
		if (rst_b == 0) begin
		   XMT_shftreg <= all_ones;
			bit_count   <= 0;
			end	
			else begin: Register_Transfers
			     if (Load_XMT_DR == 1'b1) 
				     Tx_datareg <= Data_Bus;               // get the data word from data bus
				  if (Load_XMT_shftreg == 1'b1)
				     XMT_shftreg <= {Tx_datareg, 1'b1};    // load shift reg and insert start bit
				  if (start == 1'b1)
				     XMT_shftreg [0] <= 0;                 // signal start of transmission
				  if (clear == 1'b1)
				     bit_count <= 0;
				  if (shift == 1'b1) begin
				     XMT_shftreg <= {1'b1, XMT_shftreg [word_size : 1]};  // shift right and fill with 1's
					  bit_count <= bit_count + 1;
					  end	
			      end 
               endmodule		
					


