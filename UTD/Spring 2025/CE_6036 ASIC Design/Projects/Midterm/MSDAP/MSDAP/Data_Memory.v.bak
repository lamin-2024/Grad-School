module Data_Memory (
    input wire CLK,                      // Clock signal
    input wire CLEAR,                    // Synchronous clear
    input wire LOAD,                     // Frame load signal (optional)
    input wire [15:0] PDATA_IN,          // 16-bit data input
    input wire [7:0] WRITE_ADDRESS,      // 8-bit write address
    input wire WRITE_EN,                 // Write enable
    input wire [7:0] READ_ADDRESS,       // 8-bit read address
    output wire [15:0] DATAOUT,          // 16-bit output data
    output reg ZERO_DETECTED            // High when last written data is zero
);

    // Internal 256 x 16-bit memory
    reg [15:0] memory [255:0];
    reg [15:0] last_written_data;

    integer i;

    // Write logic with synchronous clear
    always @(negedge CLK or posedge CLEAR) begin
        if (CLEAR) begin
            last_written_data <= 16'b1;
            for (i = 0; i < 256; i = i + 1) begin
                memory[i] <= 16'b0;
            end
        end else if (WRITE_EN) begin
            memory[WRITE_ADDRESS] <= PDATA_IN;
            if(PDATA_IN == 16'b0) begin
		ZERO_DETECTED <= 1;
	    end else begin
		ZERO_DETECTED <= 0;
	    end
        end
    end

    // Combinational read
    assign DATAOUT = memory[READ_ADDRESS];

endmodule

