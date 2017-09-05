`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2016 06:35:22 PM
// Design Name: 
// Module Name: FlushUnit
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

// this unit sends flushing signals so that the previous pipelines dont pass anything
module FlushUnit(AndGateOut, jump_EX_MEM, IF_ID_flush, ID_EX_flush, EX_MEM_flush);
    input AndGateOut, jump_EX_MEM;
    output reg IF_ID_flush, ID_EX_flush, EX_MEM_flush;
    
    // flush signals my dawg
    initial begin
        IF_ID_flush = 0;
        ID_EX_flush = 0;
        EX_MEM_flush = 0;
    end
    
    
    always @(AndGateOut or jump_EX_MEM)begin
        if (AndGateOut == 1 || jump_EX_MEM == 1)
        begin
            IF_ID_flush = 1;
            ID_EX_flush = 1;
            EX_MEM_flush = 1;
        end // end if
        else
        begin
            IF_ID_flush = 0;
            ID_EX_flush = 0;
            EX_MEM_flush = 0;
        end
    end // close always
        
    
endmodule
