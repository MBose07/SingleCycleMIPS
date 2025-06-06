`timescale 1ns / 1ps


module registerSet(
input clk , 
input [4:0] adr1,
input [4:0] adr2,
input [4:0] adr3,
input[31:0] word , 
input wEn,
output reg [31:0] r1 ,
output reg [31:0] r2
);
 reg [31:0] mem [0:31];
  integer i;
 initial begin
  for (i = 0; i < 32; i = i + 1)
    mem[i] = 32'b0;
end
always @(*) begin 
r1 = mem [adr1];
r2 = mem [adr2];
end
always @(posedge clk) begin
if(wEn && adr3 != 0)
mem[adr3]<= word ;
end


endmodule
