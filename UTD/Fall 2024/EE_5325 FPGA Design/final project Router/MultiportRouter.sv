/*******************************************************************************************************************
Name: Lamin Jammeh
UTD ID: dal852207
Group: 5
Project Tiltle: MultiPortRouter
Project Description: In this project is group numbe ris randomize to get specific number of inputs and output
					 each person should desing their write their modules for the router and the group will design 
					 a testbench together. this testbench should work for all the different MultiPortRouter designs
Project Specs: Number of Inputs = 20
			   Number of Outputs = 3
			   Reset			 = Asynchronuos
			   Clk				 = Rising 
*******************************************************************************************************************/
/**************************************Milestone2******************************************************************
add a condition for evaluateing Data_in and sequence to accept data_out
*******************************************************************************************************************/
/**************************************Milestone3******************************************************************
evalute the first 3 MSB bits as assign to out_addr
evaluate the next 8 bits and assign to the parity check
Assign the remaining bits as spare 
evaluate FIFO data using a case and assign to the right output port
*******************************************************************************************************************/
/**************************************Milestone4******************************************************************
Added an interface an a clocking block to the design 
*******************************************************************************************************************/

/**************************************final modification******************************************************************
declare out_addr implicitly and acquire later on as a variable because I was get an error ('out_addr' is implicitly static)
during compiling  
**************************************************************************************************************************/


module MultiPortRouter (
						//define data ports
						input logic [15:0] data_in [19:0], // there are 20 input ports of 16 bits
						output logic [15:0] data_out[2:0], // there are 3 output ports of 16 bits
						
						//define control ports
						input logic [19:0] valid_in,      // 20 valid_in signals validates each input signals
						output logic [3:0] valid_out,      // 3 valid_out signals validates each output signals
						input logic clk, reset
                       );
   // internal registers for validating and queing data_in 
   logic [1:0] invalid_addr [19:0]; 		//FIFO full is 2X20 
   logic [15:0] FIFO_full [19:0];           //FIFO full is 16X20 
   logic [2:0] out_addr;
   logic [7:0] parity_check;
   logic [4:0] spare_bits;
   // define the router behavior at different edges of the clock
   always_ff @(posedge clk or negedge reset) begin
       if (reset) begin
           // @ reset clear both the FIFO and the outputs
		   for (int i = 0; i < 20; i++) begin 
				FIFO_full[i] <= 0; 
				invalid_addr[i] <= 0; 
			end 
		   for (int j = 0; j < 3; j++) begin 
				data_out[j] <= 0; 
				valid_out[j] <= 0; 
			end
       end else begin
           //route the data_in through the FIFO_full by doing the following 
		   for (int i=0; i<20; i++) begin
				if (valid_in[i] && !invalid_addr[i]) begin
                   // Extract out_addr bits, parity check, and keep remaining bits as spare_bits
                   out_addr = data_in[i][15:13];			//first 3 bits (MSB) bits use to determine output address
                   parity_check = data_in[i][12:5];		// the next 8 bits used to do the parity check
                   spare_bits = data_in[i][4:0];
                   
                   // Add data to FIFO if the FIFO is not full
                   FIFO_full[i] <= data_in[i];
                   invalid_addr[i] <= 1; // Mark FIFO as full
				end
			end
		   /*evaluate data_out and assign the FIFO_full data to the data_out ports */
			 for (int i = 0; i < 20; i++) begin
                if (invalid_addr[i]) begin
                    out_addr = FIFO_full[i][15:13];
                    case (out_addr)
                        3'd0, 3'd1, 3'd2: begin
                            if (!valid_out[0]) begin
                                data_out[0] <= FIFO_full[i];
                                valid_out[0] <= 1'b1;
                                invalid_addr[i] <= 1'b0; // Free FIFO
                            end
                        end
                        3'd3, 3'd4, 3'd5: begin
                            if (!valid_out[1]) begin
                                data_out[1] <= FIFO_full[i];
                                valid_out[1] <= 1'b1;
                                invalid_addr[i] <= 1'b0;
                            end
                        end
                        3'd6, 3'd7: begin
                            if (!valid_out[2]) begin
                                data_out[2] <= FIFO_full[i];
                                valid_out[2] <= 1'b1;
                                invalid_addr[i] <= 1'b0;
                            end
                        end
                    endcase
				end
			end 
       end
   end
 endmodule