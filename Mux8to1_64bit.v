module Mux8to1_64bit(F, S, I0, I1, I2, I3, I4, I5, I6, I7);

	input [63:0]I0, I1, I2, I3, I4, I5, I6, I7;
	input [2:0]S;
	output [63:0]F;
	
	assign F = S[2] ? (S[1] ? (S[0] ? I7 : I6) : (S[0] ? I5 : I4)) : (S[1] ? (S[0] ? I3 : I2) : (S[0] ? I1 : I0));

endmodule 