`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2016 10:15:14 PM
// Design Name: 
// Module Name: IFU_hardcode_tb
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


module IFU_hardcode_tb();
    reg Reset, Clk;
    //reg [31:0] Address;
    
    wire [31:0] PCResult, Minimum_SAD, X, Y;
    
    IFU_hardcode name(Reset, Clk, PCResult, Minimum_SAD, X, Y);
    
    
    initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end
	
	initial begin
        Reset = 1;
        #5;
        Reset = 0;
	end // end testing
	
	
endmodule
