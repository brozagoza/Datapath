`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2016 12:25:22 AM
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(Clk,
// INPUTS
MemtoReg,
ReadData,
ALUResult, DontMove, jal, WriteRegister, RegWrite,
MemRead, MemWrite, PCResult,
// OUTPUTS
MemtoReg_o,
ReadData_o,
ALUResult_o, DontMove_o, jal_o, WriteRegister_o, RegWrite_o,
MemRead_o, MemWrite_o, PCResult_o
    );
    
    input Clk, MemtoReg, DontMove, jal, RegWrite, MemRead, MemWrite;
    input [31:0] ReadData, ALUResult, PCResult;
    input [4:0] WriteRegister;
    
    reg MemtoReg_r, DontMove_r, jal_r, RegWrite_r, MemRead_r, MemWrite_r;
    reg [31:0] ReadData_r, ALUResult_r, PCResult_r;
    reg [4:0] WriteRegister_r;
    
    output reg MemtoReg_o, DontMove_o, jal_o, RegWrite_o, MemRead_o, MemWrite_o;
    output reg [31:0] ReadData_o, ALUResult_o, PCResult_o;
    output reg [4:0] WriteRegister_o;
    
    initial begin
    MemtoReg_o <= 0;
    DontMove_o <= 0;
    jal_o <= 0;
    RegWrite_o <= 0;
    ReadData_o <= 0;
    ALUResult_o <= 0;
    WriteRegister_o <= 0;
    MemRead_o <= 0;
    MemWrite_o <= 0;
    PCResult_o <= 0;
    end
    
    always @(posedge Clk)begin
        MemtoReg_r <= MemtoReg;
        DontMove_r <= DontMove;
        jal_r <= jal;
        RegWrite_r <= RegWrite;
        ReadData_r <= ReadData;
        ALUResult_r <= ALUResult;
        WriteRegister_r <= WriteRegister;
        MemRead_r <= MemRead;
        MemWrite_r <= MemWrite;
        PCResult_r <= PCResult;
    end
    
    always @(negedge Clk)begin
        MemtoReg_o <= MemtoReg_r;
        DontMove_o <= DontMove_r;
        jal_o <= jal_r;
        RegWrite_o <= RegWrite_r;
        ReadData_o <= ReadData; //ReadData_r;
        ALUResult_o <= ALUResult_r;
        WriteRegister_o <= WriteRegister_r;
        MemRead_o <= MemRead_r;
        MemWrite_o <= MemWrite_r;
        PCResult_o <= PCResult_r;
    end
endmodule
