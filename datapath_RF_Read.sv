module datapath_RF_Read
(
	clk,
	reset,
	RFrd_EX,
	RF,
	PC,
	instr
);
	// TODO: Determine the right width once design is done
	parameter RFrd_EX_WIDTH = 64;
	
	input clk;
	input reset;
	input [15:0] PC;
	input [15:0] instr;
	
	
	output logic [RFrd_EX_WIDTH-1:0] RFrd_EX;

	// TODO: this should be instantiated in the top level module.
	// TOOD: this should come in to this module in the form of the regfile output
	// TODO: this module should export just the RF inputs: Rx, Ry,... 
	// RFwrite is never asserted in this stage so don't worry about it
	
	output logic [7:0][15:0] RF;
	
	wire [2:0] Rx;
	wire [2:0] Ry;
	
	always_comb begin
		// TODO: Decoding logic for Rx based on instruction	
	end
	
	always_comb begin
		// TODO: Decoding logic for Ry based on instruction	
	end
	
	always_ff @(posedge clk) begin
		if(reset) begin
			RFrd_EX <= '0;	
		end else begin
			// TODO: change saved RF output once decoding logic is implemented
			// TODO: should we pass along the entire instr, or only decoded information?
			// e.g. i type, r type, j type
			// e.g. if it's i-type, stuff in the immediate
			// ... 
			RFrd_EX <= {RF[3'b0], 16'bx, PC, instr};	
		end
	end
endmodule
