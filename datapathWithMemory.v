module datapathWithMemory(k,D,selbork, SA, SB, FS, Cin, clock, DA, status, W, reset, triSelBtoD, triSelFtoD, triSelFtoA, triSelOuttoD, writeEn, readEn, r0, r1, r2, r3, r4, r5, r6, r7);


input clock, writeEn, readEn, selbork, W, reset, Cin, triSelBtoD, triSelFtoD, triSelFtoA, triSelOuttoD;

input [63:0] k;

inout [63:0] D;

input [4:0] FS, SA, SB, DA;

output [3:0] status;

output [15:0] r0, r1, r2, r3, r4, r5, r6, r7;

wire [63:0] memOut;

wire [63:0] A,B,F,muxOut;
wire [31:0] P; //wire after tristate buffer to address

RegisterFile32x64 regFile(A, B, SA, SB, D, DA, W, reset, clock, r0, r1, r2, r3, r4, r5, r6, r7);

LEGv8_RAM RAM(P, clock, D, writeEn, memOut, readEn);

ALU_LEGv8 alu(A, muxOut, FS, Cin, F, status);

assign muxOut = selbork ? k : B;
assign D = triSelBtoD ? B : 64'bz;
assign P = triSelFtoA ? F[7:0] : 8'bz;
assign D = triSelFtoD ? F : 64'bz;
assign D = triSelOuttoD ? memOut : 64'bz;


endmodule







