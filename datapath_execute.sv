import definesPkg::*;

module datapath_execute
(
   clk,
   reset,
   ID_EX,
   EX_WB
);
   input clk;
   input reset;   
   
   input [ID_EX_WIDTH-1:0] ID_EX;
   output logic [EX_WB_WIDTH-1:0] EX_WB;
   
endmodule