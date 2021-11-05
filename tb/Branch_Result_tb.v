`timescale 1ns/1ps
module Branch_Result_tb;

parameter WIDTH_DATA_LENGTH = 32;
reg clk;
reg Predicted;
reg [WIDTH_DATA_LENGTH - 1:0] PC_Pre;
reg [WIDTH_DATA_LENGTH - 1:0] PC_ALU;
reg Execute;
wire [1:0] Result;

Branch_Result br_relt (.clk(clk),
                       .Predicted(Predicted),
                       .PC_Pre(PC_Pre),
                       .PC_ALU(PC_ALU),
                       .Execute(Execute),
                       .Result(Result));

initial begin
    #0  clk = 1'b0;
        PC_Pre = 32'h1234_0000;
        PC_ALU = 32'h1234_0000;
    #10 Predicted = 1'b0;
        Execute = 1'b0;
    #10 Predicted = 1'b0;
        Execute = 1'b1;
    #10 Predicted = 1'b1;
        Execute = 1'b1;
    #20 PC_Pre = 32'h1234_0000;
        PC_ALU = 32'h1234_FFFF;
end
always  begin
    #5 clk = !clk;
end
endmodule