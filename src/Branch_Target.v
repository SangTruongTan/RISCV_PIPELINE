module Branch_Target (
    PC,
    PC_Ex,
    PC_ALU,
    Br_Detected,
    clk,
    Hit,
    Target_Add
);
/****************** Decleration ******************/
    parameter WIDTH_DATA_LENGTH = 32;
    parameter WIDTH_TAG_LENGTH = 32-2-3;
    parameter WIDTH_ENTRY_LENTH = 3;
    parameter ENTRY_DEPTH_LENGTH = 1<<3;
    input [WIDTH_DATA_LENGTH - 1:0] PC;
    input [WIDTH_DATA_LENGTH - 1:0] PC_Ex;
    input [WIDTH_DATA_LENGTH - 1:0] PC_ALU;
    input Br_Detected;
    input clk;
    output reg Hit;
    output reg [WIDTH_DATA_LENGTH - 1:0] Target_Add;

    reg [WIDTH_TAG_LENGTH - 1: 0] TAG [0: ENTRY_DEPTH_LENGTH - 1];
    reg [WIDTH_DATA_LENGTH - 1:0] PR_PC [0: ENTRY_DEPTH_LENGTH - 1];

    wire [WIDTH_ENTRY_LENTH - 1:0] Entry;
    wire [WIDTH_ENTRY_LENTH - 1:0] Entry_Ex;
    wire [WIDTH_TAG_LENGTH - 1:0] PC_tag;
    wire [WIDTH_TAG_LENGTH - 1:0] PC_tag_Ex;
    wire [WIDTH_TAG_LENGTH - 1:0] PC_tagT;
/****************** Initialize ******************/  
    integer i;
    initial begin
        for (i = 0; i < ENTRY_DEPTH_LENGTH; i = i + 1) begin
            TAG [i] = 32'h0;
            PR_PC[i] = 32'h0;
        end
    end
/****************** Assign ******************/  
    assign Entry = PC[WIDTH_ENTRY_LENTH - 1 + 2: 0 + 2];
    assign Entry_Ex = PC_Ex[WIDTH_ENTRY_LENTH - 1 + 2: 0 + 2];
    assign PC_tag = PC[WIDTH_DATA_LENGTH - 1: WIDTH_ENTRY_LENTH + 2];
    assign PC_tag_Ex = PC_Ex[WIDTH_DATA_LENGTH - 1: WIDTH_ENTRY_LENTH + 2];
    assign PC_tagT = TAG[Entry];
    assign Target_Add = PR_PC[Entry];
    assign Hit = &(PC_tag ~^ PC_tagT);

/****************** Always function ******************/  
    always @(posedge clk ) begin
        if(Br_Detected) begin
            TAG[Entry_Ex] = PC_tag_Ex;
            PR_PC[Entry_Ex] = PC_ALU;
        end
    end
endmodule