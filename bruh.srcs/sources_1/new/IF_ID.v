`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2016 09:02:33 PM
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(Clk, IF_ID_flush, instr, PCResult, PCAddResult, instr_out, PCResult_out, PCAddResult_out);
    input Clk, IF_ID_flush;  // clk what more can you ask for
    input [31:0] instr, PCResult, PCAddResult;    // inputs of the two
    output reg [31:0] instr_out, PCResult_out, PCAddResult_out; // outputs of the two
    
    reg [31:0] instr_reg, PCResult_reg, PCAddResult_reg;
    
    always @(posedge Clk) begin // stores the information on the posedge
        if (IF_ID_flush == 1) begin
            instr_reg <= 0;
            PCResult_reg <= 0;
            PCAddResult_reg <= 0;
        end
        else begin
            instr_reg <= instr;
            PCResult_reg <= PCResult;
            PCAddResult_reg <= PCAddResult;
        end
    end // end always
    
    always @(negedge Clk) begin // outputs the info on the negedge
            instr_out <= instr_reg;
            PCResult_out <= PCResult_reg;
            PCAddResult_out <= PCAddResult_reg;
    end // end always
    
endmodule
