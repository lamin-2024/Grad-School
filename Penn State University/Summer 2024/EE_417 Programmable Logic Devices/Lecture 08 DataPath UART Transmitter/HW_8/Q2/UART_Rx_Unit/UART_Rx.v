/*----------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 08 HW Question 2 
Group: Ron Kalin/ Lamin Jammeh
Project Description: UART_Rx is the Top_module. it combines the Control submodule and 
the DataPath submodule to form the receiver UART receiver
-------------------------------------------------------------------------------------*/

module	UART_Rx  #(parameter word_size = 8,
						  parameter half_word = word_size/2
						  )
						//output of the UART_Rx
						 (output	[word_size-1:0]	Rx_datareg,
						  output							read_not_ready_out,
						  output							Error1,
						  output							Error2,
						//define the inputs of the UART_Rx
						  input							Serial_in,
						  input							read_not_ready_in,
						  input							Sample_clk,
						  input							rst_b
						 );
						 
//instnatiate the submodule for the controller and the DataPath
Control_Unit_Rx M0 (
					  read_not_ready_out,
					  Error1, Error2,
					  clr_Sample_counter,
					  inc_Sample_counter,
					  clr_Bit_counter,
					  inc_Bit_counter,
					  shift,
					  load,
					  read_not_ready_in,
					  Ser_in_0,
					  SC_eq_3,
					  SC_lt_7,
					  BC_eq_8,
					  Sample_clk,
					  rst_b
					  ); 
Datapath_Unit_Rx M1 (
						Rx_datareg,
						Ser_in_0,
					   SC_eq_3,
					   SC_lt_7,
					   BC_eq_8,
						Serial_in,
						clr_Sample_counter,
					   inc_Sample_counter,
					   clr_Bit_counter,
					   inc_Bit_counter,
					   shift,
					   load,
						Sample_clk,
					   rst_b
					   );
endmodule