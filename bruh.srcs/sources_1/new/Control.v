`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2016 01:49:26 PM
// Design Name: 
// Module Name: Controller
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
module Control (Instr, funct, RegDst, Jump, Shft, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, jump_sel, jal);
    
    input [5:0] Instr, funct;  // 6 bits of opcode my dawg
    output reg [5:0] ALUOp; // ALUOp for ALU Controler, needs two bits
    output reg RegDst, Jump, Shft, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, jump_sel, jal;// single bits for mux les
    
    // initializes all flags for POST-IMPLEMENTATION
    initial begin
        RegDst = 0;
        Jump = 0;
        Shft = 0;
        Branch = 0;
        MemRead = 0;
        MemtoReg = 0;
        MemWrite = 0;
        ALUSrc = 0;
        RegWrite = 0;
        ALUOp = 0;
        jump_sel = 0;
        jal = 0;
    end
    
    
    always @(Instr or funct) begin
            RegDst = 0;
            Jump = 0;
            Shft = 0;
            Branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;
            ALUOp = 0;
            jump_sel = 0;
            jal = 0;
        
        case (Instr)
		
            // R-Type
            6'b000000:
            begin
                // generic flags, neccessary changes updated below
                RegDst = 1;
                Jump = 0;
                Shft = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 6'b000000;
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 1; 
                
                if (funct == 6'b000000 || funct == 6'b000010 || funct == 6'b000011) // sll, srl, & sra
                    Shft = 1; // acounts for awkward shift
                    
                if (funct == 6'b010001 || funct == 6'b010011) // mthi & mtlo
                    RegWrite = 0;
                
                if (funct == 6'b001000)
                    begin
                    Jump = 1;
                    jump_sel = 1;
                    end
                
                end
            
            //Addiu
            6'b001001:
            begin
                RegDst = 0;
                Jump = 0;
                Shft = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 6'b000111;
                MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
            end
			
			// Addi
			6'b001000:
			begin
				RegDst = 0;
				Jump = 0;
				Shft = 0;
				Branch = 0;
				MemRead = 0;
				MemtoReg = 0;
				ALUOp = 6'b000011;
				MemWrite = 0;
				ALUSrc = 1;
				RegWrite = 1;
			end
			
			// Mul, madd, msub
            6'b011100:
			begin
			     RegDst = 1;
			     Jump = 0;
			     Shft = 0;
			     Branch = 0;
			     MemRead = 0;
			     MemtoReg = 0;
			     ALUOp = 6'b001110;
			     MemWrite = 0;
			     ALUSrc = 0;
			     RegWrite = 1;
			end
			
			// ori
			6'b001101:
			begin
			     RegDst = 0;
			     Jump = 0;
			     Shft = 0;
			     Branch = 0;
			     MemRead = 0;
			     MemtoReg = 0;
			     ALUOp = 6'b000101;
			     MemWrite = 0;
			     ALUSrc = 1;
			     RegWrite = 1;
			end
			
			// xori
            6'b001110:
            begin
                RegDst = 0;
                Jump = 0;
                Shft = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 6'b010011;
                MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
            end
        
             // andi
            6'b001100:
            begin
                RegDst = 0;
                Jump = 0;
                Shft = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 6'b011011;
                MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
            end
            
            // slti
            6'b001010:
            begin
                RegDst = 0;
                Jump = 0;
                Shft = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 6'b010001;
                MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
            end
            
            // sltiu
            6'b001011:
            begin
                RegDst = 0;
                Jump = 0;
                Shft = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 6'b011110;
                MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
            end
            
            // seh & seb
            6'b011111:
            begin
                RegDst = 1;
                Jump = 0;
                Shft = 1;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 6'b010100;
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 1;
            end
            
            // lw, lh, & lb
            6'b100011, 6'b100001, 6'b100000:
            begin
                RegDst = 0;
                Jump = 0;
                Shft = 0;
                Branch = 0;
                MemRead = 1;
                MemtoReg = 1;
                ALUOp = 6'b101010;
                MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
            end
            
            // sw, sh, & sb
            6'b101011, 6'b101001, 6'b101000:
            begin
                RegDst = 0;
                Jump = 0;
                Shft = 0;
                Branch = 0;
                MemRead = 0;
                // MemtoReg is DONT CARE
                ALUOp = 6'b101010;
                MemWrite = 1;
                ALUSrc = 1;
                RegWrite = 0;
            end
            
            // lui - load upper immediate
            6'b001111:
            begin
                RegDst = 0;
                Jump = 0;
                Shft = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 6'b101011;
                MemWrite = 0;
                ALUSrc = 1;
                RegWrite = 1;
            end
            
            // bgez & bltz
            6'b000001:
            begin
                // RegDst dont care
                Jump = 0;
                Shft = 0;
                Branch = 1;
                MemRead = 0;
                //MemtoReg dont care
                ALUOp = 6'b101100;
                MemWrite = 0;
                // ALUSrc dont care
                RegWrite = 0;
            end
            
            //beq
            6'b000100:
            begin
                // RegDst dont care
                Jump = 0;
                Shft = 0;
                Branch = 1;
                MemRead = 0;
                // MemtoReg dont care
                ALUOp = 6'b101101;
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 0;
            end
            
            //bneq
            6'b000101:
            begin
                // RegDst dont care
                Jump = 0;
                Shft = 0;
                Branch = 1;
                MemRead = 0;
                // MemtoReg dont care
                ALUOp = 6'b101110;
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 0;
            end
            
            //bgtz
            6'b000111:
            begin
                // RegDst dont care
                Jump = 0;
                Shft = 0;
                Branch = 1;
                MemRead = 0;
                // MemtoReg dont care
                ALUOp = 6'b101111;
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 0;
            end
            
            
            // blez
            6'b000110:
            begin
                // RegDst dont care
                Jump = 0;
                Shft = 0;
                Branch = 1;
                MemRead = 0;
                // MemtoReg dont care
                ALUOp = 6'b110000;
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 0;
            end
            
            // jump
            6'b000010:
            begin
                Jump = 1;
                jump_sel = 0;
                Shft = 0;
                Branch = 0;
                MemWrite = 0;
                RegWrite = 0;
            end
            
            // jal
            6'b000011:
            begin
                RegDst = 0;
                Jump = 1;
                jump_sel = 0;
                Shft = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                ALUOp = 6'b101011;
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 1;
                jal = 1;
            end
            
            // nop
            6'b111111:
            begin
                RegDst = 0;
                Jump = 0;
                Shft = 0;
                Branch = 0;
                MemRead = 0;
                MemtoReg = 0;
                MemWrite = 0;
                ALUSrc = 0;
                RegWrite = 0;
                ALUOp = 0;
                jump_sel = 0;
                jal = 0;
            end
        endcase // closes the switch statement
    
    
    end // closes always block
    
    
endmodule
    
    
    