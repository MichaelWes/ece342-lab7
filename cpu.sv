//`include "definesPkg.sv"
import definesPkg::*;

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

	// Instruction Fetch interface
	wire [15:0] PC;
	wire [15:0] BT = '0;
	wire PCsrc = '0;
	wire PCwrite = '1;
	wire [IF_ID_WIDTH-1:0] IF_ID;
	
	datapath_fetch f0(.*);
	assign o_pc_rd = '1;
	assign o_pc_addr = PC;
	
	// Register File interface
	wire [15:0] data1;
	wire [15:0] data2;
	wire [15:0] dataw;
	wire [2:0] reg1; 
   wire [2:0] reg2; 
   wire [2:0] regw; 
   wire RFWrite;
	
	RF rf0(.*);
	
	// Instruction Decode interface
	wire [ID_EX_WIDTH-1:0] ID_EX;
	wire [2:0] Rx;
	wire [2:0] Ry;
	assign reg1 = Rx;
	assign reg2 = Ry;
	datapath_RF_Read r0(.*);
	

endmodule

