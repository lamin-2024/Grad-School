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
						);						  
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
							);
	endmodule