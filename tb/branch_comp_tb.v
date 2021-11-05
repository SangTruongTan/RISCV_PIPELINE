module branch_comp_tb;
wire BrEq;
wire BrLT;
reg BrUn;
reg [31:0] A;
reg [31:0] B;

branch_comp branch_comp (.BrEq(BrEq),
                        .BrLT(BrLT),
                        .BrUn(BrUn),
                        .A(A),
                        .B(B));
initial begin
    #0 BrUn = 1'b0; //Sign compare
        A = 32'd100;
        B = 32'd5000;
    #50 A = -32'd5000;
        B = -32'd5001;
    #50 A = -32'd1234;
        B = -32'd1234;
    #200 BrUn = 1'b1; //UnSign compare
        A = 32'd100;
        B = 32'd5000;
    #50 A = -32'd5000;
        B = -32'd5001;
    #50 A = -32'd1234;
        B = -32'd1234;
end
endmodule