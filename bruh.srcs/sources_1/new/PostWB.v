`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2016 11:34:37 PM
// Design Name: 
// Module Name: PostWB
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


module PostWB(Clk, Input, MemRead, MemWrite, Output, MemRead_o, MemWrite_o, regIn, regOut);
    input Clk, MemRead, MemWrite;
    input [31:0] Input;
    input [4:0] regIn;
    
    reg [31:0] Register;
    reg [4:0] regReg;
    reg MemRead_r, MemWrite_r;
    
    output reg [31:0] Output;
    output reg [4:0] regOut;
    output reg MemRead_o, MemWrite_o;
    
    initial begin
    MemRead_o = 0;
    MemWrite_o = 0;
    end
    
    always @(posedge Clk) begin
        Register <= Input;
        regReg <= regIn;
        MemRead_r <= MemRead;
        MemWrite_r <= MemWrite;
    end
    
    always @(negedge Clk) begin
        Output <= Register;
        regOut <= regReg;
        MemRead_o <= MemRead_r;
        MemWrite_o <= MemWrite_r;
    end
endmodule
