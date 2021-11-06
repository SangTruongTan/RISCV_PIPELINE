module Forward_Control (
    EX_MEM_RegWEN,
    MEM_WB_RegWEN,
    Rd_MA,
    Rd_EX,
    Rs1_ID,
    Rs2_ID,
    Fw_1,
    Fw_2,
    Fw_Detected
);
/****************** Decleration ******************/
    parameter No_Fw = 2'b00, WB_Fw = 2'b01, MEM_Fw = 2'b10;
    input EX_MEM_RegWEN;
    input MEM_WB_RegWEN;
    input [4:0]Rd_MA;
    input [4:0]Rd_EX;
    input [4:0]Rs1_ID;
    input [4:0]Rs2_ID;
    output reg [1:0]Fw_1;
    output reg [1:0]Fw_2;
    output reg [1:0]Fw_Detected;
    
/****************** Always function ******************/  
    always @(*) begin
        Fw_1 = No_Fw;
        Fw_2 = No_Fw;
        Fw_Detected = 2'b00;
        if(EX_MEM_RegWEN & (Rd_EX != 0) & (Rd_EX == Rs1_ID)) begin
            Fw_1 = MEM_Fw;
            Fw_Detected = 2'b10;
        end else if(MEM_WB_RegWEN & (Rd_MA != 0) & (Rd_MA == Rs1_ID)) begin
            Fw_1 = WB_Fw;
            Fw_Detected = 2'b01;
        end

        if(EX_MEM_RegWEN & (Rd_EX != 0) & (Rd_EX == Rs2_ID)) begin
            Fw_2 = MEM_Fw;
            Fw_Detected = 2'b10;
        end else if(MEM_WB_RegWEN & (Rd_MA != 0) & (Rd_MA == Rs2_ID)) begin
            Fw_2 = WB_Fw;
            Fw_Detected = 2'b01;
        end        
    end
endmodule