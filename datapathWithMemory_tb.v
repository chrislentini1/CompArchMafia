module datapathWithMemory_tb;



reg clock, writeEn, readEn, selbork, W, reset, Cin, triSelBtoD, triSelFtoD, triSelFtoA, triSelOuttoD;

reg [63:0] k;

reg [4:0] FS, SA, SB, DA;

wire [3:0] status;

wire [63:0] D;

wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7;


datapathWithMemory mem(.k(k),.D(D),.selbork(selbork), .SA(SA), .SB(SB), .FS(FS), .Cin(Cin), .clock(clock), .DA(DA), .status(status), .W(W), .reset(reset), .triSelBtoD(triSelBtoD), .triSelFtoD(triSelFtoD), .triSelFtoA(triSelFtoA), .triSelOuttoD(triSelOuttoD), .writeEn(writeEn), .readEn(readEn), .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7));


initial begin

{clock, writeEn, readEn, selbork, W, 
reset, Cin, triSelBtoD, triSelFtoD, triSelFtoA, triSelOuttoD} = 0;

reset = 1'b1;
k <= 64'd0;
SA <= 5'd0;
SB <= 5'd0;
DA <= 5'd0;


#5 //clock falls
k <= 64'd7;
SA <= 5'd31;
FS <= 5'b00100; //or k,SA
triSelFtoD <= 1'b1;
reset <= 1'b0;
W <= 1'b1;
selbork <= 1'b1;
DA<=5'd3;

#5 //clock rises


#5 //clock falls
SB <=5'd3;
triSelBtoD <= 1'b1;
triSelFtoD <= 1'b0;
triSelFtoA <= 1'b1;
triSelOuttoD <= 1'b0;
W <= 1'b0;
writeEn <= 1'b1;
selbork <= 1'b0;

k <= 64'd8;
FS <= 5'b00100;
#5 //clock rises


#5 //clock falls
triSelBtoD <= 1'b0;
triSelOuttoD <=1'b1;
triSelFtoA <= 1'b1;
triSelFtoD <= 1'b0;
writeEn <= 1'b0;
readEn <= 1'b1;
DA <= 5'd2;
#5 //clock rises

#5 //clock falls

#5 //clock rises

#100 $stop;
end
always begin #5 clock = ~clock; end
endmodule






