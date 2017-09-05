`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2016 12:03:17 PM
// Design Name: 
// Module Name: ShiftLeftTwo
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
module ShiftLeftTwo26To28(Inp, Out);

    input [25:0] Inp;
    reg [25:0] tmp;
    output reg [27:0] Out;

        always @(Inp) begin
             Out = Inp << 2;
             //Out = {{2{tmp[25]}}, tmp};
         end

    
endmodule