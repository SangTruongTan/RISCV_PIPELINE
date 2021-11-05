module ImmGen (
    Inst,
    ImmSel,
    DataOut
);
/****************** Decleration ******************/
    parameter WIDTH_INST_LENGTH = 32;
    parameter WIDTH_SEL_LENGTH = 3;
    parameter WIDTH_DATA_LENGTH = 32;

    input [WIDTH_INST_LENGTH - 1:0] Inst;
    input [WIDTH_SEL_LENGTH - 1:0] ImmSel;
    output reg [WIDTH_DATA_LENGTH - 1:0] DataOut;

/****************** Always function ******************/   
    always @(*) begin
        case (ImmSel) 
            3'b000: DataOut = {{20{Inst[31]}}, Inst[31:20]};    //Expend signed
            3'b001: DataOut = {{20{0}}, Inst[31:20]};           //Expend unsigned
            3'b010: DataOut = {{27{0}}, Inst[24:20]};           //Expend unsigned
            3'b011: DataOut = {{20{Inst[31]}}, Inst[31:25], Inst[11:7]};    //Expend signed
            3'b100: DataOut = {{19{Inst[31]}}, Inst[31], Inst[7], Inst[30:25], Inst[11:8], 1'b0}; 
            3'b101: DataOut = {Inst[31:12], 12'b0 };
            3'b110: DataOut = {{11{Inst[31]}}, Inst[31], Inst[19:12], Inst[20], Inst[30:21], 1'b0};
        endcase
    end
endmodule
