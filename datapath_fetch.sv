import definesPkg::*;

module datapath_fetch
(
   clk,
   reset,
   BT,
   i_pc_rddata,
   IF_ID,
   PC,
	taken,
	f_valid
);
   input clk;
   input reset;
   input [15:0] BT;
	input taken;
   input [15:0] i_pc_rddata;
	output logic f_valid = '1;
	
   // Program Counter
   output logic [15:0] PC;
   
   // Instruction Fetch / (Instruction Decode == RF Read) Pipeline Register.
   // Parametrized width, since data written to the pipeline register is 
   // whatever is needed as input to the next stage.
   output logic [IF_ID_WIDTH-1:0] IF_ID;
   
	wire [15:0] PC_input = (taken == 1'b1) ? (BT) : (PC + 16'd2); 
	
   always_ff @(posedge clk or posedge reset) begin
      if(reset) begin
         PC <= '0;
         IF_ID <= '0;
      end else begin
         PC <= PC_input;
         IF_ID[31:16] <= PC_input;
         IF_ID[15:0] <= '0;
      end
   end
   
endmodule
