module tb_pam4_to_nrz;

    reg clk;
    reg rst_n;
    reg [1:0] pam4_symbol;
    wire nrz_bit;

    pam4_to_nrz uut (
        .clk(clk),
        .rst_n(rst_n),
        .pam4_symbol(pam4_symbol),
        .nrz_bit(nrz_bit)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock period of 10 time units
    end

    initial begin
        // Initialize signals
        rst_n = 0;
        pam4_symbol = 2'b00;

        // Apply reset
        #15;
        rst_n = 1;

        // Test all PAM4 symbols
        pam4_symbol = 2'b00; #10;
        $display("PAM4 Symbol: %b, NRZ Bit: %b", pam4_symbol, nrz_bit);

        pam4_symbol = 2'b01; #10;
        $display("PAM4 Symbol: %b, NRZ Bit: %b", pam4_symbol, nrz_bit);

        pam4_symbol = 2'b10; #10;
        $display("PAM4 Symbol: %b, NRZ Bit: %b", pam4_symbol, nrz_bit);

        pam4_symbol = 2'b11; #10;
        $display("PAM4 Symbol: %b, NRZ Bit: %b", pam4_symbol, nrz_bit);

        $stop;
    end

endmodule
