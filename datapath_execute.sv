import definesPkg::*;

module datapath_execute
(
   clk,
   reset,
   ID_EX,
   EX_WB,
	ALUop,
	ALUop1,
	ALUop2,
	ALUout,
   o_ldst_addr,
   o_ldst_rd,
   o_ldst_wr,
   o_ldst_wrdata
);
   input clk;
   input reset;   
   
   input [ID_EX_WIDTH-1:0] ID_EX;
   output logic [EX_WB_WIDTH-1:0] EX_WB;
		
	// Reassign names to ID_EX sub ranges within this module
   wire [15:0] PC;
   wire [15:0] instr;
   wire [15:0] data1; //[Rx]
   wire [15:0] data2; //[Ry]
   wire [15:0] s_ext_imm8;
   wire [15:0] s_ext_imm11;

	assign {s_ext_imm8, s_ext_imm11, data1, data2, PC, instr} = ID_EX;
		
	// ALU
   output logic [2:0] ALUop;	
   output logic [15:0] ALUop1;
   output logic [15:0] ALUop2;
	input [15:0] ALUout;
	
	// ld/st signals 
	output logic [15:0] o_ldst_addr;
   output logic o_ldst_rd;
   output logic o_ldst_wr;
   output logic [15:0] o_ldst_wrdata;
	
	always_comb begin
		// opcode == ID_EX[4:0]
		casex(instr[4:0])
			// mv
			5'b00000: begin
				ALUop1 = '0;
				ALUop2 = data2;
			end
			// add
			5'b00001: begin
				ALUop1 = data1;
				ALUop2 = data2;
			end
			// sub, cmp
			5'b0001x: begin
				ALUop1 = data1;
				ALUop2 = data2;
			end
			// mvi
			5'b10000: begin
				ALUop1 = '0;
				ALUop2 = s_ext_imm8;
			end
			// addi
			5'b10001: begin
				ALUop1 = data1;
				ALUop2 = s_ext_imm8;
			end
			// subi, cmpi
			5'b1001x: begin
				ALUop1 = data1;
				ALUop2 = s_ext_imm8;
			end
			// TODO: ALU operands MUX for the rest of the instructions
			default: begin
				ALUop1 = 'x;
				ALUop2 = 'x;
			end
		endcase
	end

   always_comb begin
      // ALUop signal generated based on the instruction
      casex(instr) 
         // mv, add, mvi, addi
         5'bx000x: ALUop = 3'b000; 
         // sub, cmp, subi, cmpi
         5'bx001x: ALUop = 3'b001;
			// TODO: operations for other instructions
         default: ALUop = '0;
      endcase
   end
   
	always_ff @(posedge clk) begin
		if(reset) begin
			EX_WB <= '0;
		end else begin
			// TODO: writing BT to EX/WB 
			// TODO: other values as needed
			EX_WB <= {PC, ALUout, instr};
		end
	end
	
endmodule