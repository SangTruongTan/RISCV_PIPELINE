module DFF_reg 
#(  parameter N = 128 )
(
    input   clk,
    input   rst,
    input   en,
    input   [N-1:0] D,
    output reg [N-1:0] Q 
);
initial begin
  Q = {N{1'b0}};
end
always@(posedge clk )
begin
  if(rst)
    Q <= {N{1'b0}};
  else 
    if (en)
    Q <= D;
end

endmodule
