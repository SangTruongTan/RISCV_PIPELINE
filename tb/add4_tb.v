`timescale 1ns/1ps
module add4_tb;
reg [31:0] port_in;
wire [31:0] port_out;
add4 add4 (.port_in(port_in), .port_out(port_out));
initial begin
    #10 port_in = 32'h0001_0000;
end
endmodule