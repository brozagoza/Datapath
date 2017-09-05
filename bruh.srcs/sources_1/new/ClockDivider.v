`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2016 05:30:23 PM
// Design Name: 
// Module Name: ClockDivider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ClockDivider(Clk, Reset, Clk_out);
    input Clk, Reset;
    output reg Clk_out;
    integer bingo= 10000000; // 10 MHz
    integer holder = 0;
    
    always @(posedge Clk) begin
    if (Reset == 1'b1)
        holder = 0;
    else
        holder = holder + 1;
        
    if(holder == bingo)begin
            Clk_out <= ~Clk_out;
            holder = 0;
            end
    end // end always


endmodule
