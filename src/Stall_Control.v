module Stall_Control (
    Br_result,
    Br_Detected,
    Inst,
    Fw_Detected,
    PC_Fetch_EN,
    FE_DE_Reg_EN,
    DE_EX_Reg_EN,
    DE_EX_Reg_RST,
    EX_MEM_Reg_RST
);
/****************** Decleration ******************/
    parameter WIDTH_DATA_LENGTH = 32;
    parameter No_Fw = 2'b00, WB_Fw = 2'b01, MEM_Fw = 2'b10;
    input [1:0] Br_result;
    input [WIDTH_DATA_LENGTH - 1:0] Inst;
    input [1:0]Fw_Detected;
    input Br_Detected;
    output reg PC_Fetch_EN;
    output reg FE_DE_Reg_EN;
    output reg DE_EX_Reg_EN;
    output reg DE_EX_Reg_RST;
    output reg EX_MEM_Reg_RST;
    wire Load_Inst;
/****************** Assignment ******************/  
    assign Load_Inst = !(|(Inst[6:2]));


/****************** Initialize ******************/  
    initial begin
        PC_Fetch_EN = 1'b1;
        FE_DE_Reg_EN = 1'b1;
        DE_EX_Reg_EN = 1'b1;
        DE_EX_Reg_RST = 1'b0;
        EX_MEM_Reg_RST = 1'b0;

    end

/****************** Always function ******************/  
    always @(*) begin
        PC_Fetch_EN = 1'b1;
        FE_DE_Reg_EN = 1'b1;
        DE_EX_Reg_EN = 1'b1;
        DE_EX_Reg_RST = 1'b0;
        EX_MEM_Reg_RST = 1'b0;
        if((Br_result != 2'b01)& (Br_Detected)) begin        //Not result 01
            DE_EX_Reg_RST = 1'b1;
        end else if (Load_Inst & (Fw_Detected == MEM_Fw)) begin
            PC_Fetch_EN = 1'b0;
            FE_DE_Reg_EN = 1'b0;
            DE_EX_Reg_EN = 1'b0;
            EX_MEM_Reg_RST = 1'b1;
        end
    end
    
endmodule