/*---------------------------COntroller Unit---------------------------*/

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