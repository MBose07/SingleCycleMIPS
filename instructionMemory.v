`timescale 1ns / 1ps

module instructionMemory(
  input  [31:0] adr,
  output reg [31:0] op
);

  reg [31:0] memory [0:1023];  

  initial begin
    $readmemh("instructions.mem", memory);  
    end

  always @(*) begin
    op = memory[adr[11:2]];  
  end

endmodule
