module carry_lookahead_64bits(s, cout, a, b, cin);
	input [63:0] a, b;
	input cin;
	output [63:0] s;
	output cout;
	
	wire c1,c2,c3;
	
	carry_lookahead_16bits cla1(s[15:0], c1, a[15:0], b[15:0], cin);
	carry_lookahead_16bits cla2(s[31:16], c2, a[31:16], b[31:16], c1);
	carry_lookahead_16bits cla3(s[47:32], c3, a[47:32], b[47:32], c2);
	carry_lookahead_16bits cla4(s[63:48], cout, a[63:48], b[63:48], c3);
	
endmodule 