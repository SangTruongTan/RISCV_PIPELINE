module ROMDecoder_tb;
    parameter WIDTH_INST_LENGTH = 32;
    parameter WIDTH_DATAOUT_LENGTH  = 6;
    parameter WIDTH_CONTROL_LENGTH = 11;
    reg [WIDTH_INST_LENGTH - 1:0] Inst;
    reg BrEq;
    reg BrLT;
    wire [WIDTH_DATAOUT_LENGTH - 1:0] DataOut;

    ROMDecoder Romdec1 (.Inst(Inst),
                        .BrEq(BrEq),
                        .BrLT(BrLT),
                        .DataOut(DataOut));
    initial begin
        #0 Inst = 32'h02802503;    //LW
        #20 Inst = 32'h00100593;
        
    end

endmodule
