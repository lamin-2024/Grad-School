module FIFO (
    Data_out,                        // Data path from FIFO
    empty,                           // Flag asserted high for empty stack
    full,                            // Flag asserted high for full stack
    Data_in,                         // Data path into FIFO 
    wr_enable,                       // Input controlling a write to FIFO memory stack
    rd_enable,                       // Input controlling a read to stack
    clk,
    rst
);

parameter FIFO_width  = 16;          // Width of stack and Data path
parameter FIFO_height = 4;           // Height of stack (# of words)
parameter ptr_width   = 2;           // Width of read and write pointers to address the FIFO words 

output reg [FIFO_width -1: 0] Data_out;
output                       empty, full;
input  [FIFO_width -1: 0]    Data_in;
input                        clk, rst;
input                        wr_enable, rd_enable;

// Pointers for reading and writing 
reg [ptr_width -1: 0] read_ptr, write_ptr;
reg [ptr_width -1: 0] ptr_diff;

// Memory FIFO register
reg [FIFO_width -1: 0] FIFO_Mem [FIFO_height -1:0];  // Memory array

// Empty and full flags
assign empty = (ptr_diff == 0)             ? 1'b1 : 1'b0;
assign full  = (ptr_diff == FIFO_height)   ? 1'b1 : 1'b0;

always @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        Data_out   <= 0;
        read_ptr   <= 0;
        write_ptr  <= 0;
        ptr_diff   <= 0;
    end
    else if (rd_enable && !empty)  // Read request and FIFO not empty
    begin
        Data_out   <= FIFO_Mem[read_ptr];
        read_ptr   <= read_ptr + 1;
        ptr_diff   <= ptr_diff - 1;
    end 
    else if (wr_enable && !full)  // Write request and FIFO not full
    begin
        FIFO_Mem[write_ptr] <= Data_in;
        write_ptr           <= write_ptr + 1;
        ptr_diff            <= ptr_diff + 1;
    end 
end 

endmodule
