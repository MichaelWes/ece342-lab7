import definesPkg::*;

module datapath_writeback
(
   clk,
   reset,
   EX_WB,
	i_ldst_rddata,
	RFWrite,
	dataw,
	regw
);
   input clk;
   input reset;   
   
   input [EX_WB_WIDTH-1:0] EX_WB;
   input [15:0] i_ldst_rddata;
	wire [15:0] instr;
	wire [15:0] ALUout;
	
	output logic RFWrite;
	output logic [15:0] dataw;
	output logic [2:0] regw;	
	
	assign {data1, data2, ALUout, instr} = EX_WB;
	wire [4:0] opcode = ALUout;
	
	always_comb begin
		RFWrite = 1'b0;
		case(opcode)
			// mv, add
			5'b0000x: begin
				RFWrite = 1'b1;
				dataw = ALUout;
				regw = instr[7:5];
			end
			// sub
			5'b00010: begin
				RFWrite = 1'b1;
				dataw = ALUout;
				regw = instr[7:5];
			end
			// TODO: cmp, st
			// ld
			5'b00100: begin
				RFWrite = 1'b1;
				dataw = i_ldst_rddata; // mem[[Ry]]
				regw = instr[7:5]; // [Rx] <- mem[[Ry]]
			end
			// TODO: addi, subi, cmpi, mvhi
			// TODO: Branching instructions
			default: begin
				RFWrite = 1'b0;
				dataw = 'x;
				regw = 'x;
			end
		endcase
	end
	
endmodule