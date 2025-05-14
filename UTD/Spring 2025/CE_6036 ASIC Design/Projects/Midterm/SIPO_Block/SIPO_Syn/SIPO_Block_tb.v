`timescale 1ns / 1ps

module SIPO_Block_tb;

    reg DCLK = 0;
    reg CLR = 1;
    reg EN = 0;
    reg DATA_IN;

    wire [15:0] PDATA_IN_L;
    wire [15:0] PDATA_IN_R;

    // DUT instantiation
    SIPO_Block dut (
        .DCLK(DCLK),
        .CLR(CLR),
        .EN(EN),
        .DATA_IN(DATA_IN),
        .PDATA_IN_L(PDATA_IN_L),
        .PDATA_IN_R(PDATA_IN_R)
    );

    // Clock generation
    always #5 DCLK = ~DCLK;

    integer file, r;
    reg [31:0] data_word;

    // Task to send a 32-bit word serially (MSB first)
    task send_serial_32(input [31:0] word);
        integer i;
        begin
            for (i = 31; i >= 0; i = i - 1) begin
                DATA_IN = word[i];
                @(posedge DCLK);

                if (i == 0) begin
                    // Wait for shift_reg to update
                    #1;
                    $display("shift_reg    = %032b", dut.shift_reg);
                    $display("PDATA_IN_L   = %016b, PDATA_IN_R = %016b", PDATA_IN_L, PDATA_IN_R);
                end
            end
        end
    endtask

    initial begin
        // Initial reset
        CLR = 1;
        EN = 0;
        #10;

        CLR = 0;
        EN = 1;
        #10;

        file = $fopen("data_input.txt", "r");
        if (file == 0) begin
            $display("ERROR: Could not open file.");
            $finish;
        end

        while (!$feof(file)) begin
            r = $fscanf(file, "%h", data_word);
            if (r == 1) begin
                $display("\nSending 32-bit word serially (MSB first): %h", data_word);
                send_serial_32(data_word);
            end
        end

        $fclose(file);
        #20;
        $finish;
    end

endmodule
