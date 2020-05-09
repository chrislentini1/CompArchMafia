module carry_lookahead_16bits(s, cout, a, b, cin);
	input [15:0] a,b;
	input cin;
	output [15:0] s;
	output cout;
	
	wire c1,c2,c3;
	 
	carry_lookahead_4bits cla1(s[3:0], c1, a[3:0], b[3:0], cin);
	carry_lookahead_4bits cla2(s[7:4], c2, a[7:4], b[7:4], c1);
	carry_lookahead_4bits cla3(s[11:8], c3, a[11:8], b[11:8], c2);
	carry_lookahead_4bits cla4(s[15:12], cout, a[15:12], b[15:12], c3);
 
endmodule 