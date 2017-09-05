`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2016 11:29:28 PM
// Design Name: 
// Module Name: DM_ForwardUnit
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


module DM_ForwardUnit(
EX_MEM_Rt, MEM_WB_Reg, Post_WB_Reg,
ReadData2_EX_MEM, WriteData, Post_WB_Data,
DM_Forward_Out
    );
    input [4:0] EX_MEM_Rt, MEM_WB_Reg, Post_WB_Reg;
    input [31:0] ReadData2_EX_MEM, WriteData, Post_WB_Data;
    output reg [31:0] DM_Forward_Out;
    
    always @(*) begin
        // DM_Forward_Out
        if (EX_MEM_Rt == MEM_WB_Reg) DM_Forward_Out = WriteData;
        else if (EX_MEM_Rt == Post_WB_Reg) DM_Forward_Out = Post_WB_Data;
        else DM_Forward_Out = ReadData2_EX_MEM;
    
    end
    
    
    
endmodule
