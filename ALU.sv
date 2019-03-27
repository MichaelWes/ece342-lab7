module ALU(
   ALUop,
   ALUop1,
   ALUop2,
   o_N,
   o_Z,
   ALUout
);
   input [2:0] ALUop;
   input [15:0] ALUop1;
   input [15:0] ALUop2;
   output logic o_N;
   output logic o_Z;

   output logic [15:0] ALUout;
   
   assign o_Z = ~|{ALUout};
   assign o_N = ALUout[15];
   
   always_comb begin
      case(ALUop)
         'b000: ALUout = ALUop1 + ALUop2;
         'b001: ALUout = ALUop1 - ALUop2;
         'b010: ALUout = ALUop1 + (ALUop2 << 1);               // for j, jz, jn, call
         'b011: ALUout = ALUop1;                               // for jr, jzr, jnr, callr
         'b100: ALUout = (ALUop2 << 8) | {8'b0, ALUop1[7:0]}; // for mvhi
         default: ALUout = '0;
      endcase
   end

endmodule