`timescale 1ns / 1ps

module main (
    input clk,
    output [31:0] inst,
    output [31:0] aluO,
    output [31:0] pc,
    output [31:0] src1,
    output [31:0] src2
);
  reg [31:0] prC = 0;
  wire branch;
  wire [31:0] instr;
  wire [5:0] ctrlSig;
  wire [2:0] aluOp;
  wire [31:0] srcA, srcB, temp, temp1;
  wire [4:0] a3;
  wire [31:0] result;
  wire [31:0] signEx;
  wire [31:0] aluRes;
  wire z;
  wire j;
  wire pcj;

  assign signEx = {{16{instr[15]}}, instr[15:0]};
  assign pcj = {{6{instr[25]}}, instr[25:0]};
  assign branch = ctrlSig[2];
  always @(posedge clk) begin
    if (!j) prC <= branch ? (signEx << 2) + prC + 4 : prC + 4;
    else prC <= (pcj << 2) + 4;
  end


  instructionMemory m1 (
      .adr(prC),
      .op (instr)
  );

  ctrlU m2 (
      .opC(instr[31:26]),
      .fnc(instr[5:0]),
      .o(ctrlSig),
      .j(j),
      .aluC(aluOp)
  );


  assign a3 = ctrlSig[4] ? instr[15:11] : instr[20:16];

  registerSet m3 (
      .clk (clk),
      .adr1(instr[25:21]),
      .adr2(instr[20:16]),
      .adr3(a3),
      .word(result),
      .wEn (ctrlSig[5]),
      .r1  (srcA),
      .r2  (temp)
  );

  assign srcB = ctrlSig[3] ? signEx : temp;

  alu m4 (
      .A(srcA),
      .B(srcB),
      .aluC(aluOp),
      .zero(z),
      .res(aluRes)
  );

  dataMem m5 (
      .clk(clk),
      .adr(aluRes),
      .word(temp),
      .wEn(ctrlSig[1]),
      .o(temp1)
  );


  assign result = ctrlSig[0] ? temp1 : aluRes;

  assign aluO = result;
  assign inst = instr;
  assign pc = prC;
  assign src1 = srcA;
  assign src2 = srcB;
endmodule
