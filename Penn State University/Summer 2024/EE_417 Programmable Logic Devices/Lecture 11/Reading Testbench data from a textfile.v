/*--------------------------------------------half adder------------------------------------*/
module half_adder (input			a,b,
				   output	[1:0]	sum);
				   
//logical formular for the sum 
assign	sum[0] = a^b;
assign	sum[1] = a&b;
endmodule



/*-----------------------------half adder testbench--------------------------------*/

module	half_adder_tb ()

//define the registers and wires for the testbench
reg				a, b;
wire	[1:0]	sum; 

//internal probes to monitor
reg		[1:0]	expected_sum;
reg		[3:0]	read_data	[0:5];			//read_data has depth of 6 and word size of 4 for each depth level (height=6 and width=4)

integer	i;

//instantiate the half_adder
half_adder	M1 (a, b, sum);

//instantiate the test file
initial
	begin
		$readmemb("adder_InputData.txt", read_data);
		/********************note************************************************************************************
		***The text fie need to be saved in the simulation path:Projectfolder/simulation/modelsim/adder_InputData.txt 
		***You can add it after the simulation folder is created and before running the simulation
		*************************************************************************************************************/
		for (i=0; i<6; i=i+1)
			begin
				{a, b, expected_sum} = read_data[i];
					$display ("a = %b and b = %b	=>	expected_sum = %b" ,a ,b ,expected_sum);
				#20 $display ("a = %b and b = %b	=>	sum = %b"		   ,a ,b ,sum);
				
				if (sum != expected_sum)
					$display("Test error at a = %b and b = %b." ,a ,b);
			end
	end
endmodule