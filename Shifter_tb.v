module Shifter_tb;

	reg [63:0] A;
	
	reg [5:0] shift_amount;
	
	wire [63:0] left, right;
	
	
	Shifter uut(.A(A), .shift_amount(shift_amount), .left(left), .right(right));
	
	initial begin
	
	
	#5 
	
	A = 64'd55;
	
	shift_amount = 6'd5;
	
	
	#20 $stop;
	
	end
	
	endmodule
	