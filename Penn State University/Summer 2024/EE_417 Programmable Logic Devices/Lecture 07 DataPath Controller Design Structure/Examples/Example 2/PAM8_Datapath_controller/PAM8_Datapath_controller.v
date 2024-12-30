/*--------------------------PAM8_Datapath_controller-------------------------------------------*/
module PAM8_Datapath_controller (data_in, data_out, reset, clock, enable);

input		  data_in, reset, clock, enable;
output	[2:0] data_out;

wire start, load;

//instantiate the 2 modules PAM8_Datapath and PAM8_Controller as m1 and m2 respectively
PAM8_Datapath	m1	(data_out, data_in, clock, reset, start, load);
PAM8_Controller m2	(start, load, enable, reset, clock);
endmodule