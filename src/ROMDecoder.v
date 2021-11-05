module ROMDecoder (
    Inst,
    BrEq,
    BrLT,
    DataOut
);
    /*************** Decleration ***************/
    parameter WIDTH_INST_LENGTH = 32;
    parameter WIDTH_DATAOUT_LENGTH  = 6;
    parameter WIDTH_CONTROL_LENGTH = 11;
    input [WIDTH_INST_LENGTH - 1:0] Inst;
    input BrEq;
    input BrLT;
    output reg [WIDTH_DATAOUT_LENGTH - 1:0] DataOut;

    reg [WIDTH_CONTROL_LENGTH - 1:0] Ctrl;

    /*************** Functional ***************/
    assign Ctrl = {Inst[30], Inst[14:12], Inst[6:2], BrEq, BrLT};

    /*************** Always Block ***************/
    always @(Ctrl) begin
        casex (Ctrl)
            //R type
            11'b0_000_01100_?_?: DataOut = 6'd0;    //ADD
            11'b1_000_01100_?_?: DataOut = 6'd1;    //SUB
            11'b0_001_01100_?_?: DataOut = 6'd2;    //SLL
            11'b0_010_01100_?_?: DataOut = 6'd3;    //SLT
            11'b0_011_01100_?_?: DataOut = 6'd4;    //SLTU
            11'b0_100_01100_?_?: DataOut = 6'd5;    //XOR
            11'b0_101_01100_?_?: DataOut = 6'd6;    //SRL 
            11'b1_101_01100_?_?: DataOut = 6'd7;    //SRA
            11'b0_110_01100_?_?: DataOut = 6'd8;    //OR
            11'b0_111_01100_?_?: DataOut = 6'd9;    //AND   

            //I type
            11'b?_000_00100_?_?: DataOut = 6'd10;   //ADDI
            11'b?_010_00100_?_?: DataOut = 6'd11;   //SLTI
            11'b?_011_00100_?_?: DataOut = 6'd12;   //SLTIU
            11'b?_100_00100_?_?: DataOut = 6'd13;   //XORI
            11'b?_110_00100_?_?: DataOut = 6'd14;   //ORI
            11'b?_111_00100_?_?: DataOut = 6'd15;   //ANDI
            11'b0_001_00100_?_?: DataOut = 6'd16;   //SLLI
            11'b0_101_00100_?_?: DataOut = 6'd17;   //SRLI
            11'b1_101_00100_?_?: DataOut = 6'd18;   //SRAI

            //I type, Load instruction
            11'b?_000_00000_?_?: DataOut = 6'd19;   //LB
            11'b?_001_00000_?_?: DataOut = 6'd20;   //LH
            11'b?_010_00000_?_?: DataOut = 6'd21;   //LW
            11'b?_100_00000_?_?: DataOut = 6'd22;   //LBU
            11'b?_101_00000_?_?: DataOut = 6'd23;   //LHU

            //S type, Strore Instruction
            11'b?_000_01000_?_?: DataOut = 6'd24;   //SB
            11'b?_001_01000_?_?: DataOut = 6'd25;   //SH
            11'b?_010_01000_?_?: DataOut = 6'd26;   //SW

            //B type, Conditional Branch
            11'b?_000_11000_1_?: DataOut = 6'd27;   //BEQ, pass condition
            11'b?_000_11000_0_?: DataOut = 6'd28;   //BEQ
            11'b?_001_11000_1_?: DataOut = 6'd29;   //BNE, not pass condition
            11'b?_001_11000_0_?: DataOut = 6'd30;   //BNE
            11'b?_100_11000_?_1: DataOut = 6'd31;   //BLT, pass condition
            11'b?_100_11000_?_0: DataOut = 6'd32;   //BLT
            11'b?_101_11000_?_1: DataOut = 6'd33;   //BGE, not pass condition
            11'b?_101_11000_?_0: DataOut = 6'd34;   //BGE
            11'b?_110_11000_?_1: DataOut = 6'd35;   //BLTU, pass condition
            11'b?_110_11000_?_0: DataOut = 6'd36;   //BLTU
            11'b?_111_11000_?_1: DataOut = 6'd37;   //BGEU, not pass condition
            11'b?_111_11000_?_0: DataOut = 6'd38;   //BGEU

            //U type
            11'b?_???_01101_?_?: DataOut = 6'd39;   //LUI
            11'b?_???_00101_?_?: DataOut = 6'd40;   //AUIPC

            //J type, unConditional Branch
            11'b?_???_11011_?_?: DataOut = 6'd41;   //JAL
            11'b?_000_11001_?_?: DataOut = 6'd42;   //JALR
            default: ;
        endcase
    end
endmodule
