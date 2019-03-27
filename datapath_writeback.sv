import definesPkg::*;

module datapath_writeback
(
   clk,
   reset,
   EX_WB
);
   input clk;
   input reset;   
   
   input [EX_WB_WIDTH-1:0] EX_WB;
   
endmodule