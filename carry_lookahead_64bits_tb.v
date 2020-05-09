module carry_lookahead_64bits_tb;

	reg [63:0] a,b;
	
	reg cin;
	
	wire [63:0] s;
	
	wire cout;
	
	
	carry_lookahead_64bits uut(.a(a), .b(b), .cin(cin), .s(s), .cout(cout));
	
	
	initial begin
	
	#5 
	
	a = 64'd92233720368547758070;
	
	b = 64'd470;
	
	cin = 1'b0;
	
	
	#10
	
	cin = 1'b1;
	
	#20 $stop;
	
	end
	endmodule
	
	