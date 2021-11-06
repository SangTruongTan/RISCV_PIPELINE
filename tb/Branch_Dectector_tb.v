module Branch_Dectector_tb;
reg [31:0]Inst;
reg clk;
wire Br_Dec;

Branch_Dectector br_dec1 (.Inst(Inst),
                          .clk(clk),
                          .Br_Detected(Br_Dec));

initial begin
    #0 clk = 1'b0;
    #0 Inst = 32'h00728463;
    #15 Inst = 32'h005282b3;
    #15 Inst = 32'h00528333;
    #15 Inst = 32'hfe52fee3;
    #15 Inst = 32'h00528333;
    #15 Inst = 32'hff5ff0ef;
    #15 Inst = 32'hf9c382e7;
    #15 Inst = 32'h007302b3;
end
always  begin
    #5 clk = !clk;
end
endmodule