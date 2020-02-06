module decoder5to32_tb;

	reg [4:0]S;

	wire [31:0]m;

	decoder5to32 uut (.S (S), .m (m));
	
	
	initial begin
		S <= 5'b0;
		#640 $finish;
	end
	
	
	always begin
		#10 S[0] <= ~S[0];
	end
	
	always begin
		#20 S[1] <= ~S[1];
	end
	
	always begin
		#40 S[2] <= ~S[2];
	end
	
	always begin
		#80 S[3] <= ~S[3];
	end
	
	always begin
		#160 S[4] <= ~S[4];
	end
	
endmodule
