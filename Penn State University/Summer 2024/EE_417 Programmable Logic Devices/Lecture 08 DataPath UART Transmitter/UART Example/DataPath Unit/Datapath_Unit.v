/*-----------------------------DataPath Unit-------------------------*/

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