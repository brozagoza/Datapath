`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
//
//
// Student(s) Name and Last Name: Alejandro Zaragoza 50%
//                                Dalton J Hirst 50%
//
//
// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//
// 
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////

module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, Clk, RegWrite, ReadData1, 
ReadData2, DontMove, jal, PC, oldPC,
minimum_sad, x_cord, y_cord);
    
	input [4:0] ReadRegister1,
                ReadRegister2,
                WriteRegister;
      input [31:0] WriteData, PC, oldPC;
      input RegWrite,
            Clk,
            DontMove,
            jal;
    
    integer i;
    
    output reg [31:0] ReadData1;
    output reg [31:0] ReadData2;
    
    //========== For demoing purposes ============
    output reg [31:0] minimum_sad, x_cord, y_cord;
    //=============================================*/
    
    reg [31:0] Registers[0:31];
    
    initial begin
        for (i = 0; i < 32; i = i + 1)
            Registers[i] = 0;
        
        // initial conditions that must be changed everytime
        Registers[4] = 0;   // a0 = first spot of the dimensions
        Registers[5] = 16;   // a1 = first spot of the frame array
        Registers[6] = 16400;   // a2 = first spot of the window array
    end
    
    
    /// ORIGINAL CODE FOR REGFILE
//    always @(posedge Clk) begin
//        // If RegWrite is high during rising edge than WriteData into the register 
//        // specificed by the WriteRegister input
//        if (RegWrite == 1 && DontMove == 0 && jal == 0)
//                Registers[WriteRegister] <= WriteData;
//        else if (RegWrite == 1 && jal == 1)
//                Registers[31] = oldPC + 4;
        
                
//    end // end always
    
//    always @(negedge Clk) begin
//        // On negedge Clk, ReadData1 and ReadData2 contain the data held at 
//        // the respective ReadRegister1 & ReadRegister2 addresses
//        ReadData1 <= Registers[ReadRegister1];
//        ReadData2 <= Registers[ReadRegister2];
            
        
//    end // end always

        always @(posedge Clk)begin
            if (RegWrite == 1 && DontMove == 0 && jal == 0 && ReadRegister1 == WriteRegister)
                ReadData1 <= WriteData;
            else
                ReadData1 <= Registers[ReadRegister1];
            
            if (RegWrite == 1 && DontMove == 0 && jal == 0 && ReadRegister2 == WriteRegister)
                ReadData2 <= WriteData;
            else
                ReadData2 <= Registers[ReadRegister2];
        end
        
        always @(posedge Clk)begin
        // If RegWrite is high during rising edge than WriteData into the register 
        // specificed by the WriteRegister input
        if (RegWrite == 1 && DontMove == 0 && jal == 0)
                Registers[WriteRegister] <= WriteData;
        else if (RegWrite == 1 && jal == 1)
                Registers[31] = oldPC + 4;
        
        // I repeat... FOR DEMOING ONLY DONT FREAK OUT PLZZ
        minimum_sad <= Registers[8];
        x_cord <= Registers[2];
        y_cord <= Registers[3];
        
        end

//        always @(negedge Clk) begin
//            if (RegWrite == 1 && jal == 1)
//                    Registers[31] = oldPC + 4;
//        end
    // ORIGINAL CODE FOR REGFILE
//    always @(posedge Clk) begin
//        // If RegWrite is high during rising edge than WriteData into the register 
//        // specificed by the WriteRegister input
//        if (RegWrite == 1 && DontMove == 0 && jal == 0)
//                Registers[WriteRegister] <= WriteData;
//        else if (RegWrite == 1 && jal == 1)
//                Registers[31] = oldPC + 4;
        
//        // I repeat... FOR DEMOING ONLY DONT FREAK OUT PLZZ
//        s0 <= Registers[16];
//        s1 <= Registers[17];
//        s2 <= Registers[18];
//        s3 <= Registers[19];
//        s4 <= Registers[20];
                
//    end // end always
    
//    always @(negedge Clk) begin
//        // On negedge Clk, ReadData1 and ReadData2 contain the data held at 
//        // the respective ReadRegister1 & ReadRegister2 addresses
//        if (RegWrite == 1 && DontMove == 0 && jal == 0 && ReadRegister1 == WriteRegister)
//            ReadData1 <= WriteData;
//        else
//            ReadData1 <= Registers[ReadRegister1];
        
        
//        if (RegWrite == 1 && DontMove == 0 && jal == 0 && ReadRegister2 == WriteRegister)
//            ReadData2 <= WriteData;
//        else
//            ReadData2 <= Registers[ReadRegister2];
        

        
//    end // end always
          
endmodule
