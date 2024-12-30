module NRZ_to_Manchester (Manchester_out,
								  NRZ_in,
							     clk,
								  reset
								  );
											   
output Manchester_out;
input wire NRZ_in, clk, reset;

reg [1:0] state, next_state;
reg 	  next_out, Manchester_out;		//to assign values within always block

parameter Sx = 2'b01;			//waiting for new NRZ input
parameter S0 = 2'b00;			//An NRZ 0 is being converted to 01
parameter S1 = 2'b11;			//An NRZ 1 is being converted to 10

//sequential logic updating the state
always @ (posedge clk or posedge reset)		//asynchronous reset
	if (reset) begin state <= Sx;
				   Manchester_out <= 1'b0;
			   end
	else       begin state <= next_state;
					 Manchester_out <= next_out;
			   end

//combinational logic to find the next_state and the Manchester_out 
always @ *				//if the state or the NRZ_in change
	case (state)
		Sx: if (NRZ_in) begin
							next_state = S1;
							next_out   = 1'b1;
						end
			else		begin
							next_state = S0;
							next_out   = 1'b0;
						end
		S0: if (NRZ_in) begin					
							next_state = Sx;			//NRZ_in has to be 0
							next_out   = 1'b1;
						end
		S1: if (NRZ_in) begin					
							next_state = Sx;			//NRZ_in has to be 1
							next_out   = 1'b0;
						end	
	          default:  begin					
							next_state = Sx;			
							next_out   = 1'b0;
						end			
	endcase
endmodule