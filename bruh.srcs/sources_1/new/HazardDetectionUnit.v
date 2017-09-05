`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2016 01:41:19 AM
// Design Name: 
// Module Name: HazardDetectionUnit
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

module HazardDetectionUnit(Clk, instr, instr_IF_ID, PCResult, InstructionMemoryOut, PCAdderOut);
    input Clk;
    input [31:0] instr, instr_IF_ID, PCResult;
    output reg [31:0] InstructionMemoryOut, PCAdderOut;
    
    reg dependent;
    reg [4:0] PC_Rs, PC_Rt;
    reg [5:0] functer;
    
    always @(*) begin
        functer = instr[5:0];
        dependent = 0;
        PC_Rs = instr[25:21];
        PC_Rt = instr[20:16];
            
        if (instr_IF_ID[31:26] == 6'b100011 || // lw
            instr_IF_ID[31:26] == 6'b100001 || // lh
            instr_IF_ID[31:26] == 6'b100000 ) // lb
            begin
                if (instr_IF_ID[20:16] == instr[25:21] || instr_IF_ID[20:16] == instr[20:16])
                    dependent = 1;
                
            end


    
    end // end always
    
    always @(*) begin
            if (dependent == 1)
        begin
            InstructionMemoryOut <= 32'b11111111111111111111111111111111;
            PCAdderOut <= PCResult - 4;
        end
    else
        begin
            InstructionMemoryOut <= instr;
            PCAdderOut <= PCResult;
        end
    end
    
    
    
    
endmodule