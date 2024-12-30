/*----------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 08 HW Question 2 
Group: Ron Kalin/ Lamin Jammeh
Project Description: DataPath_Unit for Reciever (Rx) will receive input command from the Control_unit.
The DataPath wiil check for input command from the control_Unit and it will do the following
load: the databus to the data_reg 
shift: the data received in the shift_reg
-------------------------------------------------------------------------------------*/

module Datapath_Unit_Rx #(parameter word_size = 8,
								  parameter half_word = word_size/2,
								  parameter Num_counter_bits = 4
								 )
						      //output of the DataPath Unit
								 (output reg [word_size-1:0]	Rx_datareg,
								  output								Ser_in_0,
								  output								SC_eq_3,
								  output								SC_lt_7,
								  output								BC_eq_8,
								//define the inputs of the DataPath Unit
								  input								Serial_in,
								  input								clr_Sample_counter,
								  input								inc_Sample_counter,
								  input								clr_Bit_counter,
								  input								inc_Bit_counter,
								  input								shift,
								  input								load,
								  input								Sample_clk,
								  input								rst_b
								 );
								 
//create a temp register to store the shift_register, Sample_counter, and Bit_counter
reg	[word_size-1:0]			Rx_shftreg;
reg	[Num_counter_bits-1:0]	Sample_counter;
reg   [Num_counter_bits:0]		Bit_counter;

//assign an internal output to the inputs of the DataPath (define the the internal Probes)
assign Ser_in_0 = (Serial_in == 1'b0);
assign BC_eq_8  = (Bit_counter == word_size);
assign SC_lt_7  = (Sample_counter < word_size-1);
assign SC_eq_3  = (Sample_counter == half_word-1);

//initial condition of the DataPath
always	@(posedge Sample_clk)
	if (rst_b == 1'b0)				//synchronous rst_b
		begin
			Sample_counter <= 0;
			Bit_counter		<= 0;
			Rx_datareg		<= 0;
			Rx_shftreg		<= 0;
		end				//when rst_b is low (0) alway internal registers will be 0
	else
	// if rst_b is high check the following if condtions and start moving data through the DataPath
		begin
			if (clr_Sample_counter == 1)
				Sample_counter <= 0;  //sample_counter register is cleared after clr_Sample_counter bit goes high (1)
				
			else if (inc_Sample_counter == 1)
				Sample_counter <= Sample_counter + 1; //increment Sample_counter once inc_sample_counter bit goes high (1) and clr_sample_counter bit is low
				
			if (shift == 1) 
				Rx_shftreg <= {Serial_in, Rx_shftreg[word_size-1:1]}; //concat the Serial_in with content of shft_reg[7:1] (shift right or toward LSB)
				
			if (load ==1)
				Rx_datareg <= Rx_shftreg; //load the entire content of shft_reg into datareg without any change (parallel load)
		end
endmodule
				
				
		
								  