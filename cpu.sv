module cpu
(
	input clk,
	input reset,
	
	output [15:0] o_pc_addr,
	output o_pc_rd,
	input [15:0] i_pc_rddata,
	
	output [15:0] o_ldst_addr,
	output o_ldst_rd,
	output o_ldst_wr,
	input [15:0] i_ldst_rddata,
	output [15:0] o_ldst_wrdata,
	
	output [7:0][15:0] o_tb_regs
);

	datapath_fetch f0(
		.clk(clk), 
		.reset(reset), 
		.BT('x), 
		.PCsrc('0), 
		.PCwrite('1), 
		.i_instruction(i_pc_rddata), 
		.PC(o_pc_addr)
	);
	assign o_pc_rd = '1;


endmodule

