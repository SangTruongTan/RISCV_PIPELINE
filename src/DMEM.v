`timescale 1ns/1ps
module DMEM (
    Addr,
    DataW,
    MemRW,
    LenSel,
    clk,
    DataR
);
    /************ Data Memory Block ************/
    parameter WIDTH_ADDR_LENGTH = 32;
    parameter WIDTH_DATA_LENGTH = 32;
    parameter MEM_DEPTH = 1 << 13;
    parameter WIDTH_MEM_LENGTH = 8;
    parameter LENGHT_MUX = 2;
    input [WIDTH_ADDR_LENGTH - 1:0] Addr;
    input [WIDTH_DATA_LENGTH - 1:0] DataW;
    input [LENGHT_MUX - 1:0] LenSel;
    input clk;
    input MemRW;
    output reg [WIDTH_DATA_LENGTH -1:0] DataR;
    /************ Data Memory ************/
    reg [WIDTH_MEM_LENGTH -1:0] DMEM [0:MEM_DEPTH -1];


    assign DataR = {DMEM[Addr+3], DMEM[Addr+2], DMEM[Addr+1], DMEM[Addr]};
    integer i;
    initial begin
        for (i = 0; i < MEM_DEPTH; i = i + 1) begin
            DMEM[i] = 32'h0;
        end
    end
    always @(posedge clk ) begin
        if (MemRW == 1'b1) begin
            case (LenSel)
                2'b00:  DMEM[Addr] <= DataW[7:0];     //Store Byte
                2'b01: {DMEM[Addr+1], DMEM[Addr]} <= DataW[16:0];    //Store Haft Word 
                2'b11: {DMEM[Addr+3], DMEM[Addr+2], DMEM[Addr+1], DMEM[Addr]} <= DataW[31:0];    //Store Word
            endcase 
        end
    end

endmodule