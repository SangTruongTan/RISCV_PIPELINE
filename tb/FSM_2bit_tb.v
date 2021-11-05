`timescale 1ns/1ps
module FSM_2bit_tb;
    reg x;
    reg clk;
    reg rst;
    reg [1:0] state_old;
    wire [1:0] state;

FSM_2bit fsm_2bit (.x(x), .clk(clk), .rst(rst), .state(state), .state_old(state_old));
initial begin
     #0 rst = 1'b0;
     #0 clk = 1'b0;
     #10 state_old = 2'b00;
         x = 1'b0;
     #30 x = 1'b1;
     #20 state_old = 2'b01;
         x = 1'b0;
     #30    x = 1'b1;
     #30 state_old = 2'b10;
         x = 1'b0;
     #30   x = 1'b1;
     #40 state_old = 2'b11;
         x = 1'b0;
     #30    x = 1'b1;
     #80 rst = 1'b1;
end
 always begin
        #10 clk = !clk;
    end
endmodule