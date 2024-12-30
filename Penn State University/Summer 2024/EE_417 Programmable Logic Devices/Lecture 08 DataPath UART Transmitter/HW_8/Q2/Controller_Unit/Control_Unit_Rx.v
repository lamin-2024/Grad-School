/*----------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 08 HW Question 2
Group: Ron Kalin/ Lamin Jammeh
Project Description: Control_Unit for Reciever (Rx) will control the datapath for the 
UART Rx. Once the Data is Transmitted by the Host processor, the Control_unit will
perform several checks before allowing the Datapath to load the recieved data
-------------------------------------------------------------------------------------*/

module Control_Unit_Rx	#(parameter word_size = 8,
								  parameter half_word = word_size/2,
								  parameter Num_state_bits = 2
								 )
								//state the outputs of the COntroller Unit
							   (output reg	read_not_ready_out,
								 output reg Error1,
								 output reg Error2,
								 output reg clr_Sample_counter,
								 output reg inc_Sample_counter,
								 output reg clr_Bit_counter,
								 output reg inc_Bit_counter,
								 output reg shift,
								 output reg load,
							  //define the inputs of the Controller Unit
							    input read_not_ready_in,
								 input Ser_in_0,
								 input SC_eq_3,
								 input SC_lt_7,
								 input BC_eq_8,
								 input Sample_clk,
								 input rst_b
								 );
								 
//Parameterize the different states of the Controller Unit as a 2-bit one-hot counter
parameter idle      = 2'b00;
parameter starting  = 2'b01;
parameter receiving = 2'b10;

//define the internal registers for state, next_stae and shift_reg
reg	[word_size-1:0]	Rx_shftreg;					//creates a temp register of 8-bits to store the received data
reg	[Num_state_bits-1:0]	 state, next_state;		//creates temp register of 2-bits for the stae transition

//state Transition logic
always @(posedge Sample_clk)
	if   (rst_b == 1'b0) 
		  state <= idle;
	else state <= next_state;
	/*---------------   for the State Transition--------------------------
	---if reset is low (0) the controller unit will remain in idle
	---if reset is high (1) the controller will move to the next-state----*/
	
//create a initial or default condition for the controller
always @(state, Ser_in_0, SC_eq_3, SC_lt_7, read_not_ready_in)
	begin
		read_not_ready_out = 0;
		clr_Sample_counter = 0;
		clr_Bit_counter    = 0;
		inc_Sample_counter = 0;
		inc_Bit_counter    = 0;
		shift              = 0;
		Error1             = 0;
		Error2             = 0;
		load               = 0;
		next_state         = idle;
		//create the Next State logic
		case (state)
			idle:	if   (Ser_in_0 == 1'b1)							
						  next_state = starting;
					else next_state = idle;
       /*-----------------@ idle------------------------------
		 --- if Ser_in_0 is high (1) move to starting state------
		 --- if Ser_in_0 is low (0) remain idle-----------------*/
			starting: if (Ser_in_0 ==1'b0)
							 begin
								next_state = idle;
								clr_Sample_counter = 1;
							 end								//Keep receiving the Ser_in_0 = 1'b0 until the next else if condition is met
						 else if (SC_eq_3 ==1'b1)
							 begin
								next_state = receiving;
								clr_Sample_counter = 1;
							 end								//once Sample_counter = 3 then move to the receiving state and clr_Sample_counter 
							else
								begin
									inc_Sample_counter = 1;
									next_state = starting; 
								end						//  when the if conditons are false remain @ starting and increment the Sample_counter
			receiving: if (SC_lt_7 == 1'b1) 
								begin
									inc_Sample_counter = 1;
									next_state = receiving;
								end						//Keep receiving data as long as SC less than 7 is high (1) and remain the receiving state
							else							//once SC_lt_7 drops low the current data package is completed
								begin
									clr_Sample_counter = 1;		//clr the Sample_counter and check the next if condition
									if (!BC_eq_8) 					//if BC_eq_8 is not true or low
										begin
											shift = 1;           //send shift high to the Datapath
											inc_Bit_counter = 1;
											next_state = receiving;
										end 				//keep shift as ong as BC_eq_8 is false and remain in receiving state
									else
										begin
											next_state = idle;		//if BC_eq_8 id high move to idle
											read_not_ready_out = 1;	//and send read_not_ready_out to the Datapath
											clr_Bit_counter = 1;	
									//check the integrity of the data received and status of the host		
											if (read_not_ready_in == 1'b1)   //host not ready to receive the data
												Error1 = 1;
											else if (Ser_in_0 ==1'b1)			//stop bit not received 
												Error2 = 1;
											else					// the both Error1 and 2 are false the data integrity is correct and send load signal
												load = 1;			//send load signal to the Datapath
										end
									end
				default:	next_state = idle;
			endcase
	end
endmodule

										

								 
								 
								  