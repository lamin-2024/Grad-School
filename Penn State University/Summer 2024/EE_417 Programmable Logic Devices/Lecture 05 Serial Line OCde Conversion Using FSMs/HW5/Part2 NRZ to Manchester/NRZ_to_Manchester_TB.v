module NRZ_to_Manchester_TB ();

//define the registers and wires
reg clk, reset;
reg NRZ_in;

wire Manchester_out;

//define the unit under test UUT
NRZ_to_Manchester UUT (
						     .Manchester_out(Manchester_out),
							  .NRZ_in(NRZ_in),
							  .clk(clk),
							  .reset(reset)
							 );
					
//instantiate the clk signal
initial
	begin
		clk = 1'b0;
		forever #5 clk = ~clk;		//10ns clk period
	end

//instantiate the reset signal
initial
	begin
		     reset = 1'b0;		 //togel the reset signal on
			  NRZ_in  = 2'b01;
		#100 reset = 1'b1;		//toggle the reset signal off
	end

//instantiate all the posibble states for PAM4 with time intervals
initial
	begin
		NRZ_in = 2'b01; #15;
		NRZ_in = 2'b00; #15;
		NRZ_in = 2'b11; #15;
		
		$stop;
	end
	
//display the results
initial begin 				
  $display("NRZ_in--------Manchester_out");				
  $monitor("%b		%b ",NRZ_in, Manchester_out);							
 end				
endmodule	