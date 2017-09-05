`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2016 05:45:41 PM
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM(Clk, EX_MEM_flush,
// INPUTS
instr, PCResult, PCAddResult, // 1
ReadData2, Branch, MemRead, MemWrite, MemtoReg, RegWrite,// 2 
WriteRegister, // ALU 3
ALUResult, Zero, DontMove, branchAddOut, // ALU 3
jump, jal, jump_sel, // jump muxes 4
// OUTPUTS
instr_o, PCResult_o, PCAddResult_o,// 1
ReadData2_o, Branch_o, MemRead_o, MemWrite_o, MemtoReg_o, RegWrite_o, // 2 
WriteRegister_o, // ALU 3
ALUResult_o, Zero_o, DontMove_o, branchAddOut_o, // ALU 3
jump_o, jal_o, jump_sel_o // jump muxes 4
);

    input Clk, EX_MEM_flush;
    
    input [31:0] instr, PCResult, PCAddResult, ReadData2;
    input Branch, MemRead, MemWrite, MemtoReg, RegWrite;
    input [4:0] WriteRegister;
    input [31:0] ALUResult, branchAddOut;
    input Zero, DontMove;
    input jump, jal, jump_sel;
    
    output reg [31:0] instr_o, PCResult_o, PCAddResult_o, ReadData2_o;
    output reg Branch_o, MemRead_o, MemWrite_o, MemtoReg_o, RegWrite_o;
    output reg [4:0] WriteRegister_o;
    output reg [31:0] ALUResult_o, branchAddOut_o;
    output reg Zero_o, DontMove_o;
    output reg jump_o, jal_o, jump_sel_o;
    
    reg [31:0] instr_r, PCResult_r, PCAddResult_r, ReadData2_r;
    reg Branch_r, MemRead_r, MemWrite_r, MemtoReg_r, RegWrite_r;
    reg [4:0] WriteRegister_r;
    reg [31:0] ALUResult_r, branchAddOut_r;
    reg Zero_r, DontMove_r;
    reg jump_r, jal_r, jump_sel_r;
     
    
    always @(posedge Clk) begin
        if (EX_MEM_flush == 1) begin
            instr_r <= 0;
            PCResult_r <= 0;
            PCAddResult_r <= 0;
            ReadData2_r <= 0;
            Branch_r <= 0;
            MemRead_r <= 0;
            MemRead_o <= 0;
            MemWrite_r <= 0;
            MemWrite_o <= 0;
            MemtoReg_r <= 0;
            RegWrite_r <= 0;
            WriteRegister_r <= 0;
            ALUResult_r <= 0;
            branchAddOut_r <= 0;
            Zero_r <= 0;
            DontMove_r <= 0;
            jump_r <= 0;
            jal_r <= 0;
            jump_sel_r <= 0;
        end        
        else begin
            instr_r <= instr;
            PCResult_r <= PCResult;
            PCAddResult_r <= PCAddResult;
            ReadData2_r <= ReadData2;
            Branch_r <= Branch;
            MemRead_r <= MemRead;
            MemRead_o <= MemRead;
            MemWrite_r <= MemWrite;
            MemWrite_o <= MemWrite;
            MemtoReg_r <= MemtoReg;
            RegWrite_r <= RegWrite;
            WriteRegister_r <= WriteRegister;
            ALUResult_r <= ALUResult;
            branchAddOut_r <= branchAddOut;
            Zero_r <= Zero;
            DontMove_r <= DontMove;
            jump_r <= jump;
            jal_r <= jal;
            jump_sel_r <= jump_sel;
        end
    end // close always
    
    always @(negedge Clk) begin
        instr_o <= instr_r;
        PCResult_o <= PCResult_r;
        PCAddResult_o <= PCAddResult_r;
        ReadData2_o <= ReadData2_r;
        Branch_o <= Branch_r;
        //MemRead_o <= MemRead_r;
        //MemWrite_o <= MemWrite_r;
        MemtoReg_o <= MemtoReg_r;
        RegWrite_o <= RegWrite_r;
        WriteRegister_o <= WriteRegister_r;
        ALUResult_o <= ALUResult_r;
        branchAddOut_o <= branchAddOut_r;
        Zero_o <= Zero_r;
        DontMove_o <= DontMove_r;
        jump_o <= jump_r;
        jal_o <= jal_r;
        jump_sel_o <= jump_sel_r;
    end // close always
    
     
     
endmodule
