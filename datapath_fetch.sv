module datapath_fetch
(
	clk,
	reset,
	BT,
	PCsrc,
	PCwrite,
	i_instruction
);
	input clk;
	input reset;
	input [15:0] BT;
	input PCsrc;
	input PCwrite;
	input [15:0] i_instruction;
	
	parameter IF_ID_WIDTH = 32;

   // Program Counter
   output logic [15:0] PC;
	
	// Instruction Fetch / (Instruction Decode == RF Read) Pipeline Register.
	// Parametrized width, since whaat we stuff in the pipeline register is just whatever we determine is needed as input
	// to the next stage.
	output logic [IF_ID_WIDTH-1:0] IF_ID;
	
	
	// Technically for Part I, this is always just PC + 2.
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
			IF_ID[31:16] <= i_instruction;
		end
	end
	
endmodule
