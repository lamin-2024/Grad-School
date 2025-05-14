module SIPO_Module (
    input wire CLK,             // Data clock
    input wire CLEAR,           // Asynchronous reset
    input wire EN,              // Local enable (active block)
    input wire FRAME,           // Shared start trigger
    input wire DATA_IN,         // Serial input bitstream
    output reg [15:0] PDATA_IN,  // 16-bit parallel output
    output reg DATA_READY
);

    reg [3:0] bit_count;
    reg [15:0] shift_reg;
    reg reading;

    // Shift in bits on falling clock edge
    always @(negedge CLK) begin
        if (CLEAR) begin
            reading <= 0;
            bit_count <= 0;
            shift_reg <= 0;
            PDATA_IN <= 16'b0;
        end else if (FRAME && EN) begin
            reading <= 1;
            shift_reg <= {shift_reg[14:0], DATA_IN};
            bit_count <= bit_count + 1;
            DATA_READY <= 0;
        end else if (reading) begin
        	shift_reg <= {shift_reg[14:0], DATA_IN};
            bit_count <= bit_count + 1;
		    DATA_READY <= 0;
        	if (bit_count == 4'd15) begin
            		PDATA_IN <= {shift_reg[14:0], DATA_IN};
            		reading <= 0;
            		DATA_READY <= 1;  // Set flag
        	end
    	end else begin
        	DATA_READY <= 0; // Automatically clears on next edge
    	end
    end

endmodule
