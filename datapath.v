module datapath(k,D,selbork,SA,SB,FS,Cin,clock,DA,status,W,reset, triSelBtoD, triSelFtoD,r0,r1,r2,r3,r4,r5,r6,r7);


input [63:0] k;

inout [63:0] D;

input [4:0] FS, SA, SB, DA;

input selbork, W, reset, clock, Cin, triSelBtoD, triSelFtoD;


output [3:0] status;

wire [63:0] A,B;

wire [63:0] F;

output[63:0] r0, r1, r2, r3, r4, r5, r6, r7;

RegisterFile32x64 REGFILETest(A,B,SA,SB,D,DA,W,reset,clock,r0,r1,r2,r3,r4,r5,r6,r7);

wire [63:0] muxOut;

assign muxOut = selbork ? k : B;

assign D = triSelBtoD ? B : 64'bz;
assign D = triSelFtoD ? F : 64'bz;

ALU_LEGv8 ALU_LEGv8Test(A, muxOut, FS, Cin, F, status);

endmodule





