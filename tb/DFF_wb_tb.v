`timescale 1ns/1ps
module fetch_tb;
parameter N = 64;
    reg clk;
    reg rst;
    reg en;
    reg [31:0] mux_x;
    reg [31:0] inst_w;
    wire [N-1:0] D;
    wire [N-1:0] Q;

    assign D = {mux_x, inst_w};
DFF_fetch dff_fetch (.clk(clk), .rst(rst), .en(en), .D(D), .Q(Q));
initial begin
    #0 clk = 1'b0;
    #0 mux_x = 32'h0;
    #0 inst_w = 32'h0;
    #0 en = 1'b0; 
    #0 rst = 1'b0;
    #10 en = 1'b1;
    #10 mux_x = 32'hFFFF_FFFF;
         inst_w = 8'd10;
    #20 mux_x = 8'd5;
         inst_w = 8'd50;
    #50 mux_x = 8'd10;
        inst_w = 8'd10;
    #60 en = 1'b0;
    #70 mux_x = 8'd20;
         inst_w = 8'd21;
    #10 en = 1'b1;
    #83 rst = 1'b1;
end
always begin
        #10 clk = !clk;
    end
endmodule