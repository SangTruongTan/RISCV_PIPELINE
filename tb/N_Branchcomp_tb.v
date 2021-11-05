`timescale 1ns/1ps
module N_Branchcomp_tb;
    parameter WIDTH_CONTROL_LENGTH = 11;
    reg [31:0] Inst;
    reg BrEq;
    reg BrLT;
    wire jump;

    N_Branchcomp branchcomp (.Inst(Inst),
                        .BrEq(BrEq),
                        .BrLT(BrLT),
                        .jump(jump));
    initial begin
        #0  Inst = 32'h0082_9c63;
            BrEq = 1'b0;
            BrLT = 1'b0;
        #10 BrEq = 1'b1; 
            BrLT = 1'b1;
        #20 Inst = 32'h000f_9063;
            BrEq = 1'b0;
            BrLT = 1'b0;
        #10 BrEq = 1'b1;
            BrLT = 1'b1; 
        #20 Inst = 32'h0073_4863;
            BrEq = 1'b0;
            BrLT = 1'b0;
        #10 BrEq = 1'b1;
            BrLT = 1'b1; 
        #20 Inst = 32'h000a_8063;
            BrEq = 1'b0;
            BrLT = 1'b0;
        #10 BrEq = 1'b1;
            BrLT = 1'b1; 
        #20 Inst = 32'hfe52_cee3;
            BrEq = 1'b0;
            BrLT = 1'b0;
        #10 BrEq = 1'b1;
            BrLT = 1'b1;
        #20 Inst = 32'hff5f_f0ef;
            BrEq = 1'b0;
            BrLT = 1'b0;
        #10 BrEq = 1'b1;
            BrLT = 1'b1;
        #20 Inst = 32'hf9c3_82e7;
            BrEq = 1'b0;
            BrLT = 1'b0;
        #10 BrEq = 1'b1;
            BrLT = 1'b1;
    end

endmodule