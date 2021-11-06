`timescale 1ns/1ps
module Forward_Control_tb;

    parameter No_Fw = 2'b00, WB_Fw = 2'b01, MEM_Fw = 2'b10;
    reg EX_MEM_RegWEN;
    reg MEM_WB_RegWEN;
    reg [4:0]Rd_MA;
    reg [4:0]Rd_EX;
    reg [4:0]Rs1_ID;
    reg [4:0]Rs2_ID;
    wire [1:0]Fw_1;
    wire [1:0]Fw_2;
    wire [1:0]Fw_Detected;

    Forward_Control fw_ctrl (.EX_MEM_RegWEN(EX_MEM_RegWEN),
                             .MEM_WB_RegWEN(MEM_WB_RegWEN),
                             .Rd_MA(Rd_MA),
                             .Rd_EX(Rd_EX),
                             .Rs1_ID(Rs1_ID),
                             .Rs2_ID(Rs2_ID),
                             .Fw_1(Fw_1),
                             .Fw_2(Fw_2),
                             .Fw_Detected(Fw_Detected));
    initial begin
        #0  EX_MEM_RegWEN = 1;
            Rd_EX = 5'b0000_0;
            Rs1_ID = 5'b0000_0;
            Rs2_ID = 5'b0000_0;
        #10 Rs1_ID = 5'b0000_1;
            Rd_EX = 5'b0000_1;
        #10 Rs2_ID = 5'b0000_1;
        #10 Rs2_ID = 5'b0001_1;
        #15 EX_MEM_RegWEN = 1'b0;
    end
    always begin
        #10 MEM_WB_RegWEN = EX_MEM_RegWEN;
            Rd_MA = Rd_EX;
    end

endmodule