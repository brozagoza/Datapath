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


module BIG_DADDY_tb();
    reg Reset, Clk;
    //reg [31:0] Address;
    
    wire [6:0] out7; //seg a, b, ... g
    wire [7:0] en_out;
    
    BIG_DADDY callbigdad(Clk, Reset, out7, en_out);
    
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
