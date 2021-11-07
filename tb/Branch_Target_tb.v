`timescale 1ns/1ps
module Branch_Target_tb;

    parameter WIDTH_DATA_LENGTH = 32;
    parameter WIDTH_TAG_LENGTH = 32-2-3;
    parameter WIDTH_ENTRY_LENTH = 3;
    parameter ENTRY_DEPTH_LENGTH = 1<<3;
    reg [WIDTH_DATA_LENGTH - 1:0] PC;
    reg [WIDTH_DATA_LENGTH - 1:0] PC_Ex;
    reg [WIDTH_DATA_LENGTH - 1:0] PC_ALU;
    reg Br_Detected;
    reg Stall_Detected;
    reg clk;
    wire Hit;
    wire [WIDTH_DATA_LENGTH - 1:0] Target_Add;
    Branch_Target br_tar (.clk(clk),
                          .PC(PC),
                          .PC_Ex(PC_Ex),
                          .PC_ALU(PC_ALU),
                          .Br_Detected(Br_Detected),
                          .Hit(Hit),
                          .Target_Add(Target_Add),
                          .Stall_Detected(Stall_Detected));
    initial begin
        #0  Stall_Detected = 1'b0;
            clk = 1'b0;
            PC = 32'h1234_0000;
            PC_ALU = 32'hFFFF_AAAA;
            Br_Detected = 1'b0;
        #10 Br_Detected = 1'b0;
        #10 Br_Detected = 1'b1;
        #10 PC = 32'h1234_0004;
            PC_ALU = 32'h1414_1414;
            Stall_Detected = 1'b1;
        #10 Stall_Detected = 1'b0;
        #10 PC = 32'h1234_0000;
            PC_ALU = 32'hAAAA_AAAA;
        #10 Br_Detected = 1'b0;
        #10 PC = 32'h1234_0004;

    end
    always begin
        #5 clk = 1'b1;
        PC_Ex = PC;
        #5 clk = 1'b0;
            
    end
endmodule