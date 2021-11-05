module N_Branchcomp (BrEq, BrLT, Inst, jump);
    parameter WIDTH_CONTROL_LENGTH = 11;
    input BrEq; 
    input BrLT;
    input [31:0] Inst;
    output reg jump;
    reg [WIDTH_CONTROL_LENGTH - 1:0] Ctrl;
    assign Ctrl = {Inst[30], Inst[14:12], Inst[6:2], BrEq, BrLT};

    always @(Ctrl) begin
        casex (Ctrl)
        //B type, Conditional Branch
            11'b?_000_11000_1_?: jump = 1'b1;   //BEQ, pass condition
            11'b?_000_11000_0_?: jump = 1'b0;   //BEQ
            11'b?_001_11000_1_?: jump = 1'b0;   //BNE, not pass condition
            11'b?_001_11000_0_?: jump = 1'b1;   //BNE
            11'b?_100_11000_?_1: jump = 1'b1;   //BLT, pass condition
            11'b?_100_11000_?_0: jump = 1'b0;   //BLT
            11'b?_101_11000_?_1: jump = 1'b0;   //BGE, not pass condition
            11'b?_101_11000_?_0: jump = 1'b1;   //BGE
            11'b?_110_11000_?_1: jump = 1'b1;   //BLTU, pass condition
            11'b?_110_11000_?_0: jump = 1'b0;   //BLTU
            11'b?_111_11000_?_1: jump = 1'b0;   //BGEU, not pass condition
            11'b?_111_11000_?_0: jump = 1'b1;   //BGEU
         //J type, unConditional Branch
            11'b?_???_11011_?_?: jump = 1'b1;   //JAL
            11'b?_000_11001_?_?: jump = 1'b1;   //JALR
            default: jump = 1'b0;
        endcase
    end
endmodule