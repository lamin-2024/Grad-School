module PAM4_to_Manchester (
									Manchester_out,
									PAM4_in,
									clk,
									reset
									);
									
//assigen the inputs and outputs as registers and wires
input  wire       clk, reset;				 //clk and reset signal 
input  wire [1:0] PAM4_in;				   //2 bits PAM4_in input signal
output wire       Manchester_out;		//declare as wire since it will be connected to module

//internal probe 
wire NRZ_data; 				//output signal from the PAM4_to NRZ module

//instantiate the PAM4-NRZ and NRZ-Manchester modules as user define modules (UDM1 and UDM2)
PAM4_to_NRZ UDM1 (
						.NRZ_out(NRZ_data),									//note NRZ_out becomes NRZ_data
						.PAM4_in(PAM4_in),
						.clk(clk),
						.reset(reset)
					  );
					  
NRZ_to_Manchester UDM2 (
								.Manchester_out(Manchester_out),
								.NRZ_in(NRZ_data),							//note NRZ_in becomes NRZ_data
							   .clk(clk),
								.reset(reset)
							  );
										
endmodule