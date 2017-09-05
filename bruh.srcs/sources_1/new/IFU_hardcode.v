`timescale 1ns / 1ps
/*====================================================================================================================================================
|                                           ECE 369 Labs 16-24
|   Authors:        Alejandro Zaragoza
|                   Dalton J Hirst
|
|   Number of
|   Pipelines :      Five stage Pipeline (IF/ID ID/EX EX/MEM/ MEM/WB)
|
|   Branch Decision  
|   Resolution
|   Stage :         MEM stage (4th stage)
|
|   Percent Effort: 50/50
|
=====================================================================================================================================================*/
module IFU_hardcode(Reset, Clk, PCResultOut, minimum_sad_Out, x_cord_Out, y_cord_Out);
    input Reset, Clk;
        
    wire Clk;
    wire Zero;
    wire [31:0] WriteData, WriteDataOut; // for the REGISTER
    wire [31:0] instr;
    wire RegDst, Jump, Shft, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, DontMove;
    wire [5:0] ALUOp;
    wire [4:0] WriteRegister, WriteRegister_post;
    wire [31:0] ReadData1, ReadData2;
    wire [31:0] ShftMuxOUT;
    wire [31:0] PCResult;
    wire [31:0] PCAddResult;
    wire [31:0] ALUResult;
    wire [31:0] SignExtendOut;
    wire [27:0] shftLft28;
    wire [31:0] JumpMuxOut;
    wire [31:0] branchMuxOut;
    wire [31:0] shftLftOut;
    wire[31:0] branchAddOut;
    wire [31:0] JumpMuxIn;
    wire jump_sel;
    wire jal;
    wire HiWrite, LoWrite, ALUOut;
    wire [31:0] ALUResultWire;
    
    output [31:0] PCResultOut;
    
    // For demoing purposes
    wire [31:0] minimum_sad, x_cord, y_cord, Hi, Lo;
    output [31:0] minimum_sad_Out, x_cord_Out, y_cord_Out;
    //
    
    /*=========STAGE ONE============*/
    wire [31:0] instr_IF_ID, PCResult_IF_ID, PCAddResult_IF_ID;
    /*==============================*/
    
    /*=========STAGE TWO============*/
    wire [31:0] instr_ID_EX, PCResult_ID_EX, PCAddResult_ID_EX;
    
    wire [5:0] ALUOp_ID_EX;
    wire RegDst_ID_EX, jump_ID_EX, Shft_ID_EX, Branch_ID_EX, MemRead_ID_EX, MemtoReg_ID_EX, MemWrite_ID_EX, ALUSrc_ID_EX, RegWrite_ID_EX, // 2
                jump_sel_ID_EX, jal_ID_EX; // 2
    
    wire [31:0] ReadData1_ID_EX, ReadData2_ID_EX;
    
    wire [31:0] SignExtendOut_ID_EX;
    /*==============================*/

    /*=========STAGE THREE============*/
    wire [31:0] instr_EX_MEM, PCResult_EX_MEM, PCAddResult_EX_MEM;
    wire Branch_EX_MEM, MemRead_EX_MEM, MemWrite_EX_MEM, MemtoReg_EX_MEM;
    wire [4:0] WriteRegister_EX_MEM;
    wire [31:0] ALUResult_EX_MEM, branchAddOut_EX_MEM, ReadData2_EX_MEM;
    wire Zero_EX_MEM, DontMove_EX_MEM;
    wire jump_EX_MEM, jal_EX_MEM, jump_sel_EX_MEM, RegWrite_EX_MEM;
    /*==============================*/
    
    /*=========STAGE FOUR============*/
    wire MemtoReg_MEM_WB, DontMove_MEM_WB, jal_MEM_WB, RegWrite_MEM_WB;
    wire [4:0] WriteRegister_MEM_WB;
    wire [31:0] ReadData_MEM_WB, ALUResult_MEM_WB, PCResult_MEM_WB;
    /*==============================*/
    
    /*=========FLUSHING AND FORWARDING AND HAZARD============*/
    wire IF_ID_flush, ID_EX_flush, EX_MEM_flush;   // flush flags

    wire WB_MemRead, Post_WB_MemRead, WB_MemWrite, Post_WB_MemWrite;
    wire [31:0] ReadData1_Forward_Out, ReadData2_Forward_Out, DM_Forward_Out; // forward
    
    wire [31:0] InstructionMemoryOut, PCAdderOut;
    /*=============================================*/
    

    
    /*=============== 1 INSTRUCTION FETCH STAGE ====================
    |   
    |
    |   Outputs: instr, PCAddResult
    |
    ================================================================*/
    
    Mux32Bit2To1 jumpMux(JumpMuxOut, branchMuxOut, JumpMuxIn,  jump_EX_MEM);
    
    ProgramCounter ProgramCounterInstance(.Address(JumpMuxOut), .PCResult(PCResult),  .Reset(Reset), .Clk(Clk));
    
    
    InstructionMemory im_call(.Address(PCResult), .Instruction(instr));    
    
    HazardDetectionUnit hazard(Clk, instr, instr_IF_ID, PCResult, InstructionMemoryOut, PCAdderOut);
    
    PCAdder PCAdderInstance(.PCResult(PCAdderOut), .PCAddResult(PCAddResult));
    /*================================================================*/
    
    

    ////// IF/ID Register Pipeline
    IF_ID IF_ID_call(
    // INPUTS
    Clk, IF_ID_flush, InstructionMemoryOut, PCResult, PCAddResult, 
    // OUTPUTS
    instr_IF_ID, PCResult_IF_ID, PCAddResult_IF_ID
    );
    ///////
    
    
    
    
    /*=============== 2 INSTRUCTION DECODE STAGE ==================
    |   
    |
    |   instr_IF_ID being used and needs to be carried through
    |   PCAddResult_IF_ID being carried in
    ================================================================*/
    Control cont_call(instr_IF_ID[31:26], instr_IF_ID[5:0], RegDst, Jump, Shft, Branch, MemRead, MemtoReg, 
        ALUOp, MemWrite, ALUSrc, RegWrite, jump_sel, jal);
    RegisterFile rf(InstructionMemoryOut[25:21], InstructionMemoryOut[20:16], WriteRegister_MEM_WB, WriteData, Clk, RegWrite_MEM_WB, ReadData1, 
            ReadData2, DontMove_MEM_WB, jal_MEM_WB, PCResult_IF_ID, PCResult_MEM_WB,
            //// THE FOLLOWING WAS ADDED FOR DEMOING PURPOSES DAWGGGGG
             minimum_sad, x_cord, y_cord);
    SignExtension seo_call(instr_IF_ID[15:0], SignExtendOut);
    /*================================================================*/
    
    
    ////// ID/EX Register Pipeline
    ID_EX ID_EX_call(Clk, ID_EX_flush,
    // INPUTS
    instr_IF_ID, PCResult_IF_ID, PCAddResult_IF_ID, // 1
    RegDst, Jump, Shft, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, jump_sel, jal, RegWrite, // 2
    ReadData1, ReadData2, // 3
    SignExtendOut, // 4
    // OUTPUTS
    instr_ID_EX, PCResult_ID_EX, PCAddResult_ID_EX, // 1
    RegDst_ID_EX, jump_ID_EX, Shft_ID_EX, Branch_ID_EX, MemRead_ID_EX, MemtoReg_ID_EX, ALUOp_ID_EX, MemWrite_ID_EX, ALUSrc_ID_EX, // 2
    jump_sel_ID_EX, jal_ID_EX, RegWrite_ID_EX, // 2
    ReadData1_ID_EX, ReadData2_ID_EX, // 3
    SignExtendOut_ID_EX // 4
    );
    ////////
    
    /*=============== 3 EXECUTION STAGE ==================
    |   Dropped Here: SignExtendOut_ID_EX, ALUSrc_ID_EX,
    |            ReadData1_ID_EX, Shft_ID_EX, ALUOp_ID_EX, RegDst_ID_EX
    |   
    |   Carried Through: PCResult, PCAddResult
    |
    ================================================================*/
    Mux5Bit2To1 RegDstMux(WriteRegister, instr_ID_EX[20:16], instr_ID_EX[15:11], RegDst_ID_EX); // RegDst
    
    wire [31:0] ALUinput2;
    Mux32Bit2To1 ALUSrcMux(ALUinput2, ReadData2_Forward_Out, SignExtendOut_ID_EX, ALUSrc_ID_EX);
    
    Mux32Bit2To1 ShftMux(ShftMuxOUT, ReadData1_Forward_Out, {27'b0, instr_ID_EX[10:6]}, Shft_ID_EX); // shift mux
    
    wire [5:0] ALUControlOut;
    ALUControl alucont(instr_ID_EX[5:0], instr_ID_EX[20:16], ALUOp_ID_EX, ALUControlOut);
    
    
    ALU64Bit alu(Clk, ALUControlOut, ShftMuxOUT, ALUinput2, instr_ID_EX[6], instr_ID_EX[21], 
    ALUResultWire, Zero, DontMove, Hi, Lo, HiWrite, LoWrite, ALUOut);
    
    HiLoReg Hi_Lo(Clk, HiWrite, LoWrite, ALUOut, ALUControlOut, ALUResultWire, Hi, Lo, ALUResult);

    ShiftLeft2 shftLeft(SignExtendOut_ID_EX, shftLftOut);
    
    Adder branchAdd(PCAddResult_ID_EX, shftLftOut, branchAddOut);
    
    //////////////// FORWARDING UNIT ///////////////////
    ForwardUnit forward_unit(Clk,
    // flags
    instr_ID_EX[25:21], instr_ID_EX[20:16], WriteRegister_EX_MEM, WriteRegister_MEM_WB, WriteRegister_post,
    WB_MemRead, Post_WB_MemRead,
    MemWrite_EX_MEM, WB_MemWrite,
    // values
    ReadData1_ID_EX, ReadData2_ID_EX, WriteData, ALUResult_EX_MEM, WriteDataOut,
    // outputs
    ReadData1_Forward_Out, ReadData2_Forward_Out);
    /*================================================================*/
    
    // EX/MEM Register Pipeline
    // jump, jal, jump_sel
    // controls: Branch, MemRead, MemWrite, MemtoReg
    // WriteRegister, ALUResult, Zero, DontMove, branchAddOut
    EX_MEM EX_MEM_call(Clk, EX_MEM_flush,
    // INPUTS
    instr_ID_EX, PCResult_ID_EX, PCAddResult_ID_EX, // 1
    ReadData2_ID_EX, Branch_ID_EX, MemRead_ID_EX, MemWrite_ID_EX, MemtoReg_ID_EX, RegWrite_ID_EX, // 2 
    WriteRegister, // ALU 3
    ALUResult, Zero, DontMove, branchAddOut, // ALU 3
    jump_ID_EX, jal_ID_EX, jump_sel_ID_EX, // jump muxes 4
    // OUTPUTS
    instr_EX_MEM, PCResult_EX_MEM, PCAddResult_EX_MEM, // 1
    ReadData2_EX_MEM, Branch_EX_MEM, MemRead_EX_MEM, MemWrite_EX_MEM, MemtoReg_EX_MEM, RegWrite_EX_MEM, // 2 
    WriteRegister_EX_MEM, // ALU 3
    ALUResult_EX_MEM, Zero_EX_MEM, DontMove_EX_MEM, branchAddOut_EX_MEM, // ALU 3
    jump_EX_MEM, jal_EX_MEM, jump_sel_EX_MEM // jump muxes 4
    );
    ///////
    
    
    /*=============== 4 DATA MEMORY STAGE ==================
    |   Dropped: Branch_EX_MEM, Zero_EX_MEM, ReadData2_EX_MEM, MemRead_EX_MEM, MemWrite_EX_MEM,
    |            ALUResult_EX_MEM, branchAddOut_EX_MEM, jump_EX_MEM, jump_sel_EX_MEM,
    |            PCAddResult_EX_MEM        
    |
    |   Carried Through: MemtoReg_EX_MEM
    |
    ================================================================*/
    DM_ForwardUnit DM_Forward(
    instr_EX_MEM[20:16], WriteRegister_MEM_WB, WriteRegister_post,
    ReadData2_EX_MEM, WriteData, WriteDataOut,
    DM_Forward_Out
        );
    
    wire AndGateOut;
    AndGate andBranch(Branch_EX_MEM, Zero_EX_MEM, AndGateOut); // BRANCHING WORKS BUT IS USING WRONG ZERO INPUT
    ShiftLeftTwo26To28 shftLeft26(instr_EX_MEM[25:0], shftLft28); // USED FOR JUMPS
    
    Mux32Bit2To1 branchMux(branchMuxOut, PCAddResult, branchAddOut_EX_MEM, AndGateOut); // here temp
    
    Mux32Bit2To1 j_jr_Mux(JumpMuxIn, {PCAddResult_EX_MEM[31:28], shftLft28}, ALUResult_EX_MEM, jump_sel_EX_MEM); // here temp
    
    FlushUnit flush(AndGateOut, jump_EX_MEM, IF_ID_flush, ID_EX_flush, EX_MEM_flush); // flush unit
    
    wire [31:0] ReadData;
    DataMemory dm(ALUResult_EX_MEM, DM_Forward_Out, Clk, MemWrite_EX_MEM, MemRead_EX_MEM, instr_EX_MEM[31:26], ReadData);
    
    
    /// MEM_WB Register Pipeline
    MEM_WB MEM_WB_call(Clk,
    // INPUTS
    MemtoReg_EX_MEM,
    ReadData,
    ALUResult_EX_MEM, DontMove_EX_MEM, jal_EX_MEM, WriteRegister_EX_MEM, RegWrite_EX_MEM,
    MemRead_EX_MEM, MemWrite_EX_MEM, PCResult_EX_MEM,
    // OUTPUTS
    MemtoReg_MEM_WB,
    ReadData_MEM_WB,
    ALUResult_MEM_WB, DontMove_MEM_WB, jal_MEM_WB, WriteRegister_MEM_WB, RegWrite_MEM_WB,
    WB_MemRead, WB_MemWrite, PCResult_MEM_WB
        );
    ///
    
    
    /*=============== 5 WRITE BACK STAGE ==================
    |   
    |
    |
    |
    ================================================================*/
    wire [31:0] MemtoRegOUT;
    Mux32Bit2To1 MemtoRegMUX(WriteData, ALUResult_MEM_WB, ReadData_MEM_WB, MemtoReg_MEM_WB);
    /*================================================================*/
    
    PostWB post(Clk, WriteData, WB_MemRead, WB_MemWrite, WriteDataOut, Post_WB_MemRead, Post_WB_MemWrite, WriteRegister_MEM_WB, WriteRegister_post);
    
    
    assign PCResultOut = PCResult;
    assign minimum_sad_Out = minimum_sad;
    assign x_cord_Out = x_cord;
    assign y_cord_Out = y_cord;
    

    
    
    
    
endmodule
