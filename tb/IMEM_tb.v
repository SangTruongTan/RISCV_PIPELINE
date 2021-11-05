`timescale 1ns/1ps
module IMEM_Test;
    parameter INST_WIDTH = 32;
    parameter PC_WIDTH = 32;
    reg [PC_WIDTH -1:0] PC;
    wire [INST_WIDTH -1:0] inst;
    
    IMEM imem (.inst(inst), .PC(PC));
    initial begin
        #0 PC = 32'h0000_0000;
        #10 PC = 32'h0000_0100;
        #10 PC = 32'h0000_1000;
    end
endmodule