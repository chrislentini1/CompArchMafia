module datapath_tb;

reg [63:0] k;

wire [63:0] D;

reg [4:0] FS, SA, SB, DA;

reg selbork, W, reset, clock, Cin, triSelBtoD, triSelFtoD;

wire [3:0] status;
wire[63:0] r0,r1,r2,r3;

datapath uut(.k(k),.D(D),.selbork(selbork),.SA(SA),.SB(SB),.FS(FS),.Cin(Cin),.clock(clock),.DA(DA),.status(status),.W(W),.reset(reset), .triSelBtoD(triSelBtoD), .triSelFtoD(triSelFtoD),.r0(r0),.r1(r1),.r2(r2),.r3(r3));


initial begin

{k,FS,SA,SB,DA,selbork,W,reset,clock,Cin,triSelBtoD,triSelFtoD} = 0;
#1 W <= 1'b1;
#5 selbork <= 1'b1;
#5 SA <= 5'd31;

#5 k <= 64'd7;
#5 FS <= 5'b00100;
#5 triSelFtoD <= 1'b1;
#1 DA <= 5'd18;
#5 DA <= 5'dz;
#5 triSelFtoD <= 1'b0;

#5 k <= 64'd2;
#5 FS <= 5'b00100;
#5 triSelFtoD <= 1'b1;
#1 DA <= 5'd19;
#5 DA <= 5'dz;
#5 triSelFtoD <= 1'b0;

#5 k <= 64'd13;
#5 FS <= 5'b00100;
#5 triSelFtoD <= 1'b1;
#1 DA <= 5'd20;
#5 DA <= 5'dz;
#5 triSelFtoD <= 1'b0;

#5 k <= 64'd21;
#5 FS <= 5'b00100;
#5 triSelFtoD <= 1'b1;
#1 DA <= 5'd21;
#5 DA <= 5'dz;
#5 triSelFtoD <= 1'b0;

#5 selbork <= 0;

#1 SA <= 5'd21;
 SB <= 5'd18;
#5 FS <= 5'b01100;
#5 triSelFtoD <= 1'b1;
#1 DA <= 5'd0;
#5 DA <= 5'dz;
#5 triSelFtoD <= 1'b0;

#1 SA <= 5'd18;
 SB <= 5'd20;
#5 FS <= 5'b01000;
#5 triSelFtoD <= 1'b1;
#1 DA <= 5'd1;
#5 DA <= 5'dz;
#5 triSelFtoD <= 1'b0;

#1 SA <= 5'd19;
 SB <= 5'd21;
#5 FS <= 5'b00100;
#5 triSelFtoD <= 1'b1;
#1 DA <= 5'd2;
#5 DA <= 5'dz;
#5 triSelFtoD <= 1'b0;

#1 k <= 64'd3;
selbork <= 1'b1;
#1 SA <= 5'd18;
 //SB <= 5'd3;
#5 FS <= 5'b10100;
#5 triSelFtoD <= 1'b1;
#1 DA <= 5'd3;
#5 DA <= 5'dz;
#5 triSelFtoD <= 1'b0;
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
	
	
#100 $stop;

end

always begin #1 clock <= ~clock; end

endmodule
