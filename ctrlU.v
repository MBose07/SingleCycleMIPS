module ctrlU(
  input [5:0] opC, 
  input [5:0] fnc, 
  output reg [5:0] o,  //,[5]RegWrite, [4]RegDst, [3]ALUSrc, [2]Branch, [1]MemWrite, [0]MemtoReg
  output reg j ,
  output reg [2:0] aluC
);

always @(*) begin 
  // Defaults
  o = 6'b000000;
  aluC = 3'b000;
  
  if(opC == 6'b000000) begin  // R-type
    o = 6'b110000;  // RegWrite=1, RegDst=1
    j=0 ;
    case(fnc)
      6'b100000 : aluC = 3'b010 ;  // ADD
      6'b100010 : aluC = 3'b110 ;  // SUB
      6'b100100 : aluC = 3'b000 ;  // AND
      6'b100101 : aluC = 3'b001 ;  // OR
      6'b101010 : aluC = 3'b111 ;  // SLT
      default   : aluC = 3'b000 ;
    endcase 
  end
  else begin
    case(opC) 
      6'b000010 : begin 
      o =  6'b000000 ;
      aluC = 3'b000 ;
      j=1 ;
      end
      6'b100011 : begin  // lw
        o = 6'b101001 ;  // RegWrite=1, ALUSrc=1, MemtoReg=1
        aluC = 3'b010 ;
        j=0 ;
      end
      6'b101011 : begin  // sw
        o = 6'b001010 ;  // ALUSrc=1, MemWrite=1
        aluC = 3'b010 ;
        j=0 ;
      end
      6'b000100 : begin  // beq
        o = 6'b000100 ;  // Branch=1
        aluC = 3'b110 ;  // SUB for comparison
        j=0 ;
      end
      6'b001000 : begin 
       o = 6'b101000 ;
       aluC= 3'b010 ; 
       j=0 ;
       end
      default : begin 
        o = 6'b000000;
        aluC = 3'b000;
        j=0 ;
      end
    endcase
  end
end

endmodule
