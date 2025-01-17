module tb_weighted2421_to_bcd;

    reg [3:0] weighted2421;
    wire [3:0] bcd;

    // Instantiate the DUT (Device Under Test)
    weighted2421_to_bcd dut (
        .weighted2421(weighted2421),
        .bcd(bcd)
    );

    initial begin
        // Apply test vectors
        $display("2421 Code | BCD Output");
        $monitor("%b       | %b", weighted2421, bcd);

        weighted2421 = 4'b0000; #10; // Test case for 0
        weighted2421 = 4'b0001; #10; // Test case for 1
        weighted2421 = 4'b0010; #10; // Test case for 2
        weighted2421 = 4'b0011; #10; // Test case for 3
        weighted2421 = 4'b0100; #10; // Test case for 4
        weighted2421 = 4'b1011; #10; // Test case for 5
        weighted2421 = 4'b1100; #10; // Test case for 6
        weighted2421 = 4'b1101; #10; // Test case for 7
        weighted2421 = 4'b1110; #10; // Test case for 8
        weighted2421 = 4'b1111; #10; // Test case for 9

        // End simulation
        
    end
endmodule
