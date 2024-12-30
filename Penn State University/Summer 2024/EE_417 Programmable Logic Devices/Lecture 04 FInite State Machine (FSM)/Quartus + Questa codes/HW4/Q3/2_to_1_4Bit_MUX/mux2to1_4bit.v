/*---------------------------------------------------------------------------------
Name Lamin Jammeh
CLass: EE417 Summer 2024
Lesson 04 HW Question 4 Part 3
Group: Ron Kalin/ Lamin Jammeh
Project Description: This portion takes uses a 2-to-1 MUX to select between up and down
counter. when the sel bit is high the upcounter output is transfered to the next stage
else the downcounter output is transfered to the next state
------------------------------------------------------------------------------------*/

module mux2to1_4bit(	
    input [3:0] data0, // 4-bit input data 0	
    input [3:0] data1, // 4-bit input data 1	
    input select,      // Select signal (0 or 1), z	
    output reg [3:0] muxout); //4-bit output	
    always @ (data0, data1)  //put input only in sensitivity list	
        if (select)  //select = 1	
            muxout = data1;  //data1	
        else	
            muxout = data0;  //data0
endmodule 