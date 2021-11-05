`timescale 1ns/1ps
module PC_tb;
    reg [31:0] port_in;
    reg clock;
    wire [31:0]port_out;

    PC pc (.port_in(port_in), .clock(clock), .port_out(port_out));
    initial begin
        #0 clock = 1'b0;
        #10 port_in = 32'h0000_1111;
        #15 port_in = 32'h1111_1111;
        #20 port_in = 32'h1010_1010;
        #50 port_in = 32'h1000_1000;
        
    end
     always begin
        #10 clock = !clock;
    end
endmodule