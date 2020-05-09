module carry_lookahead_16bits_tb;

	reg [15:0] a,b;
	
	reg cin;
	
	wire [15:0] s;
	
	wire cout;
	
	
	carry_lookahead_16bits uut(.a(a), .b(b), .cin(cin), .s(s), .cout(cout));
	
	
	
	
	initial begin
	
	#5
	
	
	a = 16'd55;
	
	b = 16'd65;
	
	cin = 1'b0;
	
	
	
	#5 
	
	cin = 1'b1;
	
	#20 $stop;
	
	
	
	end
	endmodule
	
	
	
	