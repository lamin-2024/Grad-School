module PAM4_to_NRZ_TB ();

//define the registers and wires
reg clk, reset;
reg [1:0] PAM4_in;
wire NRZ_out;

//define the unit under test UUT
PAM4_to_NRZ UUT (
					  .NRZ_out(NRZ_out),
					  .PAM4_in(PAM4_in),
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
  $display("PAM4_in--------Binary/NRZ_out");				
  $monitor("%b		%b ",PAM4_in, NRZ_out);							
 end				
endmodule
