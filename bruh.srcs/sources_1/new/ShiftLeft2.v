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
module ShiftLeft2(Inp, Out);

    input [31:0] Inp;
    output reg [31:0] Out;

        always @(Inp) begin
             Out <= Inp << 2;  // SignExtendIn shifted left by 2
         end
    
    
endmodule