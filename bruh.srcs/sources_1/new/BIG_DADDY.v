`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2016 05:59:51 PM
// Design Name: 
// Module Name: BIG_DADDY
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


module BIG_DADDY(Clk, Reset, out7, en_out);
    input Clk, Reset;
    
    wire [31:0] PCResult, min_sad, x, y;
    wire Clk_out;
    
    output [6:0] out7; //seg a, b, ... g
    output [7:0] en_out;
    
    
    ClockDivider Clock_div(Clk, Reset, Clk_out);
    IFU_hardcode insta_call_GURL(Reset, Clk_out, PCResult, min_sad, x, y);
    Two4DigitDisplay display_dawg(Clk, x, y, out7, en_out);
    
    
endmodule
