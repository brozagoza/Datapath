`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2016 09:28:33 PM
// Design Name: 
// Module Name: ID_EX
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


module ID_EX( Clk, ID_EX_flush,
// INPUTS
instr, PCResult, PCAddResult, // 1
RegDst, Jump, Shft, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, jump_sel, jal, RegWrite, // 2
ReadData1, ReadData2, // 3
signextension_out, // 4
// OUTPUTS
instr_o, PCResult_o, PCAddResult_o, // 1
RegDst_o, Jump_o, Shft_o, Branch_o, MemRead_o, MemtoReg_o, ALUOp_o, MemWrite_o, ALUSrc_o, // 2
jump_sel_o, jal_o, RegWrite_o, // 2
ReadData1_o, ReadData2_o, // 3
signextension_out_o // 4
);

input Clk, ID_EX_flush;

/// Carry through
input [31:0] instr, PCResult, PCAddResult;
output reg [31:0] instr_o, PCResult_o, PCAddResult_o;
reg [31:0] instr_r, PCResult_r, PCAddResult_r;

///

/// Control outputs
input [5:0] ALUOp;
input RegDst, Jump, Shft, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, jump_sel, jal, RegWrite;
output reg [5:0] ALUOp_o;
output reg RegDst_o, Jump_o, Shft_o, Branch_o, MemRead_o, MemtoReg_o, MemWrite_o, ALUSrc_o, // 2
            jump_sel_o, jal_o, RegWrite_o; // 2
reg [5:0] ALUOp_r;
reg RegDst_r, Jump_r, Shft_r, Branch_r, MemRead_r, MemtoReg_r, MemWrite_r, ALUSrc_r, // 2
            jump_sel_r, jal_r, RegWrite_r; // 2
///

/// RegisterFile outputs
input [31:0] ReadData1, ReadData2;
output reg [31:0] ReadData1_o, ReadData2_o; // 3
reg [31:0] ReadData1_r, ReadData2_r;
///

/// SignExtension outputs
input [31:0] signextension_out;
output reg [31:0] signextension_out_o; // 4
reg [31:0] signextension_out_r;
///


always @(posedge Clk) begin // stores the information on posedge
    if (ID_EX_flush == 1) begin
    /// Carry through
    instr_r <= 0;
    PCResult_r <= 0;
    PCAddResult_r <= 0;
    
    ///
    
    /// Control Outputs
    ALUOp_r <= 0;
    RegDst_r <= 0;
    Jump_r <= 0;
    Shft_r <= 0;
    Branch_r <= 0;
    MemRead_r <= 0;
    MemtoReg_r <= 0;
    MemWrite_r <= 0;
    ALUSrc_r <= 0;
    jump_sel_r <= 0;
    jal_r <= 0;
    RegWrite_r <= 0;
    ///
    
    /// RegisterFile outputs
    ReadData1_r <= 0;
    ReadData2_r <= 0;
    ///
    
    /// Sign Extension Outputs
    signextension_out_r <= 0;
    ///
    end
    else begin
    /// Carry through
    instr_r <= instr;
    PCResult_r <= PCResult;
    PCAddResult_r <= PCAddResult;
    ///
    
    /// Control Outputs
    ALUOp_r <= ALUOp;
    RegDst_r <= RegDst;
    Jump_r <= Jump;
    Shft_r <= Shft;
    Branch_r <= Branch;
    MemRead_r <= MemRead;
    MemtoReg_r <= MemtoReg;
    MemWrite_r <= MemWrite;
    ALUSrc_r <= ALUSrc;
    jump_sel_r <= jump_sel;
    jal_r <= jal;
    RegWrite_r <= RegWrite;
    ///
    
    /// RegisterFile outputs
    ReadData1_r <= ReadData1;
    ReadData2_r <= ReadData2;
    ///
    
    /// Sign Extension Outputs
    signextension_out_r <= signextension_out;
    ///
    end
    
end // close always posedge

always @(negedge Clk) begin // stores the information on posedge
    /// Carry through
    instr_o <= instr_r;
    PCResult_o <= PCResult_r;
    PCAddResult_o <= PCAddResult_r;

    
    /// Control Outputs
    ALUOp_o <= ALUOp_r;
    RegDst_o <= RegDst_r;
    Jump_o <= Jump_r;
    Shft_o <= Shft_r;
    Branch_o <= Branch_r;
    MemRead_o <= MemRead_r;
    MemtoReg_o <= MemtoReg_r;
    MemWrite_o <= MemWrite_r;
    ALUSrc_o <= ALUSrc_r;
    jump_sel_o <= jump_sel_r;
    jal_o <= jal_r;
    RegWrite_o <= RegWrite_r;
    ///
    
    /// RegisterFile outputs
    ReadData1_o <= ReadData1_r;
    ReadData2_o <= ReadData2_r;
    ///
    
    /// Sign Extension Outputs
    signextension_out_o <= signextension_out_r;
    ///
    
end // close always posedge









    
endmodule
