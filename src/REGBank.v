module REGBank (
    AddrA,
    AddrB,
    AddrD,
    DataD,
    clk,
    RegWEn,
    DataA,
    DataB
);

/****************** Decleration ******************/
    parameter WIDTH_ADDR_LENGTH = 5;
    parameter WIDTH_DATA_LENGTH = 32;
    parameter NUM_REG_BANK = 1 << 5;
    input clk;
    input RegWEn;
    input [WIDTH_ADDR_LENGTH - 1:0] AddrA;
    input [WIDTH_ADDR_LENGTH - 1:0] AddrB;
    input [WIDTH_ADDR_LENGTH - 1:0] AddrD;
    input [WIDTH_DATA_LENGTH - 1:0] DataD;

    output reg [WIDTH_DATA_LENGTH - 1:0] DataA;
    output reg [WIDTH_DATA_LENGTH - 1:0] DataB;

/****************** Register Bank ******************/
    reg [WIDTH_DATA_LENGTH - 1:0] REG [0: NUM_REG_BANK - 1];

/****************** Functional ******************/
    assign REG[0] = 32'h0000_0000;  //Zero register
    assign DataA = REG[AddrA];
    assign DataB = REG[AddrB];
    
/****************** Always function ******************/  
    integer i;
    initial begin
        for (i = 0; i < NUM_REG_BANK; i = i + 1) begin
            REG[i] = 32'h0;
        end
    end

    always @(posedge clk ) begin
        if (RegWEn == 1'b1) begin
            if (AddrD != 5'h00) begin
                REG[AddrD] = DataD;
            end
        end
    end
endmodule