module RegisterFile32x64_tb;

wire [63:0] A, B;

reg [4:0] SA, SB, DA;

reg [63:0] D;

reg W, reset, clock;

wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7;


RegisterFile32x64 uut(.A(A),.B(B),.SA(SA),.SB(SB),.DA(DA),.D(D),.W(W),.reset(reset),.clock(clock),.r0(r0),.r1(r1),.r2(r2),.r3(r3),.r4(r4),.r5(r5),.r6(r6),.r7(r7));

initial begin
{SA, SB, DA, D, W, clock} = 0;

reset = 1'b1;

#15
reset = 1'b0;
DA = 5'd4;


W = 1'b1;
D = 64'd18;

#5 //clock rises
	
	
#5 //clock falls
DA =5'd6; 
D = 64'd100;
#5 
	

#5 
SA = 5'd4;
SB = 5'd6;

#50 $stop;


end

always begin #5 clock <= ~clock; end


endmodule
