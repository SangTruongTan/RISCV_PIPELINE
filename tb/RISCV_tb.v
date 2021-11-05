`timescale 1ns/1ps
module RISCV_tb;

/******************* Wire decleration *******************/
    parameter WIDTH_INST_LENGTH = 32;
    parameter WIDTH_DATA_LENGTH = 32;
    parameter WIDTH_DATAOUT_LENGTH  = 6;
    parameter WIDTH_ROMDATA_LENGTH = 20;
    
    wire [WIDTH_DATA_LENGTH - 1:0] alu;
    wire [WIDTH_DATA_LENGTH - 1:0] pc4;
    wire [WIDTH_DATA_LENGTH - 1:0] mux2pc;
    wire [WIDTH_DATA_LENGTH - 1:0] pc;
    wire [WIDTH_INST_LENGTH - 1:0] inst;

    wire [WIDTH_DATA_LENGTH - 1:0] wb;
    wire [WIDTH_DATA_LENGTH - 1:0] dataA;
    wire [WIDTH_DATA_LENGTH - 1:0] dataB;

    wire [WIDTH_DATA_LENGTH - 1:0] mux2aluA;
    wire [WIDTH_DATA_LENGTH - 1:0] mux2aluB;

    wire [WIDTH_DATA_LENGTH - 1:0] dataR;
    wire [31:0] dataROut;

    wire pcSel;
    wire brEq;
    wire brLT;
    wire [WIDTH_DATAOUT_LENGTH - 1:0] dec2rom;

    wire [2:0] immSel;
    wire regWEn;
    wire [WIDTH_DATA_LENGTH - 1:0] imm;
    wire brUn;
    wire bSel;
    wire aSel;
    wire [3:0] aluSel;
    wire memRW;
    wire [1:0] dataIn;
    wire [2:0] dataOutAddj;
    wire [1:0] wbSel;
    wire [WIDTH_ROMDATA_LENGTH - 1:0] romData;
    wire [1:0] dataInR;
    wire memRWR;
    reg clk;
/******************* Functional Block *******************/
    //Mux 2 to 1 before PC gate
    Mux2 mux2_1 (.sel_port(pcSel),
                 .port_in_0(pc4),
                 .port_in_1(alu),
                 .port_out(mux2pc));
    //Pc block
    PC pc_1 (.port_in(mux2pc),
             .clock(clk),
             .port_out(pc));
    //Adder 4 block
    add4 add4_1 (.port_in(pc),
                 .port_out(pc4));
    //IMEM block
    IMEM imem_1 (.inst(inst),
                 .PC(pc));
    //Bank REG block
    REGBank regb_1 (.AddrA(inst[19:15]),
                    .AddrB(inst[24:20]),
                    .AddrD(inst[11:7]),
                    .DataD(wb),
                    .clk(clk),
                    .RegWEn(regWEn),
                    .DataA(dataA),
                    .DataB(dataB));
    //Immediate Generation Block
    ImmGen immgen_1 (.Inst(inst),
                     .ImmSel(immSel),
                     .DataOut(imm));
    //ROM Decoder Block
    ROMDecoder romdec_1 (.Inst(inst),
                         .BrEq(brEq),
                         .BrLT(brLT),
                         .DataOut(dec2rom));
    //Branch Comparation Block
    branch_comp brcomp_1 (.A(dataA),
                          .B(dataB),
                          .BrUn(brUn),
                          .BrEq(brEq),
                          .BrLT(brLT));
    //Mux 2 to 1 at A gate of ALU
    Mux2 mux2_2 (.sel_port(aSel),
                 .port_in_0(dataA),
                 .port_in_1(pc),
                 .port_out(mux2aluA));
    //Mux 2 to 1 at B gate of ALU
    Mux2 mux2_3 (.sel_port(bSel),
                 .port_in_0(dataB),
                 .port_in_1(imm),
                 .port_out(mux2aluB));
    //ALU Block
    ALU alu_1 (.DataA(mux2aluA),
               .DataB(mux2aluB),
               .ALUSel(aluSel),
               .DataOut(alu));
    //DMEM Block
    DMEM dmem_1 (.Addr(alu),
                 .DataW(dataB),
                 .MemRW(memRW),
                 .LenSel(dataIn),
                 .clk(clk),
                 .DataR(dataR));
    //Data Mem Output Addjustment Block
    DMEM_ADDJ dataadj_1 (.DataIn(dataR),
                         .FormatSel(dataOutAddj),
                         .DataOut(dataROut));
    //Mux 4 to 1 Block after dmem
    Mux4 mux4_1 (.sel_port(wbSel),
                 .port_in_0(dataROut),
                 .port_in_1(alu),
                 .port_in_2(pc4),
                 .port_in_3(32'b0),
                 .port_out(wb));
    //ROM Control Block
    ROMControl romctrl_1 (.Addr(dec2rom),
                          .Data(romData));
/******************* Assign and Always *******************/
    assign {pcSel, immSel, regWEn, brUn, bSel, aSel,
            aluSel, memRWR, dataInR, dataOutAddj, wbSel} = romData;
    assign  memRW = memRWR;
    assign  dataIn = dataInR;
    initial begin
        #0 clk = 1'b0;

    end
    always begin
        #500 clk = !clk;
    end
endmodule
