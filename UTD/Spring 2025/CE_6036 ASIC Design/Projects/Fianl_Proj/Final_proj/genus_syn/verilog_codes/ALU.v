module ALU (
    input wire Sclk,
    input wire uni_reset_n,
    input wire ALU_calc,
    input wire [7:0] input_cnt,
    output wire ppl_stall,
    output reg ALU_finish,
    output wire [39:0] output_data,

    input wire [7:0] R_mem_data,
    input wire [8:0] Co_mem_data,
    input wire [15:0] Data_mem_data,
    output wire [3:0] R_mem_addr,
    output wire [8:0] Co_mem_addr,
    output wire [7:0] Data_mem_addr
);
  parameter WAIT=0;
  parameter RESET=1;
  parameter CALC=2; //Do calculation
  parameter OUTPUT=3; //Output 40-bit data in parallel
  
  reg [1:0] state, next_state;
  reg signed [39:0] ex, y, y_tmp;
  reg [9:0] ite;
  reg [8:0] ite_delay[1:3], R_accu, k;
  wire [7:0] n;
  reg ppl_rst, ppl_run, R_was_1;
  reg [4:0] j;
  reg sign_delay;
  wire [8:0] ite_delay4_plus1, ite_delay4_plus2;
  
  // State Register, and R monitor
  always@(posedge Sclk, negedge uni_reset_n) begin
    if(~uni_reset_n) begin
      state <= WAIT;
      R_was_1 <= 0;
    end
    else begin
      state <= next_state;
      R_was_1 <= (1==R_mem_data);
    end
  end

  // ALU Control
  assign ite_delay3_plus1 = ite_delay[2];
  assign ite_delay3_plus2 = ite_delay[1];
  
  always@(state, ALU_calc, ite_delay[1], R_accu, j) begin
    case(state)
      WAIT: begin
        ALU_finish = 0;
        ppl_rst = 0;
        ppl_run = 0;
        if(ALU_calc)
          next_state = RESET;
        else
          next_state = WAIT;
      end
      RESET: begin
        ALU_finish = 0;
        ppl_rst = 1;
        ppl_run = 0;
        next_state = CALC;
      end
      CALC: begin
        ALU_finish = 0;
        ppl_rst = 0;
        ppl_run = 1;
        if((ite_delay3_plus1 == R_accu) & j[4])
          next_state = OUTPUT;
        else
          next_state = CALC;
      end      
      OUTPUT: begin
        ALU_finish = 1;
        ppl_rst = 0;
        ppl_run = 0;
        next_state = WAIT;
      end
    endcase
  end
  assign output_data = y;
  
  // Calculation Pipeline
  always@(posedge Sclk, negedge uni_reset_n) begin
    if(~uni_reset_n) begin
      y<=0;
      ite<=0; ite_delay[1]<=0; ite_delay[2]<=0; ite_delay[3]<=0; //ite_delay[4]<=0;
      sign_delay <= 0;
      R_accu<=0;
      j<=0;
      k<=0;
      //Data_mem_addr<=0;
    end
    else if (ppl_rst) begin
      y<=0;
      ite<=0; ite_delay[1]<=0; ite_delay[2]<=0; ite_delay[3]<=0; //ite_delay[4]<=0;
      sign_delay <= 0;
      R_accu<=R_mem_data;
      j<=0;
      k<=0;
      //Data_mem_addr<=0;
    end
    else if(ppl_run) begin /*Stall the whole pipeline if R[j]==1 */
      if(1 != R_mem_data) begin
      //1. Fetch coeff(k)
        k <= ite[8:0];
        ite <= ite+1;
        ite_delay[1] <= ite[8:0];

      //2. Fetch input data x(n-k)
        //Asynchronous: Data_mem_addr <= n - Co_mem_data[7:0];
        ite_delay[2] <= ite_delay[1];

      //3. Stall for memory read; Fetch next R
        sign_delay <= Co_mem_data[8];
        ite_delay[3] <= ite_delay[2];
      end
      if( ite_delay[2] == R_accu | (1 == R_mem_data & ~R_was_1) ) begin
        j <= j+1; //Enforce increment if R[j]==1
      end

      if(1 != R_mem_data) begin
      //4. Accumulate y; Shift right if end of calculation loop
      // y_tmp calculated in next always block
        if(ite >= 3) // Accumulate y until the pipeline is initialized
          if(ite_delay3_plus1 == R_accu) 
            y <= y_tmp >>> 1;
          else
            y <= y_tmp;
      end
      if(ite_delay[3] == R_accu | (1 != R_mem_data & R_was_1) )
        R_accu <= R_accu + R_mem_data;
      
    end
  end

  assign ppl_stall = (1==R_mem_data);
  assign Data_mem_addr = n - Co_mem_data[7:0];

  always@(y,sign_delay,Data_mem_data,R_was_1) begin
    if(R_was_1)
      ex = 0;
    else
      ex = {{8{Data_mem_data[15]}}, Data_mem_data, 16'h0};

    if(sign_delay)
      y_tmp = y- ex;
    else
      y_tmp = y+ ex;
  end
  
  assign R_mem_addr = j[3:0];
  assign Co_mem_addr= k;
  assign n = input_cnt-1;
endmodule 
