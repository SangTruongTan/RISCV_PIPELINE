`timescale 1ns/1ps
module RISCV_PIPELINE_tb;

/******************* Wire decleration *******************/
    parameter WIDTH_INST_LENGTH = 32;
    parameter WIDTH_DATA_LENGTH = 32;
    parameter WIDTH_DATAOUT_LENGTH  = 6;
    parameter WIDTH_ROMDATA_LENGTH = 20;

    reg clk;
    wire [31:0] PC4_NEW;
    wire [31:0] PC_ALU;             //
    wire [31:0] PC4_OLD;
    wire [2:0] PC_SEL;
    wire [31:0] PC_MUX;
    wire [31:0] PC_FE;
    wire [31:0] Inst_FE;
    //DE
    wire [31:0] PC_DE;
    wire [31:0] Inst_DE;
    wire [31:0] DataA_DE;
    wire [31:0] DataB_DE;
    wire [19:0] ROM_DATA_DE;
    wire [5:0] dec2rom;
    //EX
    wire [31:0] PC_EX;
    wire [31:0] DataA_EX;
    wire [31:0] DataB_EX;
    wire [31:0] Inst_EX;
    wire [19:0] ROM_DATA_EX;
    wire [31:0] DataA_Mux_EX;
    wire [31:0] DataB_Mux_EX;
    wire [31:0] ALU_A;
    wire [31:0] ALU_B;
    wire [31:0] ALU_OUT_EX;
    wire [31:0] IMM;
    wire [2:0] immSel;
    wire brEq;
    wire brLT;
    wire brUn;
    wire [3:0] aluSel;
    wire aSel;
    wire bSel;
    wire [31:0] PC_Predicted_EX;
    wire Br_PredictedBit_EX;
    //MEM
    wire [31:0] PC_MEM;
    wire [31:0] PC4_MEM;
    wire [31:0] ALU_OUT_MEM;
    wire [31:0] DataB_Mux_MEM;
    wire [31:0] Inst_MEM;
    wire [31:0] ROM_DATA_MEM;
    wire [31:0] DMEM;
    wire [31:0] Data_WB_MEM;
    wire memRW;
    wire [1:0] dataIn;
    wire [2:0] dataOutAddj;
    wire [31:0] dataR;
    wire [31:0] dataROut;
    wire [1:0] wbSel;
    //WB
    wire [31:0] Inst_WB;
    wire [19:0] ROM_DATA_WB;
    wire [31:0] DATA_WB_WB;

    //PC Control
    wire [1:0] Br_Result;
    wire Br_Detected;
    wire Br_Detected_Ex;
    wire Br_PredictedBit;

    //BTB
    wire [31:0] PC_Predicted;
    wire Hit;

    //Forward Control
    wire [1:0] Fw_1;
    wire [1:0] Fw_2;
    wire [4:0] Rd_MEM;
    wire EX_MEM_RegWEN;
    wire [4:0] Rd_WB;
    wire MEM_WB_RegWEN;
    wire [4:0] Rs1_EX;
    wire [4:0] Rs2_EX;
    wire [1:0] Fw_Detected;

    //Stall Control
    wire Stall_Detected;
    wire PC_Fetch_EN;
    wire FE_DE_Reg_EN;
    wire DE_EX_Reg_EN;
    wire DE_EX_Reg_RST;
    wire EX_MEM_Reg_RST;

    //Branch Compare result
    wire Br_Comp_Result;

    //Pattern History 
    wire Predict_StateM;

/******************* Functional Block *******************/
    assign Br_PredictedBit = Hit & Predict_StateM;

/******************* Functional Block *******************/
    //PC mux
    Mux4 pc_mux (.sel_port(PC_SEL),
                 .port_in_0(PC4_NEW),
                 .port_in_1(PC_Predicted),
                 .port_in_2(PC_ALU),
                 .port_in_3(PC4_OLD),
                 .port_out(PC_MUX));
    assign PC_ALU = ALU_OUT_EX;

    add4 add4_2 (.port_in(PC_EX),
                 .port_out(PC4_OLD));
//    assign PC4_OLD = PC_EX + 4;

    //PC block
    PC pc_1 (.port_in(PC_MUX),
             .clock(clk),
             .enable(PC_Fetch_EN),
             .port_out(PC_FE));
    //PC plus 4
    add4 add4_1 (.port_in(PC_FE),
                 .port_out(PC4_NEW));
    
    //IMEM
    IMEM imem_1 (.inst(Inst_FE),
                 .Pc(PC_FE));
    
    //Fetch to Decode stage resister bank
    wire [63:0] FetOut_Bus;
    wire [63:0] DecIn_Bus;
    assign FetOut_Bus = {Inst_FE, PC_FE};
    assign  {Inst_DE, PC_DE} = DecIn_Bus;
    DFF_fetch dff_fet_dec (.clk(clk),
                           .rst(1'b0),
                           .en(FE_DE_Reg_EN),
                           .D(FetOut_Bus),
                           .Q(DecIn_Bus));
    //Bank REG 
    REGBank regb_1 (.AddrA(Inst_DE[19:15]),
                    .AddrB(Inst_DE[24:20]),
                    .AddrD(Inst_WB[11:7]),
                    .DataD(DATA_WB_WB),
                    .clk(clk),
                    .RegWEn(Reg_WB_WEN),
                    .DataA(DataA_DE),
                    .DataB(DataB_DE));
    //Branch Detector
    Branch_Dectector br_detec (.Inst(Inst_DE),
                               .clk(clk),
                               .Br_Detected(Br_Detected));
    
    //Pattern History
    Pattern_History pattern (.Br_Detected(Br_Detected_Ex),
                             .Br_Comp_Result(Br_Comp_Result),
                             .clk(clk),
                             .Br_PredictedBit(Predict_StateM),
                             .Stall_Detected(Stall_Detected));
    
    //BTB
    Branch_Target br_target (.PC(PC_DE),
                             .PC_Ex(PC_EX),
                             .PC_ALU(ALU_OUT_EX),
                             .Br_Detected(Br_Detected_Ex),
                             .clk(clk),
                             .Hit(Hit),
                             .Target_Add(PC_Predicted),
                             .Stall_Detected(Stall_Detected));

    //ROM Decoder
    ROMDecoder romdec_1 (.Inst(Inst_DE),
                         .BrEq(1'b0),
                         .BrLT(1'b0),
                         .DataOut(dec2rom));    

    //ROM Control
    ROMControl romctrl_1 (.Addr(dec2rom),
                          .Data(ROM_DATA_DE));       

    //Decode to Execute stage resistor bank
    wire [181:0] DecOut_Bus;
    wire [181:0] ExIn_Bus;
    assign DecOut_Bus = {Br_Detected, Br_PredictedBit, 
                         PC_Predicted, ROM_DATA_DE,
                         DataB_DE, DataA_DE,
                         Inst_DE, PC_DE};           
    assign {Br_Detected_Ex, Br_PredictedBit_EX,
            PC_Predicted_EX, ROM_DATA_EX,
            DataB_EX, DataA_EX,
            Inst_EX, PC_EX} = ExIn_Bus;
    DFF_reg dff_dec_ex (.clk(clk),
                        .rst(DE_EX_Reg_RST),
                        .en(DE_EX_Reg_EN),
                        .D(DecOut_Bus),
                        .Q(ExIn_Bus));

    //Forward Mux A
    Mux4 mux4_fw_A (.sel_port(Fw_1),
                    .port_in_0(DataA_EX),
                    .port_in_1(DATA_WB_WB),
                    .port_in_2(ALU_OUT_MEM),
                    .port_in_3(32'h0),
                    .port_out(DataA_Mux_EX));

    //Forward Mux B
    Mux4 mux4_fw_B (.sel_port(Fw_2),
                    .port_in_0(DataB_EX),
                    .port_in_1(DATA_WB_WB),
                    .port_in_2(ALU_OUT_MEM),
                    .port_in_3(32'h0),
                    .port_out(DataB_Mux_EX));  

    //Immediate Gen
    ImmGen immgen_1 (.Inst(Inst_EX),
                     .ImmSel(ROM_DATA_EX[18:16]),
                     .DataOut(IMM)); 
    
    //Branch Comp
    branch_comp brcomp_1 (.A(DataA_Mux_EX),
                          .B(DataB_Mux_EX),
                          .BrUn(ROM_DATA_EX[14]),
                          .BrEq(BrEq),
                          .BrLT(BrLT));
                
    //Branch Comp Result
    N_Branchcomp compresult (.BrEq(BrEq),
                             .BrLT(BrLT),
                             .Inst(Inst_EX),
                             .jump(Br_Comp_Result));
    
    
    //Mux 2 to 1 at A gate of ALU
    Mux2 mux2_2 (.sel_port(ROM_DATA_EX[12]),
                 .port_in_0(DataA_Mux_EX),
                 .port_in_1(PC_EX),
                 .port_out(ALU_A));
    
    //Mux 2 to 1 at B gate of ALU
    Mux2 mux2_3 (.sel_port(ROM_DATA_EX[13]),
                 .port_in_0(DataB_Mux_EX),
                 .port_in_1(IMM),
                 .port_out(ALU_B));
    
    //ALU 
    ALU alu_1 (.DataA(ALU_A),
               .DataB(ALU_B),
               .ALUSel(ROM_DATA_EX[11:8]),
               .DataOut(ALU_OUT_EX));
    
    //Branch Predict Result
    Branch_Result brPreResult (.clk(clk),
                               .Predicted(Br_PredictedBit_EX),
                               .Execute(Br_Comp_Result),
                               .PC_Pre(PC_Predicted_EX),
                               .PC_ALU(PC_ALU),
                               .Result(Br_Result));
    
    //PC Control
    PC_Control pcCtrl (.Br_Result(Br_Result),
                       .Br_Dectected(Br_Detected),
                       .Br_Dectected_Ex(Br_Detected_Ex),
                       .Br_PredictedBit(Br_PredictedBit),
                       .PC_Sel(PC_SEL));
    
    //Stall Control
    Stall_Control stall (.Br_result(Br_Result),
                         .Br_Detected(Br_Detected_Ex),
                         .Inst(Inst_MEM),
                         .Fw_Detected(Fw_Detected),
                         .PC_Fetch_EN(PC_Fetch_EN),
                         .FE_DE_Reg_EN(FE_DE_Reg_EN),
                         .DE_EX_Reg_EN(DE_EX_Reg_EN),
                         .DE_EX_Reg_RST(DE_EX_Reg_RST),
                         .EX_MEM_Reg_RST(EX_MEM_Reg_RST),
                         .Stall_Detected(Stall_Detected));

    //Execute to Mem stage resistor bank
    wire [147:0] ExOut_Bus;
    wire [147:0] MemIn_Bus;
    assign ExOut_Bus = {ROM_DATA_EX, DataB_Mux_EX,
                        ALU_OUT_EX, Inst_EX,
                        PC_EX};           
    assign {ROM_DATA_MEM, DataB_Mux_MEM,
            ALU_OUT_MEM, Inst_MEM,
            PC_MEM} = MemIn_Bus;
    DFF_mem dff_ex_mem (.clk(clk),
                        .rst(EX_MEM_Reg_RST),
                        .en(1'b1),
                        .D(ExOut_Bus),
                        .Q(MemIn_Bus));      

    //PC + 4 to wb
    add4 add4_3 (.port_in(PC_MEM),
                 .port_out(PC4_MEM));  

    //DMEM
    DMEM dmem (.Addr(ALU_OUT_MEM),
               .DataW(DataB_Mux_MEM),
               .MemRW(ROM_DATA_MEM[7]),
               .LenSel(ROM_DATA_MEM[6:5]),
               .clk(clk),
               .DataR(dataR));      

    //DMEM Addjustment
    DMEM_ADDJ dmemAddj (.DataIn(dataR),
                        .FormatSel(ROM_DATA_MEM[4:2]),
                        .DataOut(dataROut));    


    //Mux4 Wb
    Mux4 mux4Wb (.sel_port(ROM_DATA_MEM[1:0]),
                 .port_in_0(dataROut),
                 .port_in_1(ALU_OUT_MEM),
                 .port_in_2(PC4_MEM),
                 .port_in_3(32'h0),
                 .port_out(Data_WB_MEM));
    
    //Execute to Mem stage resistor bank
    wire [83:0] MemOut_Bus;
    wire [83:0] WbIn_Bus;
    assign MemOut_Bus = {ROM_DATA_MEM, Data_WB_MEM,
                         Inst_MEM};           
    assign {ROM_DATA_WB, DATA_WB_WB,
            Inst_WB} = WbIn_Bus;
    DFF_mem dff_ex_mem (.clk(clk),
                        .rst(1'b0),
                        .en(1'b1),
                        .D(MemOut_Bus),
                        .Q(WbIn_Bus));  

    assign Reg_WB_WEN = ROM_DATA_WB[15];

    //Forward Control
    Forward_Control fwCtrl (.EX_MEM_RegWEN(ROM_DATA_MEM[15]),
                            .MEM_WB_RegWEN(ROM_DATA_WB[15]),
                            .Rd_MA(Inst_WB[11:7]),
                            .Rd_EX(Inst_MEM[11:7]),
                            .Rs1_ID(Inst_EX[19:15]),
                            .Rs2_ID(Inst_EX[24:20]),
                            .Fw_1(Fw_1),
                            .Fw_2(Fw_2),
                            .Fw_Detected(Fw_Detected));

    /******************* Assign and Always *******************/
     initial begin
        #0 clk = 1'b0;

    end
    always begin
        #50 clk = !clk;
    end                       

endmodule