`timescale 1ns/1ps

module tb_MSDAP;

    // TESTBENCH OUTPUTS TO MSDAP
    reg DCLK = 0;
    reg SCLK = 0;
    reg SCLK_EN = 0;
    reg RESET_N = 0;
    reg START = 0;
    reg FRAME = 0;
    reg SIPO_DATA_IN_L = 0;
    reg SIPO_DATA_IN_R = 0;
    reg INPUTL = 0;
    reg INPUTR = 0;

    // TESTBENCH INPUTS FROM MSDAP
    wire INREADY;
    wire OUTREADY;
    wire DATAOUT_L;
    wire DATAOUT_R;

    // Instantiate DUT
    MSDAP dut (
        .DCLK(DCLK),
        .SCLK(SCLK),
        .RESET_N(RESET_N),
        .START(START),
        .FRAME(FRAME),
        .INPUTL(INPUTL), 
        .INPUTR(INPUTR),  
        .INREADY(INREADY),
        .OUTREADY(OUTREADY),
        .DATAOUT_L(DATAOUT_L),
        .DATAOUT_R(DATAOUT_R)
    );

    // Clock generation (realistic frequencies)
    always #636 DCLK = ~DCLK;  // 786 kHz
    always #19 SCLK = ~SCLK;   // 26.88 MHz

    integer file, status;
    reg [1023:0] line;
    reg [15:0] LEFT, RIGHT;
    reg [15:0] next_LEFT, next_RIGHT;
    integer line_num;
    integer i;

initial begin
file = $fopen("data1.in", "r");
if (!file) begin
    $display("ERROR: Could not open data1.in");
    $finish;
end
        #1000;
        START = 1;
	#50;
        START = 0;

// Prime first line
read_next_line();
LEFT = next_LEFT;
RIGHT = next_RIGHT;

@(posedge DCLK);
RESET_N = 1;

// Transmission loop
while (!$feof(file)) begin
    // Wait for INREADY
    wait (INREADY);
    @(posedge DCLK);

    // Output FRAME and bit 15
    FRAME  = 1;
    INPUTL = LEFT[15];
    INPUTR = RIGHT[15];
    $display("[%0t] FRAME HIGH. Sending LEFT = %h, RIGHT = %h", $time, LEFT, RIGHT);

    // Shift remaining bits
    for (i = 14; i >= 0; i = i - 1) begin
	@(posedge DCLK);
        FRAME = 0;
	INPUTL = LEFT[i];
        INPUTR = RIGHT[i];
        
    end

    // Read next values
    read_next_line();
    LEFT = next_LEFT;
    RIGHT = next_RIGHT;
end

$fclose(file);
$finish;
end

task read_next_line;
    reg [7:0] c1, c2;
    reg [255:0] comment;
    begin
        while (!$feof(file)) begin
            line = "";
            status = $fgets(line, file);
            $sscanf(line, "%c%c", c1, c2);

            if (c1 == "/" && c2 == "/") begin
                // skip comment lines
            end else begin
                status = $sscanf(line, "%h %h //%s", next_LEFT, next_RIGHT, comment);
                if (status >= 2) begin
                    if (comment[39:0] == "reset") begin
                        $display("[%0t] RESET detected!", $time);
                        RESET_N = 0;
                        @(posedge DCLK);
                        RESET_N = 1;
                        @(posedge DCLK);
                    end
                    $display("[%0t] Read LEFT = %h, RIGHT = %h", $time, next_LEFT, next_RIGHT, comment);
                    disable read_next_line;
                end
            end
        end
    end
endtask

endmodule

