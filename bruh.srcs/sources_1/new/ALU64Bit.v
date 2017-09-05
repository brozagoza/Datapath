`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: 4-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU behaviorally, so that it supports addition,  subtraction,
// AND, OR, and set on less than (SLT). The 'ALUResult' will output the 
// corresponding result of the operation based on the 32-Bit inputs, 'A', and 
// 'B'. The 'Zero' flag is high when 'ALUResult' is '0'. The 'ALUControl' signal 
// should determine the function of the ALU based on the table below:-
// Op   | 'ALUControl' value
// ==========================
// ADD  | 0010
// SUB  | 0110
// AND  | 0000
// OR   | 0001
// SLT  | 0111
// MUL  | 1000
//
// NOTE:-
// SLT (i.e., set on less than): ALUResult is '32'h000000001' if A < B.
// 
////////////////////////////////////////////////////////////////////////////////

module ALU64Bit(Clk, ALUControl, A, B, instr_6, instr_21, ALUResult, Zero, DontMove,
Hi, Lo, HiWrite, LoWrite, ALUOut); // A 25-21, B 20-16, ALUResult 15-11

    input Clk;
	input [5:0] ALUControl;  // control bits for ALU operation
	input [31:0] A, B;	     // inputs
	input instr_6;           // bit # 6 from instruction
	input instr_21;          // bit # 21 from instr

    reg [63:0] temp;        // holds the temp of complicated instructions
    output reg [31:0] Hi;          // holds the HI from complicated instructions
    output reg [31:0] Lo;   // holds the LO from complicated instructions
    reg [31:0] x, y,z;
    reg tempBit; 			// for SRA
    integer i;
    integer A_int;

	output reg [31:0] ALUResult;	// answer
	output reg Zero;	    // Zero=1 if ALUResult == 0
    output reg DontMove;
    output reg HiWrite, LoWrite, ALUOut;
    
    initial begin
        DontMove = 0;
        ALUResult = 0;
        Hi = 0;
        Lo = 0;
        x = 0;
        y = 0;
        z = 0;
        tempBit = 0;
        Zero = 0;
        end
    
    /* Please fill in the implementation here... */ // fine i'll do the implementation, geeze
    always @(ALUControl or A or B or instr_6 or instr_21) begin
        DontMove = 0; // used for movn and movz
        ALUResult = 0;
        x = 0;
        y = 0;
        z = 0;
        Hi = 0;
        Lo = 0;
        tempBit = 0;
        Zero = 0;
        HiWrite = 0;
        LoWrite = 0;
        ALUOut = 0;
        
		case(ALUControl)		
     		6'b000010: ALUResult = $signed(A + B); // ADD
       		6'b000110: ALUResult = $signed(A - B); // SUB
            6'b000000: ALUResult = A & B; // AND
        	6'b000001: ALUResult = A | B; // OR
            6'b010001: ALUResult = ~(A | B); // NOR
			6'b010010: ALUResult = A ^ B; // XOR
			6'b100010: ALUResult = {B[15:0], 16'b0000000000000000};  // LUI
			6'b100011: if ($signed(A) >= 0) ALUResult = 0; else ALUResult = 1;// bgez
			6'b100100: if ($signed(A) < 0) ALUResult = 0; else ALUResult = 1; // bltz
			6'b100101: if ($signed(A == B)) ALUResult = 0; else ALUResult = 1; // beq
			6'b100110: if ($signed(A != B)) ALUResult = 0; else ALUResult = 1; // bneq
			6'b100111: if ($signed(A) > 0) ALUResult = 0; else ALUResult = 1; // bgtz
			6'b101000: if ($signed(A) < 0) ALUResult = 0; else ALUResult = 1; // bltz
			6'b101001: ALUResult = A; // jr
			
			// addiu
			6'b000011:
			begin
//			     if (A[31] == 1) ALUResult = 0 - A;
//			     else ALUResult = A;
			     
//			     if (B[31] == 1) ALUResult = ALUResult - B;
//			     else ALUResult = ALUResult + B;
                ALUResult = A + B;			     
			end
			
       		6'b000111: // SLT
            begin // begin else if
                if ($signed(A < B)) ALUResult = 1;
                else ALUResult = 0;
            end // close else if
            
            // SLTU
            6'b011110:
            begin
//                if (A[31] == 1) x = 0 - A;
//                else 
                    x = A;
//                if (B[31] == 1) y = 0 - B;
//                else 
                    y = B;
                
                if (x < y) ALUResult = 1;
                else ALUResult = 0;
            end
            

            // MOVN
			6'b011001: 
            begin // begin else if
				if(B != 0)begin
					ALUResult = A;
				end
				else DontMove = 1;
               
            end // close else if
				
		    // MOVZ
			6'b011010: 
            begin // begin else if
				if(B == 0)begin
					ALUResult = A;
				end               
                else DontMove = 1;
            end // close else if
		
          // sllv
          6'b010011: ALUResult = B << A; // rt = B
          
          // srl
          6'b010100: 
          begin
            if (instr_21 == 0) ALUResult = B >> A; // srl
		    // rotate word
		    else begin // rotate word
		      x = B >> A;
              y = B << (32 - A);
              ALUResult = y | x;
		    end // end else
		  end // end case statement
		  
		  // srlv & rotrv
		  6'b010111:
		  begin
		      if (instr_6 == 0) ALUResult = B >> A; // srlv
		      else begin // rotrv
		          x = B >> A;
		          y = B << (32 - A);
		          ALUResult = y | x;
		      end // end else
		  end // end case statement
			
		  // sra
		  6'b011100:
		  begin
//		      tempBit = B[31];
//		      x = B >> A;
//		      //for (i = 32 - A; i < 32; i = i+1)
//		        //  x[i] = tempBit;
//              if (tempBit == 1)
//              begin
//                //// BROKEN SRA IS BROKEN I REPREAT IT IS BROKEN
//              end
              tempBit = B[31];
		      ALUResult = B >> 31;
		      
		      for (i = 31; i > 0; i = i - 1)
		          ALUResult[i] = tempBit;
		      
		  end
		  
		  // SEH & SEB
            6'b000101: 
              begin
                  if (A == 5'b11000) // SEH
                  begin
                      x = {16'b0000000000000000, B[15:0]};
                      tempBit = B[15];
                      for (i = 16; i < 32; i = i + 1)
                          x[i] = tempBit;
                      ALUResult = x;
                  end
                  else
                  begin // SEB
                      x = {24'b000000000000000000000000, B[7:0]};
                      tempBit = B[7];
                      for (i = 8; i < 32; i = i + 1)
                      x[i] = tempBit;
                      ALUResult = x;
                  end
              end // end case
              
              6'b010000: ALUResult = Hi;     // MFHI
              6'b011111: ALUResult = Lo;     // MFLO
            6'b100000: begin Hi = A; HiWrite = 1; end            // MTHI                                  ADDED 10/20/16
            6'b100001: begin Lo = A; LoWrite = 1; end            // MTLO                                  ADDED 10/20/16
            // MULT
           6'b001000:
           begin
               temp = $signed(A * B);
               Hi = temp[63:32];
               Lo = temp[31:0];
               HiWrite = 1;
               LoWrite = 1;
           end // close MULT case

           // MULTU
           6'b001001: 
           begin
//                if (A[31] == 1) x = 0 - A;
//                else 
                x = A;
               
//                if (B[31] == 1) y = 0 - B;
//                else 
                y = B;
               
               temp = x * y;
               Hi = temp[63:32];
               Lo = temp[31:0];
                HiWrite = 1;
               LoWrite = 1;
           end // close MULTU case
           
//////////////// THE MUL FAMILY IS HERE
           // mul
           6'b001011:
           begin
                temp = A * B;
                ALUResult = temp[31:0];
                Hi = temp[63:32];
                Lo = temp[31:0];
               HiWrite = 1;
                LoWrite = 1;
                ALUOut = 1;
           end
           
           // madd
           6'b001101:
           begin
                temp = {Hi, Lo} + (A * B);
                Hi = temp[63:32];
                Lo = temp[31:0];
               HiWrite = 1;
                LoWrite = 1;
           end
           
           //msub
           6'b011011:
           begin
                temp = {Hi, Lo} - (A * B);
                Hi = temp[63:32];
                Lo = temp[31:0];
               HiWrite = 1;
                LoWrite = 1;
           end
//////////// THE MUL FAMILY IS GONEEEEEE
        
              

		endcase ////////////////////////////////////////////////// closes the CASE STATEMENT
        
        
        
        // will raise the zero flag if need be
         if (ALUResult == 0)
            Zero = 1;
        else
            Zero = 0;
    
    
    end // close always block
    
    

endmodule