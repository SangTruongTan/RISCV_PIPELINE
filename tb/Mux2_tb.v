`timescale 1ns/1ps
module Mux2_tb;
    reg sel_port;
    reg [31:0] port_in_0;
    reg [31:0] port_in_1;
    wire [31:0] port_out;

    Mux2 mux2 (.sel_port(sel_port), .port_in_0(port_in_0), .port_in_1(port_in_1), .port_out(port_out));
    initial begin
        #0 sel_port = 1'd1;
        #0 port_in_0 = 32'h0000_1111;
        #0 port_in_1 = 32'h1111_0000;

        #10 sel_port = 1'd0;
        #10 port_in_0 = 32'h0000_1001;
        #10 port_in_1 = 32'h1111_0000;

        #15 sel_port = 1'd1;
        #15 port_in_0 = 32'h1100_1111;
        #15 port_in_1 = 32'h1111_0011;

        #150 sel_port = 1'd0;
        #150 port_in_0 = 32'h0000_1111;
        #150 port_in_1 = 32'h1111_0000;
    end
endmodule