`timescale 1ns/1ps
module fetch_tb;
parameter N = 64;
    reg clk;
    reg rst;
    reg en;
    reg [31:0] pc_d;
    reg [31:0] inst_d;
    wire [N-1:0] D;
    wire [N-1:0] Q;

    assign D = {pc_d, inst_d};
DFF_fetch dff_fetch (.clk(clk), .rst(rst), .en(en), .D(D), .Q(Q));
initial begin
     #0 clk = 1'b0;
    #0 pc_d= 32'h0;
    #0 inst_d = 32'h0;
    #0 en = 1'b0; 
    #0 rst = 1'b0;
    #10 en = 1'b1;
    #10 pc_d= 32'hFFFF_FFFF;
         inst_d = 8'd10;
    #20 pc_d= 8'd5;
         inst_d = 8'd50;
    #50 pc_d= 8'd10;
        inst_d = 8'd10;
    #60 en = 1'b0;
    #70 pc_d= 8'd20;
         inst_d = 8'd21;
    #10 en = 1'b1;
    #83 rst = 1'b1;
end
always begin
        #10 clk = !clk;
    end
endmodule
