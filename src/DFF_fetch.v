module DFF_fetch 
#(  parameter N = 64 )
(
    input   clk,
    input   rst,
    input   en,
    input   [N-1:0] D,
    output reg [N-1:0] Q 
);
initial begin
  Q = {{32{1'b0}}, -32'd4};
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
