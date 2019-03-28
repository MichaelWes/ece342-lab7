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
   ID_EX
);
   input clk;
   input reset;
   
   input          [IF_ID_WIDTH-1:0] IF_ID;
   output logic   [ID_EX_WIDTH-1:0] ID_EX;   
   
   wire [15:0] PC = IF_ID[31:16];
   wire [15:0] instr = IF_ID[15:0];
   
   output logic [2:0] Rx;
   output logic [2:0] Ry;
   
   input [15:0] data1; //[Rx]
   input [15:0] data2; //[Ry]
   
   logic [15:0] s_ext_imm8;
   logic [15:0] s_ext_imm11;
	   
   always_comb begin
      // TODO: Decoding logic for Rx based on instruction
      // This holds for everything except imm11 instructions
      Rx = instr[7:5];
   end
   
   always_comb begin
      // TODO: Decoding logic for Ry based on instruction
      // This holds for mv, add, sub, cmp, ld, st
      Ry = instr[10:8];
   end
   
   always_comb begin
      // For mvi, addi, subi, cmpi
      s_ext_imm8 = {{8{instr[15]}}, instr[15:8]};
   end
   
   always_comb begin
      // For j, jz, jn, call
      s_ext_imm11 = {{8{instr[15]}}, instr[15:5]};
   end
   
   always_ff @(posedge clk) begin
      if(reset) begin
         ID_EX <= '0;   
      end else begin
         // TODO: Other information to pass along?
         ID_EX <= {s_ext_imm8, s_ext_imm11, data1, data2, PC, instr};  
      end
   end
endmodule
