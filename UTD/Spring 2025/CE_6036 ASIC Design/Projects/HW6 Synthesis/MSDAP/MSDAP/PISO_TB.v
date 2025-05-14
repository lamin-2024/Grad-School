`timescale 1ns / 1ps

module PISO_tb;

    reg CLK;
    reg CLR;
    reg LOAD;
    reg EN;
    reg [39:0] PDATA_IN;
    wire SERIAL_OUT;

    integer error_count = 0;
integer cycle_count = 0;

    // Instantiate the shift register
    PISO uut (
        .CLK(CLK),
        .CLR(CLR),
        .LOAD(LOAD),
        .EN(EN),
        .PDATA_IN(PDATA_IN),
        .SERIAL_OUT(SERIAL_OUT)
    );

    // Clock generation
    initial CLK = 0;
    always #18.62 CLK = ~CLK;  // 10ns period (100MHz)

    // Validation task
task check_serial_output;
    input [39:0] expected_data;
    integer i;
    begin
        for (i = 0; i < 40; i = i + 1) begin
            @(posedge CLK);
            if (SERIAL_OUT !== expected_data[i]) begin
                $display("Cycle %0d | Bit %0d FAIL: Expected %b, Got %b", 
                         cycle_count, i, expected_data[i], SERIAL_OUT);
                error_count = error_count + 1;
            end else begin
                $display("Cycle %0d | Bit %0d PASS: %b", cycle_count, i, SERIAL_OUT);
            end
        end
    end
endtask


    // Test sequence
    initial begin
        // Initialize inputs
        CLR = 1;
        LOAD = 0;
        EN = 0;
        PDATA_IN = 40'hFEDCBA987A; // Test value

        // Reset pulse
        #10 CLR = 0;

        // Load data
        #10 LOAD = 1;
        #10 LOAD = 0;

        // Enable shifting
        EN = 1;

        // Check output
        check_serial_output(PDATA_IN);

        // Report final result
        if (error_count == 0)
            $display("TEST PASSED: All bits matched.");
        else
            $display("TEST FAILED: %0d bit(s) mismatched.", error_count);

        $finish;
    end

always @(posedge CLK) begin
    if (!CLR)
        cycle_count <= cycle_count + 1;
end

endmodule

