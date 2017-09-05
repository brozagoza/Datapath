`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2016 02:45:25 PM
// Design Name: 
// Module Name: ALUcontrol
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

module ALUControl(funct, instr20_16, ALUOp, ALUControlOut);
    input [5:0] funct;
    input [4:0] instr20_16; // instructions 20-16
    input [5:0] ALUOp;
    output reg [5:0] ALUControlOut;
    
    always @(ALUOp or funct or instr20_16) begin
                ALUControlOut = 0;

        // R-Type (here we actually care about the funct field)
        if (ALUOp == 6'b000000)
            
            case (funct) // we only care about 4 least sig bits
                6'b100000: ALUControlOut <= 6'b000010; // ADD rd <- rs+rt
				6'b100010: ALUControlOut <= 6'b000110; // SUB
                6'b100100: ALUControlOut <= 6'b000000; // AND
				6'b100101: ALUControlOut <= 6'b000001; // OR
				6'b100111: ALUControlOut <= 6'b010001; // NOR
				6'b100110: ALUControlOut <= 6'b010010; // XOR
				6'b010000: ALUControlOut <= 6'b010000; // MFHI
				6'b010010: ALUControlOut <= 6'b011111;// MFLO
				
                6'b101010: ALUControlOut <= 6'b000111; // SLT
				
				6'b100001: ALUControlOut <= 6'b000011; // ADDU rd <- rs+rt
				6'b011000: ALUControlOut <= 6'b001000; // MULT (HI, LO) <- rs * rt

				6'b011001: ALUControlOut <= 6'b001001; // MULTU (HI, LO) <- rs * rt
				6'b001011: ALUControlOut <= 6'b011001; // MOVN
				6'b001010: ALUControlOut <= 6'b011010; // MOVZ
				
				6'b000000: ALUControlOut <= 6'b010011; // SLL
				6'b000010: ALUControlOut <= 6'b010100; // SRL & ROTR
				6'b000100: ALUControlOut <= 6'b010011; // SLLV

				6'b000110: ALUControlOut <= 6'b010111; // SRLV & ROTRV

				6'b000011: ALUControlOut <= 6'b011100; // SRA
				6'b000111: ALUControlOut <= 6'b011100; // SRAV
				6'b101011: ALUControlOut <= 6'b011110; // SLTU
				
				6'b010001: ALUControlOut <= 6'b100000; // MTHI
				6'b010011: ALUControlOut <= 6'b100001; // MTLO
				6'b001000: ALUControlOut <= 6'b101001; // jr


            endcase // R-Type Switch Statement
        
        // ADD-Immediate
        else if (ALUOp == 6'b000011)
            ALUControlOut <= 6'b000010; // ADD
            
        // ADDU
        else if (ALUOp == 6'b000111)
            ALUControlOut <= 6'b000011; // ADDU
        
        
        // MUL  &&  MADD  &&  MSUB
        else if (ALUOp == 6'b001110)
            case (funct)
                6'b000010: ALUControlOut <= 6'b001011; // mul
                6'b000000: ALUControlOut <= 6'b001101; // madd
                6'b000100: ALUControlOut <= 6'b011011; // msub
            endcase // MUL family Switch Statement
        
        // ori
        else if (ALUOp == 6'b000101)
            ALUControlOut <= 6'b000001; // ORI
        
        // xori
        else if (ALUOp == 6'b010011)
            ALUControlOut <= 6'b010010; // XORI
            
        // andi
        else if (ALUOp == 6'b011011)
            ALUControlOut <= 6'b000000; // ANDI
        
        // slti
        else if (ALUOp == 6'b010001)
            ALUControlOut <= 6'b000111; // SLTI
        
        //stliu
        else if (ALUOp == 6'b011110)
            ALUControlOut <= 6'b011110; // SLTIU
            
        // SEH & SEB
        else if (ALUOp == 6'b010100)
            ALUControlOut <= 6'b000101; // seh & seb
        
        // LW & SW... LH & SH... LB & SB
        else if (ALUOp == 6'b101010)
            ALUControlOut <= 6'b000010; // lw & sw does just an add
        
        // LUI
        else if (ALUOp == 6'b101011)
            ALUControlOut <= 6'b100010; // lui bro
        
        // Branch family
        else if (ALUOp == 6'b101100)
            case (instr20_16)
                5'b00001: ALUControlOut <= 6'b100011; // bgez
                5'b00000: ALUControlOut <= 6'b100100; // bltz
            endcase
        
        // beq
        else if (ALUOp == 6'b101101)
            ALUControlOut <= 6'b100101; // beq
        
        // bneq
        else if (ALUOp == 6'b101110)
            ALUControlOut <= 6'b100110; // bneq
                
        // bgtz
        else if (ALUOp == 6'b101111)
            ALUControlOut <= 6'b100111; // bgtz
        
        //
        else if (ALUOp == 6'b110000)
            ALUControlOut <= 6'b101000; // blez
        
    end // closes the always block
    
endmodule