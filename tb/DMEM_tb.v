`timescale 1ns/1ps
module DMEM_tb;
    parameter WIDTH_ADDR_LENGTH = 32;
    parameter WIDTH_DATA_LENGTH = 32;
    parameter MEM_DEPTH = 1 << 10;
    parameter WIDTH_MEM_LENGTH = 8;
    parameter LENGHT_MUX = 2;
    reg [WIDTH_ADDR_LENGTH - 1:0] Addr;
    reg [WIDTH_DATA_LENGTH - 1:0] DataW;
    reg [LENGHT_MUX - 1:0] LenSel;
    reg clk;
    reg MemRW;
    wire [WIDTH_DATA_LENGTH -1:0] DataR;

    DMEM dmem1 (.Addr(Addr),
                .DataW(DataW),
                .MemRW(MemRW),
                .LenSel(LenSel),
                .clk(clk),
                .DataR(DataR));
    initial begin
        #0  LenSel = 2'b00;
            DataW = 32'h1234_5678;
            Addr = 32'h0000_0000;
            MemRW = 1'b0;
            clk = 1'b0;
        #10 MemRW = 1'b1;
            Addr = 32'h0000_0002;
            LenSel = 2'b01;
        #10 Addr = 32'h0000_0004;
            LenSel = 2'b11;
        #10 MemRW = 1'b0;
            Addr = 32'h0000_0000;
        #10 Addr = 32'h0000_0002;
        #10 Addr = 32'h0000_0004;
        ///Not Enable Write Test
        #10 Addr = 32'h0000_0000;
            
    end
    always begin
        #10 clk = !clk;
    end
endmodule