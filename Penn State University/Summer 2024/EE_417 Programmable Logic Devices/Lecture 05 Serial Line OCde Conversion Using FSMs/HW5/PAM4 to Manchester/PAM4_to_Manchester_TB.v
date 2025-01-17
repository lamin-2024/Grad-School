module PAM4_to_Manchester_TB ();

//define the registers=wire and wires=registers from desing-to-testbench
reg       clk, reset;				 //clk and reset signal 
reg [1:0] PAM4_in;				   //2 bits PAM4_in input signal
wire       Manchester_out;		

//define the unit under test UUT
PAM4_to_Manchester UUT (
								.Manchester_out(Manchester_out),
								.PAM4_in(PAM4_in),
								.clk(clk),
								.reset(reset)
								);
								
//monitor internal probe
assign NRZ_data = UUT.UDM1.NRZ_out;
								
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
			  PAM4_in  = 2'b00;
		#100 reset = 1'b1;		//toggle the reset signal off
	end
	
//instantiate all the posibble states for PAM4_in with time intervals
initial
	begin
		PAM4_in = 2'b00; #15;
		PAM4_in = 2'b01; #15;
		PAM4_in = 2'b10; #15;
		PAM4_in = 2'b11; #15;
		
		$stop;
	end
	
//display the results
initial begin 				
  $display("PAM4_in--------Binary/NRZ_out-------Manchester_out");				
  $monitor("%b		      %b		       %b ",PAM4_in, NRZ_data, Manchester_out);							
 end				
endmodule