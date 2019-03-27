import definesPkg::*;

module datapath_RF_Read
(
   clk,
   reset,
   Rx,
   Ry,
   data1,
   data2,
   IF_ID,
   ID_EX,
   ALUop
);
   input clk;
   input reset;
   
   input          [IF_ID_WIDTH-1:0] IF_ID;
   output logic   [ID_EX_WIDTH-1:0] ID_EX;   
   
   wire [15:0] PC = IF_ID[15:0];
   wire [15:0] instr = IF_ID[31:16];
   
   output logic [2:0] Rx;
   output logic [2:0] Ry;
   
   input [15:0] data1; //[Rx]
   input [15:0] data2; //[Ry]
   
   logic [15:0] s_ext_imm8;
   logic [15:0] s_ext_imm11;
   
   output logic [2:0] ALUop;
   
   always_comb begin
      // TODO: Decoding logic for Rx based on instruction
      // This holds for everything except imm11 instructions
      Rx = IF_ID[7:5];
   end
   
   always_comb begin
      // TODO: Decoding logic for Ry based on instruction
      // This holds for mv, add, sub, cmp, ld, st
      Ry = IF_ID[10:8];
   end
   
   always_comb begin
      // For mvi, addi, subi, cmpi
      s_ext_imm8 = {{8{IF_ID[15]}}, IF_ID[15:8]};
   end
   
   always_comb begin
      // For j, jz, jn, call
      s_ext_imm11 = {{8{IF_ID[15]}}, IF_ID[15:8]};
   end
   
   always_comb begin
      // ALUop signal generated based on the instruction
      casex(instr) 
         // mv, add, mvi, addi
         5'bx000x: ALUop = 3'b000; 
         // sub, cmp, subi, cmpi
         5'bx001x: ALUop = 3'b001;
         default: ALUop = '0;
      endcase
   end
   
   
   always_ff @(posedge clk) begin
      if(reset) begin
         ID_EX <= '0;   
      end else begin
         // TODO: Other information to pass along?
         ID_EX <= {ALUop, s_ext_imm8, s_ext_imm11, data1, data2, PC, instr};  
      end
   end
endmodule
