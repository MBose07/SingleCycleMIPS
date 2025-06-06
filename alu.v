`timescale 1ns / 1ps

module alu(
input [31:0] A ,
input [31:0] B ,
input [2:0] aluC ,
output  reg zero ,
output  reg [31:0]res
 );
 reg z ;
 reg [31:0] r ;
 always @(*) begin
 case (aluC) 
 3'b010: r = A+B ;
 3'b110: r = A-B ;
 3'b000: r = A&B;
 3'b001 : r= A|B;
 3'b111 : r = ($signed(A)<$signed(B)) ? 32'b1:32'b0 ;
 default: r = 32'b0;
 endcase
 z = (r ==0) ? 1 : 0 ;
 end
 always @(*)begin
 assign zero = z ;
 assign res  = r;
 end
endmodule
