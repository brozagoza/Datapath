`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2016 11:55:05 PM
// Design Name: 
// Module Name: ForwardUnit
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


module ForwardUnit(Clk,
ID_EX_Rs, ID_EX_Rt, EX_MEM_Reg, MEM_WB_Reg, Post_WB_Reg,
// use for when reading from DM
WB_MemRead, Post_WB_MemRead,
WB_MemWrite, Post_WB_MemWrite,
ReadData1_ID_EX, ReadData2_ID_EX, WriteData, ALUResult_EX_MEM, Post_WB_Data,
ALUInput1, ALUInput2);

    input Clk;
    input WB_MemRead, Post_WB_MemRead, WB_MemWrite, Post_WB_MemWrite;
    input [4:0] ID_EX_Rs, ID_EX_Rt, 
    EX_MEM_Reg, 
    MEM_WB_Reg,
    Post_WB_Reg;
    
    input [31:0] ReadData1_ID_EX, ReadData2_ID_EX, WriteData, ALUResult_EX_MEM, Post_WB_Data;
    
    output reg [31:0] ALUInput1, ALUInput2;
    
    always @(*) begin
        // ALUInput1
        if (ID_EX_Rs == EX_MEM_Reg && WB_MemRead == 0 && Post_WB_MemRead == 0 && (WB_MemWrite == 0 && Post_WB_MemWrite == 0)) 
            ALUInput1 = ALUResult_EX_MEM;
        else if (ID_EX_Rs == MEM_WB_Reg && (WB_MemRead == 1 || (WB_MemWrite == 0 && Post_WB_MemWrite == 0)))  
            ALUInput1 = WriteData;
        else if (ID_EX_Rs == Post_WB_Reg && (Post_WB_MemRead == 1 || (WB_MemWrite == 0 && Post_WB_MemWrite == 0))) 
            ALUInput1 = Post_WB_Data;
        else if (ID_EX_Rs == EX_MEM_Reg)
            ALUInput1 = ALUResult_EX_MEM;
        else if (ID_EX_Rs == MEM_WB_Reg)
            ALUInput1 = WriteData;
        else if (ID_EX_Rs == Post_WB_Reg)
            ALUInput1 = Post_WB_Data;
        else 
            ALUInput1 = ReadData1_ID_EX;
        
        // ALUInput2
        if (ID_EX_Rt == EX_MEM_Reg && WB_MemRead == 0 && Post_WB_MemRead == 0 && (WB_MemWrite == 0 && Post_WB_MemWrite == 0))  
            ALUInput2 = ALUResult_EX_MEM;
        else if (ID_EX_Rt == MEM_WB_Reg && (WB_MemRead == 1 || (WB_MemWrite == 0 && Post_WB_MemWrite == 0)))
            ALUInput2 = WriteData;
        else if (ID_EX_Rt == Post_WB_Reg && (Post_WB_MemRead == 1 || (WB_MemWrite == 0 && Post_WB_MemWrite == 0)))
            ALUInput2 = Post_WB_Data;
        else if (ID_EX_Rt == EX_MEM_Reg)
            ALUInput2 = ALUResult_EX_MEM;
        else if (ID_EX_Rt == MEM_WB_Reg)
            ALUInput2 = WriteData;
        else if (ID_EX_Rt == Post_WB_Reg)
            ALUInput2 = Post_WB_Data;
        else 
            ALUInput2 = ReadData2_ID_EX;
        
    
    end
                 
    
    
endmodule
