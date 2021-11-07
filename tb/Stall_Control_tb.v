`timescale 1ns/1ps
module Stall_Control_tb;

    parameter WIDTH_DATA_LENGTH = 32;
    parameter No_Fw = 2'b00, WB_Fw = 2'b01, MEM_Fw = 2'b10;
    reg [1:0] Br_result;
    reg [WIDTH_DATA_LENGTH - 1:0] Inst;
    reg [1:0]Fw_Detected;
    reg Br_Detected;
    wire PC_Fetch_EN;
    wire FE_DE_Reg_EN;
    wire DE_EX_Reg_EN;
    wire DE_EX_Reg_RST;
    wire EX_MEM_Reg_RST;
    wire Stall_Detected;
    Stall_Control stall (.Br_result(Br_result),
                         .Inst(Inst),
                         .Fw_Detected(Fw_Detected),
                         .Br_Detected(Br_Detected),
                         .PC_Fetch_EN(PC_Fetch_EN),
                         .FE_DE_Reg_EN(FE_DE_Reg_EN),
                         .DE_EX_Reg_EN(DE_EX_Reg_EN),
                         .DE_EX_Reg_RST(DE_EX_Reg_RST),
                         .EX_MEM_Reg_RST(EX_MEM_Reg_RST),
                         .Stall_Detected(Stall_Detected));

    initial begin
        #0  Fw_Detected = No_Fw;
            Inst = 32'h1234_5678;
            Br_Detected = 1'b0;
            Br_result = 2'b01;
        #10 Br_result = 2'b00;
            Inst = 32'hf9c3a303;
            Fw_Detected = MEM_Fw;
            Br_Detected = 1'b0;
        #10 Fw_Detected = MEM_Fw;
            Br_Detected = 1'b1;
        #10 Br_result = 2'b11;
            Inst = 32'h0000_0000;
            Fw_Detected = WB_Fw;
        #10 Br_result = 2'b01;
        #10 Br_result = 2'b01;
            Fw_Detected = MEM_Fw;
        #20 Br_Detected = 1'b0;


    end
endmodule