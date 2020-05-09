module Shifter(A, shift_amount, left, right);
	input [63:0] A; // put word to be shifted on B bus
	input [5:0] shift_amount; // # of bits
	output [63:0] left, right;
	
	assign left = A << shift_amount;
	assign right = A >> shift_amount;

endmodule 