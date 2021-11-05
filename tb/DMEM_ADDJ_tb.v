module DMEM_ADDJ_tb;
    parameter WIDTH_DATA_LENGTH = 32;
    parameter LENGTH_MUX = 3;
    reg [WIDTH_DATA_LENGTH -1:0] DataIn;
    reg [LENGTH_MUX -1:0] FormatSel;
    wire [WIDTH_DATA_LENGTH -1:0] DataOut;

    DMEM_ADDJ dmem_addj1    (.DataIn(DataIn),
                             .FormatSel(FormatSel),
                             .DataOut(DataOut));

    initial begin
        //Test with Unsigned case
        #0  DataIn = 32'h1234_5678;
            FormatSel = 3'b000; //Extend signed byte
        #5  DataIn = 32'h0123_8765;
        #10 FormatSel = 3'b001; //Extend signed half word
        #10 FormatSel = 3'b011; //Extend unsigned byte
        #10 FormatSel = 3'b100; //Extend unsigned half word
        #10 FormatSel = 3'b010; //Forward word

        //Test with Signed value Case
        #40  DataIn = 32'h0122_E68F;
            FormatSel = 3'b000; //Extend signed byte
        #10 FormatSel = 3'b001; //Extend signed half word
        #10 FormatSel = 3'b011; //Extend unsigned byte
        #10 FormatSel = 3'b100; //Extend unsigned half word
        #10 FormatSel = 3'b010; //Forward word
    end
endmodule
