`timescale 1ns/1ps
module Mux4_tb;
    reg [1:0] sel_port;
    reg [31:0] port_in_0;
    reg [31:0] port_in_1;
    reg [31:0] port_in_2;
    reg [31:0] port_in_3;
    wire [31:0] port_out;

    Mux4 mux4 (.sel_port(sel_port), .port_in_0(port_in_0), .port_in_1(port_in_1), .port_in_2(port_in_2), .port_in_3(port_in_3), .port_out(port_out));
    initial begin
        #0 sel_port = 2'd1;
        #0 port_in_0 = 32'h0000_1111;
        #0 port_in_1 = 32'h1111_0000;
        #0 port_in_2 = 32'h1010_1010;
        #0 port_in_3 = 32'h1111_1111;

        #10 sel_port = 2'd0;
        #10 port_in_0 = 32'h0000_1111;
        #10 port_in_1 = 32'h1111_0000;
        #10 port_in_2 = 32'h1010_1010;
        #10 port_in_3 = 32'h1111_1111;

        #15 sel_port = 2'd3;
        #15 port_in_0 = 32'h0000_1111;
        #15 port_in_1 = 32'h1111_0000;
        #15 port_in_2 = 32'h1010_1010;
        #15 port_in_3 = 32'h1111_1111;
    end
endmodule