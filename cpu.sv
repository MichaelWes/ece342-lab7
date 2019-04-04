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
   wire [15:0] BT;
   wire [IF_ID_WIDTH-1:0] IF_ID;
	wire taken;
   datapath_fetch f0(.*);
   
   // See: Patterson & Hennessy HW/SW:I 5ed, p 300.
   assign o_pc_rd = '1;
   assign o_pc_addr = PC;
   
   // Register File interface
   wire [15:0] data1;
   wire [15:0] data2;
   wire [15:0] dataw;
   wire [2:0] reg1; 
   wire [2:0] reg2; 
   wire [2:0] regw; 
	wire [7:0][15:0] regs;
   wire RFWrite;
   RF rf0(.*);
   assign o_tb_regs = regs;
	
   // Instruction Decode interface
   wire [ID_EX_WIDTH-1:0] ID_EX;
   wire [2:0] Rx;
   wire [2:0] Ry;
   assign reg1 = Rx;
   assign reg2 = Ry;
   datapath_RF_Read r0(.*);
   
   // Execute interface
   wire [EX_WB_WIDTH-1:0] EX_WB;
   // TODO: implement
   datapath_execute ex0(.*);
   
   // Main ALU interface
   wire [2:0] ALUop;
   wire [15:0] ALUop1;
   wire [15:0] ALUop2;
   wire logic o_N;
   wire logic o_Z;
	wire N, Z, update_flags;
   wire [15:0] ALUout;  
   ALU a0(.*);
      
   // Writeback interface
   // TODO: implement
   datapath_writeback wb0(.*);
   
endmodule

