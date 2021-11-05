module REGBank_tb;
    parameter WIDTH_ADDR_LENGTH = 5;
    parameter WIDTH_DATA_LENGTH = 32;
    reg clk;
    reg RegWEn;
    reg [WIDTH_ADDR_LENGTH - 1:0] AddrB;
    reg [WIDTH_ADDR_LENGTH - 1:0] AddrD;
    reg [WIDTH_ADDR_LENGTH - 1:0] AddrA;
    reg [WIDTH_DATA_LENGTH - 1:0] DataD;

    wire [WIDTH_DATA_LENGTH - 1:0] DataA;
    wire [WIDTH_DATA_LENGTH - 1:0] DataB;

    REGBank RegB1   (.AddrA(AddrA),
                     .AddrB(AddrB),
                     .AddrD(AddrD),
                     .DataD(DataD),
                     .clk(clk),
                     .RegWEn(RegWEn),
                     .DataA(DataA),
                     .DataB(DataB));
    initial begin
        #0  clk = 1'b0;
            AddrD = 5'b00000;
            RegWEn = 1'b1;
            DataD = 32'h1234_56789;
            AddrA = 5'b00000;
            AddrB = 5'b00001;
        #50 AddrD = 5'b00001;
            DataD = 32'hFFFF_AAAA;
    end

    always begin
        #20 clk = !clk; 
            DataD = DataD + 1;
            AddrA = AddrA + 1;
            AddrB = AddrB + 1;
    end
endmodule