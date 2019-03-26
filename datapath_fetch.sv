module datapath_fetch
(
	clk,
	reset,
	BT,
	PCsrc,
	PCwrite
);
	input clk;
	input reset;
	input [15:0] BT;
	input PCsrc;
	input PCwrite;

	parameter IF_ID_WIDTH = 16;

   // Program Counter
   logic [15:0] PC;
	
	// Instruction Fetch / (Instruction Decode == RF Read) Pipeline Register.
	// Parametrized width, since whaat we stuff in the pipeline register is just whatever we determine is needed as input
	// to the next stage.
	logic [IF_ID_WIDTH-1:0] IF_ID;
	
	wire [15:0] PC_in = (PCsrc)? PC + 2 : BT;
	
	always_ff @(posedge clk) begin
		if(reset) begin
			PC <= '0;
			IF_ID <= '0;
		end else begin
			if(PCwrite) begin
				PC <= PC_in;				
			end
			IF_ID[15:0] <= PC + 2;
		end
	end
	
endmodule
