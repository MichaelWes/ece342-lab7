import definesPkg::*;

module datapath_fetch
(
   clk,
   reset,
   BT,
   PCsrc,
   PCwrite,
   i_pc_rddata,
   IF_ID,
   PC
);
   input clk;
   input reset;
   input [15:0] BT;
   input PCsrc;
   input PCwrite;
   input [15:0] i_pc_rddata;

   // Program Counter
   output logic [15:0] PC;
   
   // Instruction Fetch / (Instruction Decode == RF Read) Pipeline Register.
   // Parametrized width, since data written to the pipeline register is 
   // whatever is needed as input to the next stage.
   output logic [IF_ID_WIDTH-1:0] IF_ID;
   
   logic f_valid;

   always_ff @(posedge clk) begin
      if(reset) 
         f_valid <= '0;
      else begin 
         f_valid <= '1;
      end
   end

   // Technically for Part I, this is always just PC + 2.
   //wire [15:0] PC_in = (PCsrc)? PC + 16'd2 : BT;
   
   always_ff @(posedge clk) begin
      if(reset) begin
         PC <= '0;
         IF_ID <= '0;
      end else begin
         if(PCwrite) begin
            PC <= PC + 16'd2;            
         end
         IF_ID[32] <= f_valid;
         IF_ID[31:16] <= PC + 16'd2;
         IF_ID[15:0] <= i_pc_rddata;
      end
   end
   
endmodule
