module carry_lookahead_4bits_tb;

	reg [3:0] a,b;
	
	reg cin;
	
	wire [3:0] s;
	
	wire cout;
	
	
	carry_lookahead_4bits uut(.a(a), .b(b), .cin(cin), .s(s), .cout(cout));
	
	
	initial begin
	
	#5 
	
	
	a = 4'b0011;
	b = 4'b0100;
	
	cin = 4'b0;
	
	#5
	#20 $stop;
	
	
	end 
	endmodule
	