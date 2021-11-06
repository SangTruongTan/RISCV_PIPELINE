`timescale 1ns/1ps
module DFF_reg_tb;
parameter N = 128;
    reg clk;
    reg rst;
    reg en;
    reg [31:0] pc_x;
    reg [31:0] rs1_x;
    reg [31:0] rs2_x;
    reg [31:0] inst_x;
    wire [N-1:0] D;
    wire [N-1:0] Q;

    assign D = {pc_x, rs1_x, rs2_x, inst_x};
DFF_reg dff_reg (.clk(clk), .rst(rst), .en(en), .D(D), .Q(Q));
initial begin
    #0 clk = 1'b0;
    #0 pc_x = 32'h0;
    #0 rs1_x = 32'h0;
    #0 rs2_x = 32'h0;
    #0 inst_x = 32'h0;
    #0 en = 1'b0; 
    #0 rst = 1'b0;
    #10 en = 1'b1;
    #10 pc_x = 32'h1234_4321;
        rs1_x = 32'h2468_1357;
        rs2_x = 32'h1256_3478;
        inst_x = 32'h1133_2244;
    #20 pc_x = 32'h0234_4321;
        rs1_x = 32'h0468_1357;
        rs2_x = 32'h0256_3478;
        inst_x = 32'h0133_2244;
    #50 pc_x = 32'h0034_4321;
        rs1_x = 32'h0068_1357;
        rs2_x = 32'h0056_3478;
        inst_x = 32'h0033_2244;
    #60 en = 1'b0;
    #70 pc_x = 32'h0004_4321;
        rs1_x = 32'h0008_1357;
        rs2_x = 32'h0006_3478;
        inst_x = 32'h0003_2244;
    #10 en = 1'b1;
    #83 rst = 1'b1;
end
always begin
        #10 clk = !clk;
    end
endmodule