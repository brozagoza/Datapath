`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2016 03:14:13 PM
// Design Name: 
// Module Name: HiLoReg
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


module HiLoReg(Clk, HiWrite, LoWrite, ALUOut, ALUControl, ALUResult, Hi, Lo, Out);
    input Clk, HiWrite, LoWrite, ALUOut;
    input [31:0] ALUResult, Hi, Lo;
    input [5:0] ALUControl;
    
    reg [31:0] Hi_r;
    reg [31:0] Lo_r;
    
    output reg [31:0] Out;
    
    always @(*) begin
        if (HiWrite == 1) Hi_r = Hi;
        if (LoWrite == 1) Lo_r = Lo;
        
        if (ALUOut == 1)
            Out = ALUResult;
        else if (ALUControl == 6'b010000) // Hi
            Out = Hi_r;
        else if (ALUControl == 6'b011111) // Lo
            Out = Lo_r;
        else
            Out = ALUResult;
        
    end
    

    
    
    
endmodule
