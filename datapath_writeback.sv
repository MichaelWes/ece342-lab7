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
	wire ex_valid;

	output logic RFWrite;
	output logic [15:0] dataw;
	output logic [2:0] regw;	
	
	assign {ex_valid, data1, data2, ALUout, instr} = EX_WB;
	wire [4:0] opcode = instr[4:0];
	
	logic wb_valid;

   always_ff @(posedge clk) begin
   	if(reset) 
   		wb_valid <= '0;
   	else begin
   		wb_valid <= ex_valid;
   	end
   end

	always_comb begin
		RFWrite = 1'b0;
		if(wb_valid) begin
			casex(opcode)
				// mv, add, sub, mvi, addi, sub, mvhi
				5'b0000x, 5'b00010, 5'b1000x, 5'b10010, 5'b10110: begin
					RFWrite = 1'b1;
					dataw = ALUout;
					regw = instr[7:5];
				end
				// ld
				/*
				5'b00100: begin
					RFWrite = 1'b1;
					dataw = i_ldst_rddata; // mem[[Ry]]
					regw = instr[7:5]; // [Rx] <- mem[[Ry]]
				end
				*/
				// TODO: st
				// TODO: Branch instructions
				
				// cmp, cmpi: do not write back to RF
				default: begin
					RFWrite = 1'b0;
					dataw = 'x;
					regw = 'x;
				end
			endcase
		end else begin
			RFWrite = 1'b0;
			dataw = 'x;
			regw = 'x;
		end
	end
	
endmodule