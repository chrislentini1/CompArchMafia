module ALU_LEGv8_tb;

	reg [63:0] A,B;
	
	reg [4:0] FS;
	
	reg Cin;
	
	wire [63:0] F;
	
	wire [3:0] status;
	
	
	ALU_LEGv8 uut(.A(A), .B(B), .FS(FS), .Cin(Cin), .F(F), .status(status));

	// FS0 - b invert
	// FS1 - a invert
	// FS4:2 - op. select
	// 000 - AND
	// 001 - OR
	// 010 - ADD
	// 011 - XOR
	// 100 - shift left
	// 101 - shift right
	// 110 - none / 0
	// 111 - none / 0
	
	initial begin
	{A, B, FS, Cin} = 0;
	
	#5
	
	A = 64'd7;
	
	B = 64'd2;
	
	Cin = 1'b0;

	
	FS = 5'b00000; //and, not inverting
	
	#10
	
	FS = 5'b00100; //or, not inverting
	
	#10
	
	FS = 5'b01000; //add, not inverting
	
	#10
	
	FS = 5'b01100; //xor, not inverting
	
	#10
	
	FS = 5'b10000; //shift left, not inverting
	
	#10
	
	FS = 5'b10100; //shift right, not inverting
	
	
	#10
	//FS = 5'b11101; //wrong
	//Cin = 1'b1;
	
	
	#100 $stop;
	
	end
	endmodule
	
	
	