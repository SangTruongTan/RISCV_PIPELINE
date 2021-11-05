module ALU_tb;
    parameter WIDTH_DATA_LENGTH = 32;
    parameter WIDTH_ALUSEL_LENGTH = 4;
    reg [WIDTH_DATA_LENGTH - 1:0] DataA;
    reg [WIDTH_DATA_LENGTH - 1:0] DataB;
    reg [WIDTH_ALUSEL_LENGTH - 1:0] ALUSel;
    wire [WIDTH_DATA_LENGTH - 1:0] DataOut;

    ALU alu1 (.DataA(DataA),
              .DataB(DataB),
              .ALUSel(ALUSel),
              .DataOut(DataOut));
    initial begin
        #0  ALUSel = 4'b0000;
            DataA = 32'd100;
            DataB = 32'd456;
        #50 DataA = -32'd100;
            DataB = -32'd1235;
        #200 ALUSel = 4'b0001;
            DataA = 32'd5000;
            DataB = 32'd1234;
        #50 DataA = 32'd1234;
            DataB = 32'd2345;
        #50 DataA = -32'd4000;
            DataB = -32'd2000;
        #50 DataA = -32'd4000;
            DataB = 32'd1245;
        #200 ALUSel = 4'b0010;
            DataA = 32'hF0F0_A4A4;
            DataB = 32'd5;
        #200 ALUSel = 4'b0011;
            DataA = 32'd100;
            DataB = 32'd5000;
        #50 DataA = -32'd5000;
            DataB = -32'd5001;
        #50 DataA = -32'd1234;
            DataB = -32'd1234;
        #200 ALUSel = 4'b0100;
            DataA = 32'd1234;
            DataB = 32'd4321;
        #50 DataA = -32'd1234;
            DataB = -32'd1000;
        #200 ALUSel = 4'b0101;
            DataA = 32'h1234_F0F0;
            DataB = 32'hFF00_1222;
        #200 ALUSel = 4'b0110; 
            DataA = 32'hF0F0_A4A4;
            DataB = 32'd5;
        #200 ALUSel = 4'b0111;
            DataA = 32'hF0F0_A4A4;
            DataB = 32'd5;
        #200 ALUSel = 4'b1000;
            DataA = 32'h1234_F0F0;
            DataB = 32'hFF00_1222;
        #200 ALUSel = 4'b1001;
            DataA = 32'h1234_F0F0;
            DataB = 32'hFF00_1222;
        #200 ALUSel = 4'b1110;
            DataA = 32'h1234_F0F0;
            DataB = 32'hFF00_1222;
        #200 ALUSel = 4'b1111;
            DataA = 32'h1234_F0F0;
            DataB = 32'hFF00_1222;
    end
endmodule
