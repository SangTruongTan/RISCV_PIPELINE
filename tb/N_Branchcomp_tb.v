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
        #0 Inst = 32'h00728463;
            BrEq = 1'b0;
        #10 BrEq = 1'b1; 
        
    end

endmodule