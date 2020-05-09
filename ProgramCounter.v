module ProgramCounter(PC_OUT, PC_IN, PS, reset, clock);

input reset, clock;

input [31:0] PC_IN;

input [1:0] PS;

//input [3:0] status;

//output reg [31:0] r0;

//wire [31:0] D;
output reg [31:0] PC_OUT;


//reg32 reg32(PC_OUT, r0, L, reset, clock);

//00 PC <- PC
//01 PC <- PC + 1
//10 PC <- Input
//11 PC <- PC + Input


always @(posedge clock or posedge reset) begin
		if(reset) PC_OUT <= 32'd0;
		else
			case(PS)
				2'b00: PC_OUT <= PC_OUT;
				2'b01: PC_OUT <= PC_OUT + 32'd1;
				2'b10: PC_OUT <= PC_IN;
				2'b11: PC_OUT <= PC_OUT + PC_IN;
				default: PC_OUT <= PC_OUT;
			endcase
		end
//mux4to1_32bit mux32(r0, PS, PC_OUT, PC_OUT+32'd1, PC_IN, PC_OUT+PC_IN);

endmodule






