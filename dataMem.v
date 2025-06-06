`timescale 1ns / 1ps

module dataMem(
input clk , 
input[31:0] adr , 
input[31:0]word ,
input wEn,
output  [31:0]o
 );
 reg [31:0] memory [0:1023] ;
 reg[31:0] out;
 integer i;
 initial begin
  for (i = 0; i < 1024; i = i + 1)
    memory[i] = 32'b0;
end
 always @(posedge clk) begin
 out <= memory[adr[11:2]];
  if(wEn) memory[adr[11:2]] <= word ;
 end
 assign  o = out ; 
 
endmodule
