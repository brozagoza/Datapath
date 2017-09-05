`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory  1
// Module - InstructionMemory.v
// Description - 32-Bit wide instruction memory.
//
// INPUT:-
// Address: 32-Bit address input port.
//
// OUTPUT:-
// Instruction: 32-Bit output port.
//
// FUNCTIONALITY:-
// Similar to the DataMemory, this module should also be byte-addressed
// (i.e., ignore bits 0 and 1 of 'Address'). All of the instructions will be 
// hard-coded into the instruction memory, so there is no need to write to the 
// InstructionMemory.  The contents of the InstructionMemory is the machine 
// language program to be run on your MIPS processor.
//
//
//we will store the machine code for a code written in C later. for now initialize 
//each entry to be its index * 4 (memory[i] = i * 4;)
//all you need to do is give an address as input and read the contents of the 
//address on your output port. 
// 
//Using a 32bit address you will index into the memory, output the contents of that specific 
//address. for data memory we are using 1K word of storage space. for the instruction memory 
//you may assume smaller size for practical purpose. you can use 128 words as the size and 
//hardcode the values.  in this case you need 7 bits to index into the memory. 
//
//be careful with the least two significant bits of the 32bit address. those help us index 
//into one of the 4 bytes in a word. therefore you will need to use bit [8-2] of the input address. 
//

////////////////////////////////////////////////////////////////////////////////

module InstructionMemory(Address, Instruction); 

    input [31:0] Address;             // Input Address 
    reg [31:0] memory[0:127];
    integer i;
    
    initial begin
    
        for(i=0; i<127; i= i+1)begin
            memory[i] = 0;  // nop
        end

        //$readmemh("Instruction_memory.txt", memory); 
        // j j
        // sw lw

        memory[0] = 32'h34020000;	//	vbsme:			ori	$v0, $zero, 0
        memory[1] = 32'h34030000;    //                ori    $v1, $zero, 0
        memory[2] = 32'h001fb020;    //                add    $s6, $0, $ra
        memory[3] = 32'h8c900000;    //                lw    $s0, 0($a0)
        memory[4] = 32'h8c910004;    //                lw  $s1, 4($a0)
        memory[5] = 32'h8c920008;    //                lw    $s2, 8($a0)
        memory[6] = 32'h8c93000c;    //                lw    $s3, 12($a0)
        memory[7] = 32'h20087530;    //                addi    $t0, $0, 30000
        memory[8] = 32'h02128022;    //                sub    $s0, $s0, $s2
        memory[9] = 32'h02338822;    //                sub    $s1, $s1, $s3
        memory[10] = 32'h0200a020;    //                add    $s4, $s0, $0
        memory[11] = 32'h0220a820;    //                add    $s5, $s1, $0
        memory[12] = 32'h00001020;    //                add    $v0, $0, $0
        memory[13] = 32'h00001820;    //                add    $v1, $0, $0
        memory[14] = 32'h00004820;    //                add    $t1, $0, $0
        memory[15] = 32'h00005020;    //                add    $t2, $0, $0
        memory[16] = 32'h00055820;    //                add    $t3, $0, $a1
        memory[17] = 32'h00066020;    //                add    $t4, $0, $a2
        memory[18] = 32'h0c000056;    //                jal    calculate_t3_addr         // ** UPDATED 
        memory[19] = 32'h0134c82a;    //                slt    $t9, $t1, $s4
        memory[20] = 32'h0155c02a;    //                slt    $t8, $t2, $s5
        memory[21] = 32'h0319c020;    //                add    $t8, $t8, $t9
        memory[22] = 32'h1300004c;    //                beq    $t8, $0, doneski        // ***
        memory[23] = 32'h214a0001;    //    move_right:        addi    $t2, $t2, 1
        memory[24] = 32'h0c000056;    //                jal    calculate_t3_addr         // ** UPDATED
        memory[25] = 32'h0134c82a;    //                slt    $t9, $t1, $s4
        memory[26] = 32'h0155c02a;    //                slt    $t8, $t2, $s5
        memory[27] = 32'h0319c020;    //                add    $t8, $t8, $t9
        memory[28] = 32'h13000046;    //                beq    $t8, $0, doneski        // **
        memory[29] = 32'h1134000f;    //                beq    $t1, $s4, move_upRight    // **
        memory[30] = 32'h0800001f;    //                j    move_downLeft             // ******* UPDATED
        memory[31] = 32'h21290001;    //    move_downLeft:        addi    $t1, $t1, 1
        memory[32] = 32'h214affff;    //                addi    $t2, $t2, -1
        memory[33] = 32'h0c000056;    //                jal    calculate_t3_addr         // ** UPDATED
        memory[34] = 32'h1134fff6;    //                beq    $t1, $s4, move_upRight     // **
        memory[35] = 32'h11400001;    //                beq    $t2, $0, move_down         // **
        memory[36] = 32'h0800001f;    //                j    move_downLeft            // ** UPDATED        
        memory[37] = 32'h21290001;    //    move_down:        addi    $t1, $t1, 1
        memory[38] = 32'h0c000056;    //                jal    calculate_t3_addr         // ** UPDATED
        memory[39] = 32'h0134c82a;    //                slt    $t9, $t1, $s4
        memory[40] = 32'h0155c02a;    //                slt    $t8, $t2, $s5
        memory[41] = 32'h0319c020;    //                add    $t8, $t8, $t9
        memory[42] = 32'h13000038;    //                beq    $t8, $0, doneski        // **
        memory[43] = 32'h1155fff3;    //                beq    $t2, $s5, move_downLeft // ** &&&&& UPDATED
        memory[44] = 32'h0800002d;    //                j    move_upRight             // ****** UPDATED
        memory[45] = 32'h214a0001;    //    move_upRight:        addi    $t2, $t2, 1
        memory[46] = 32'h2129ffff;    //                addi    $t1, $t1, -1
        memory[47] = 32'h0c000056;    //                jal    calculate_t3_addr         // ** UPDATED
        memory[48] = 32'h1155fff4;    //                beq    $t2, $s5, move_down     // ** &&&&&& UPDATED
        memory[49] = 32'h1120ffe5;    //                beq    $t1, $0, move_right     // ** &&&&&& UPDATED
        memory[50] = 32'h0800002d;    //                j    move_upRight             // ** UPDATED
        memory[51] = 32'h8d780000;    //    check_window:        lw    $t8, 0($t3)
        memory[52] = 32'h8d990000;    //                lw    $t9, 0($t4)
        memory[53] = 32'h11b20010;    //                beq    $t5, $s2, window_executed // **
        memory[54] = 32'h11d30009;    //                beq    $t6, $s3, column_done // **
        memory[55] = 32'h0319c022;    //                sub    $t8, $t8, $t9
        memory[56] = 32'h0018cfc3;    //                sra    $t9, $t8, 31
        memory[57] = 32'h0319c026;    //                xor    $t8, $t8, $t9
        memory[58] = 32'h0319c022;    //                sub    $t8, $t8, $t9
        memory[59] = 32'h01f87820;    //                add    $t7, $t7, $t8
        memory[60] = 32'h21ce0001;    //                addi    $t6, $t6, 1
        memory[61] = 32'h216b0004;    //                addi    $t3, $t3, 4
        memory[62] = 32'h218c0004;    //                addi    $t4, $t4, 4
        memory[63] = 32'h08000033;    //                j    check_window             // ** UPDATED
        memory[64] = 32'h00007020;    //    column_done:        add    $t6, $0, $0
        memory[65] = 32'h21ad0001;    //                addi    $t5, $t5, 1
        memory[66] = 32'h00118880;    //                sll    $s1, $s1, 2
        memory[67] = 32'h01715820;    //                add    $t3, $t3, $s1
        memory[68] = 32'h00118882;    //                srl    $s1, $s1, 2
        memory[69] = 32'h08000033;    //                j    check_window             // ** UPDATED
        memory[70] = 32'h0013c820;    //    window_executed:    add    $t9, $0, $s3
        memory[71] = 32'h0019c880;    //                sll    $t9, $t9, 2
        memory[72] = 32'h01795820;    //                add    $t3, $t3, $t9
        memory[73] = 32'h216b0004;    //                addi    $t3, $t3, 4
        memory[74] = 32'h00066020;    //                add    $t4, $0, $a2
        memory[75] = 32'h00006820;    //                add    $t5, $0, $0
        memory[76] = 32'h00007020;    //                add    $t6, $0, $0
        memory[77] = 32'h010fc82a;    //                slt    $t9, $t0, $t7
        memory[78] = 32'h13200002;    //                beq    $t9, $0, new_minSad     // **
        memory[79] = 32'h00007820;    //                add    $t7, $0, $0
        memory[80] = 32'h03e00008;    //                jr    $ra
        memory[81] = 32'h000f4020;    //    new_minSad:        add    $t0, $0, $t7
        memory[82] = 32'h00091020;    //                add    $v0, $0, $t1
        memory[83] = 32'h000a1820;    //                add    $v1, $0, $t2
        memory[84] = 32'h00007820;    //                add    $t7, $0, $0
        memory[85] = 32'h03e00008;    //                jr    $ra
        memory[86] = 32'h0233c820;    //    calculate_t3_addr:    add    $t9, $s1, $s3
        memory[87] = 32'h0019c880;    //                sll    $t9, $t9, 2
        memory[88] = 32'h0120c020;    //                add    $t8, $t1, $0
        memory[89] = 32'h00055820;    //                add    $t3, $zero, $a1
        memory[90] = 32'h0800005b;    //                j    find_t3                 // ** UPDATED
        memory[91] = 32'h13000003;    //    find_t3:        beq    $t8, $0, inc_col_t3     // **
        memory[92] = 32'h01795820;    //                add    $t3, $t3, $t9
        memory[93] = 32'h2318ffff;    //                addi    $t8, $t8, -1
        memory[94] = 32'h0800005b;    //                j    find_t3                 // ** UPDATED
        memory[95] = 32'h0140c020;    //    inc_col_t3:        add    $t8, $t2, $zero
        memory[96] = 32'h0018c080;    //                sll    $t8, $t8, 2
        memory[97] = 32'h01785820;    //                add    $t3, $t3, $t8
        memory[98] = 32'h08000033;    //                j    check_window                 // ** UPDATED
        memory[99] = 32'h8000063;    //    doneski:        j doneski


                
    end // end initial
    
    output reg [31:0] Instruction; // Instruction at memory location Address
    
    always@(Address) Instruction = memory[Address/4];
    

endmodule




        // as of 1:43pm 11/14/16 the following instructions work makeing use of forwarding and branching 
//        memory[0] = 32'b00100000000100010000000000001010; // addi s1 zero 10
//        memory[1] = 32'b00100010001100010000000000000101; // addi s1 s1 5
//        memory[2] = 32'b00000000000100011001000000100010; // sub s2 zero s1
//        memory[3] = 32'b00001000000000000000000000000001; // j 0x2
//        memory[0] = 32'h20100001;    //    main:    addi    $s0, $zero, 1
//memory[1] = 32'h20110001;    //        addi    $s1, $zero, 1
//memory[2] = 32'h02118024;    //        and    $s0, $s0, $s1
//memory[3] = 32'h02008024;    //        and    $s0, $s0, $zero
//memory[4] = 32'h02308022;    //        sub    $s0, $s1, $s0
//memory[5] = 32'h02008027;    //        nor    $s0, $s0, $zero
//memory[6] = 32'h02008027;    //        nor    $s0, $s0, $zero
//memory[7] = 32'h00008025;    //        or    $s0, $zero, $zero
//memory[8] = 32'h02208025;    //        or    $s0, $s1, $zero
//memory[9] = 32'h00108080;    //        sll    $s0, $s0, 2
//memory[10] = 32'h02308004;    //        sllv    $s0, $s0, $s1
//memory[11] = 32'h0200802a;    //        slt    $s0, $s0, $zero
//memory[12] = 32'h0211802a;    //        slt    $s0, $s0, $s1
//memory[13] = 32'h00118043;    //        sra    $s0, $s1, 1
//memory[14] = 32'h00118007;    //        srav    $s0, $s1, $zero
//memory[15] = 32'h00118042;    //        srl    $s0, $s1, 1
//memory[16] = 32'h001180c0;    //        sll    $s0, $s1, 3
//memory[17] = 32'h001080c2;    //        srl    $s0, $s0, 3
//memory[18] = 32'h02308004;    //        sllv    $s0, $s0, $s1
//memory[19] = 32'h02308006;    //        srlv    $s0, $s0, $s1
//memory[20] = 32'h02118026;    //        xor    $s0, $s0, $s1
//memory[21] = 32'h02118026;    //        xor    $s0, $s0, $s1
//memory[22] = 32'h20120004;    //        addi    $s2, $zero, 4
//memory[23] = 32'h72128002;    //        mul    $s0, $s0, $s2
//memory[24] = 32'h22100004;    //        addi    $s0, $s0, 4
//memory[25] = 32'h32100000;    //        andi    $s0, $s0, 0
//memory[26] = 32'h36100001;    //        ori    $s0, $s0, 1
//memory[27] = 32'h2a100000;    //        slti    $s0, $s0, 0
//memory[28] = 32'h2a100001;    //        slti    $s0, $s0, 1
//memory[29] = 32'h3a100001;    //        xori    $s0, $s0, 1
//memory[30] = 32'h3a100001;    //        xori    $s0, $s0, 1
//memory[31] = 32'h2010fffe;    //        addi    $s0, $zero, -2
//memory[32] = 32'h20110002;    //        addi    $s1, $zero, 2
//memory[33] = 32'h0230902b;    //        sltu    $s2, $s1, $s0
//memory[34] = 32'h2e30fffe;    //        sltiu    $s0, $s1, -2
//memory[35] = 32'h0220800a;    //        movz    $s0, $s1, $zero
//memory[36] = 32'h0011800b;    //        movn    $s0, $zero, $s1
//memory[37] = 32'h02328020;    //        add    $s0, $s1, $s2
//memory[38] = 32'h2010fffe;    //        addi    $s0, $zero, -2
//memory[39] = 32'h02308821;    //        addu    $s1, $s1, $s0
//memory[40] = 32'h2411ffff;    //        addiu    $s1, $zero, -1
//memory[41] = 32'h20120020;    //        addi    $s2, $zero, 32
//memory[42] = 32'h02320018;    //        mult    $s1, $s2
//memory[43] = 32'h0000a010;    //        mfhi    $s4
//memory[44] = 32'h0000a812;    //        mflo    $s5
//memory[45] = 32'h02320019;    //        multu    $s1, $s2
//memory[46] = 32'h0000a010;    //        mfhi    $s4
//memory[47] = 32'h0000a812;    //        mflo    $s5
//memory[48] = 32'h72320000;    //        madd    $s1, $s2
//memory[49] = 32'h0000a010;    //        mfhi    $s4
//memory[50] = 32'h0000a812;    //        mflo    $s5
//memory[51] = 32'h02400011;    //        mthi    $s2
//memory[52] = 32'h02200013;    //        mtlo    $s1
//memory[53] = 32'h0000a010;    //        mfhi    $s4
//memory[54] = 32'h0000a812;    //        mflo    $s5
//memory[55] = 32'h3231ffff;    //        andi    $s1, , $s1, 65535
//memory[56] = 32'h72920004;    //        msub    $s4, , $s2
//memory[57] = 32'h0000a010;    //        mfhi    $s4
//memory[58] = 32'h0000a812;    //        mflo    $s5
//memory[59] = 32'h20120001;    //        addi    $s2, $zero, 1
//memory[60] = 32'h00328fc2;    //        rotr    $s1, $s2, 31
//memory[61] = 32'h2014001f;    //        addi    $s4, $zero, 31
//memory[62] = 32'h02918846;    //        rotrv    $s1, $s1, $s4
//memory[63] = 32'h00000000;    //        nop
//memory[64] = 32'h7c11a420;    //        seb    $s4, $s1
//memory[65] = 32'h7c11a620;    //        seh    $s4, , $s1
//    memory[0] = 32'b10001100000100000000000000000000; // lw s0 0(zero)
//    memory[1] = 32'b00000010000100001000000000100000; // add s0 s0 s0
//    memory[2] = 32'b10101100000100000000000000000000; // sw s0 zero
//    memory[3] = 32'b10001100000100010000000000000000; // lw s1 zero


//// test case given
//memory[0] = 32'h34120000;    //    main:        ori    $s2, $zero, 0
//memory[1] = 32'h8e520000;    //            lw    $s2, 0($s2)
//memory[2] = 32'h34130000;    //            ori    $s3, $zero, 0
//memory[3] = 32'h8e730004;    //            lw    $s3, 4($s3)
//memory[4] = 32'h02538820;    //            add    $s1, $s2, $s3
//memory[5] = 32'h0233a022;    //            sub    $s4, $s1, $s3
//memory[6] = 32'h02348822;    //            sub    $s1, $s1, $s4
//memory[7] = 32'h7233a002;    //            mul    $s4, $s1, $s3
//memory[8] = 32'h0233a022;    //            sub    $s4, $s1, $s3
//memory[9] = 32'h00000000;    //            nop
//memory[10] = 32'h7234b002;    //            mul    $s6, $s1, $s4
//memory[11] = 32'h02968822;    //            sub    $s1, $s4, $s6
//memory[12] = 32'h02568820;    //            add    $s1, $s2, $s6
//memory[13] = 32'h00000000;    //            nop
//memory[14] = 32'h00118a80;    //            sll    $s1, $s1, 10
//memory[15] = 32'h22350000;    //            addi    $s5, $s1, 0
//memory[16] = 32'h22b70000;    //            addi    $s7, $s5, 0
//memory[17] = 32'h34120018;    //            ori    $s2, $zero, 24
//memory[18] = 32'h8e510000;    //            lw    $s1, 0($s2)
//memory[19] = 32'h0235a022;    //            sub    $s4, $s1, $s5
//memory[20] = 32'h0237b024;    //            and    $s6, $s1, $s7
//memory[21] = 32'h0236b825;    //            or    $s7, $s1, $s6
//memory[22] = 32'h02339022;    //            sub    $s2, $s1, $s3
//memory[23] = 32'h02554024;    //            and    $t0, $s2, $s5
//memory[24] = 32'h02d24825;    //            or    $t1, $s6, $s2
//memory[25] = 32'h02525020;    //            add    $t2, $s2, $s2
//memory[26] = 32'h00000000;    //            nop
//memory[27] = 32'hae290004;    //            sw    $t1, 4($s1)
//memory[28] = 32'h8e2a0004;    //            lw    $t2, 4($s1)
//memory[29] = 32'h02339022;    //            sub    $s2, $s1, $s3
//memory[30] = 32'h02555825;    //            or    $t3, $s2, $s5
//memory[31] = 32'h02526020;    //            add    $t4, $s2, $s2
//memory[32] = 32'h02525025;    //            or    $t2, $s2, $s2
//memory[33] = 32'h02eaa020;    //            add    $s4, $s7, $t2
//memory[34] = 32'h34090000;    //            ori    $t1, $zero, 0
//memory[35] = 32'h8d280000;    //            lw    $t0, 0($t1)
//memory[36] = 32'h8d2a0004;    //            lw    $t2, 4($t1)
//memory[37] = 32'had2a0000;    //            sw    $t2, 0($t1)
//memory[38] = 32'had280004;    //            sw    $t0, 4($t1)
//memory[39] = 32'h8d280000;    //            lw    $t0, 0($t1)
//memory[40] = 32'h8d2a0004;    //            lw    $t2, 4($t1)
//memory[41] = 32'h34040018;    //            ori    $a0, $zero, 24
//memory[42] = 32'h0800002d;    //            j    start
//memory[43] = 32'h2004ffff;    //            addi    $a0, $zero, -1
//memory[44] = 32'h2004ffff;    //            addi    $a0, $zero, -1
//memory[45] = 32'h8c900004;    //    start:        lw    $s0, 4($a0)
//memory[46] = 32'hac900000;    //            sw    $s0, 0($a0)
//memory[47] = 32'h06010003;    //    branch1:    bgez    $s0, branch2
//memory[48] = 32'h22100001;    //            addi    $s0, $s0, 1
//memory[49] = 32'h0601ffff;    //            bgez    $s0, branch1
//memory[50] = 32'h0800003e;    //            j    error
//memory[51] = 32'h2010ffff;    //    branch2:    addi    $s0, $zero, -1
//memory[52] = 32'h06000004;    //            bltz    $s0, branch3
//memory[53] = 32'h20100001;    //            addi    $s0, $zero, 1
//memory[54] = 32'h0010082a;    //            slt    $at, $zero, $s0
//memory[55] = 32'h1420fffd;    //            bne    $at, $zero, branch2
//memory[56] = 32'h0800003e;    //            j    error
//memory[57] = 32'h06000003;    //    branch3:    bltz    $s0, done
//memory[58] = 32'h2010ffff;    //            addi    $s0, $zero, -1
//memory[59] = 32'h0600ffff;    //            bltz    $s0, branch3
//memory[60] = 32'h0800003e;    //            j    error
//memory[61] = 32'h0800003d;    //    done:        j    done
//memory[62] = 32'h0800003e;    //    error:        j    error