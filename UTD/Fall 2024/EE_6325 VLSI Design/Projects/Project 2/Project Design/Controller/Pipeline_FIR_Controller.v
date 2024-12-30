/*----------------------------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
FINAL PROJECT: Controller
Group: Ron Kalin/ Lamin Jammeh
Project Description: The Controller module drives the enable signal. This signal will enable the
computation of the FIR_MAC
-----------------------------------------------------------------------------------------------------*/

module Pipeline_FIR_Controller (
										  input clock,
										  input reset,
										  output reg enable
										 );

// Control logic for the FIR filter
always @ (posedge clock or posedge reset) 
begin
	if (reset)
		begin
        enable <= 0;
		end 
		else 
		begin
        enable <= 1;
		end
end

endmodule
