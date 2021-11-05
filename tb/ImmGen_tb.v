module ImmGen_tb;
    parameter WIDTH_INST_LENGTH = 32;
    parameter WIDTH_SEL_LENGTH = 3;
    parameter WIDTH_DATA_LENGTH = 32;

    reg [WIDTH_INST_LENGTH - 1:0] Inst;
    reg [WIDTH_SEL_LENGTH - 1:0] ImmSel;
    wire [WIDTH_DATA_LENGTH - 1:0] DataOut;

    ImmGen Immgen1 (.Inst(Inst),
                    .ImmSel(ImmSel),
                    .DataOut(DataOut));
    initial begin
        #0  Inst = 32'hF0F0_0000;
            ImmSel = 3'b000;

        #50 ImmSel = 3'b001;

        #50 Inst = 32'h01_A0_0000;
            ImmSel = 3'b010;

        #50 Inst = 32'b1110001_0000000000000_10101_0000000;
            ImmSel = 3'b011;
        #50 Inst = 32'b0110001_0000000000000_10101_0000000;

        #50 ImmSel = 3'b100;
            Inst = 32'b1110001_0000000000000_10101_0000000;
        #50 Inst = 32'b0110001_0000000000000_10101_0000000;

        #50 ImmSel = 3'b101;
            Inst = 32'hF0F0_EFFF;
        
        #50 ImmSel = 3'b110;
            Inst = 32'hF0F0_EFFF;
        #50 Inst = 32'h70F0_EFFF;
        #50 ImmSel = 3'b110;
            Inst = 32'hA54D_4FFF;
        #50 Inst = 32'h554D_4FFF;
    


    end
endmodule
