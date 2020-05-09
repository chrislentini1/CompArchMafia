module mux2to1_64bit(F, S, I0, I1);

input [63:0] I0, I1;

input S;

output [63:0] F;

assign F = S ? I1 : I0;

endmodule
