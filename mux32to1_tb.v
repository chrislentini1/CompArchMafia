module mux32to1_tb;

reg [4:0] S; 

reg [63:0] I00, I01, I02, I03, I04, I05, I06, I07, I08, I09, I10, I11, I12, I13, I14, I15,
	I16, I17, I18, I19, I20, I21, I22, I23, I24, I25, I26, I27, I28, I29, I30, I31;
	
wire [63:0] F;

mux32to1 mux32to1(.S(S),.I00(I00), .I01(I01), .I02(I02), .I03(I03), .I04(I04), 
	.I05(I05), .I06(I06), .I07(I07), .I08(I08), .I09(I09), .I10(I10), .I11(I11), 
	.I12(I12), .I13(I13), .I14(I14), .I15(I15),
	.I16(I16), .I17(I17), .I18(I18), .I19(I19), .I20(I20), .I21(I21), .I22(I22), 
	.I23(I23), .I24(I24), .I25(I25), .I26(I26), .I27(I27), .I28(I28), .I29(I29), 
	.I30(I30), .I31(I31), .F(F));

initial begin
S[4:0] <= 5'b0;
I00[63:0] <= 0;
I01[63:0] <= 0;
I02[63:0] <= 0;
I03[63:0] <= 0;
I04[63:0] <= 0;
I05[63:0] <= 0;
I06[63:0] <= 0;
I07[63:0] <= 0;
I08[63:0] <= 0;
I09[63:0] <= 0;
I10[63:0] <= 0;
I11[63:0] <= 0;
I12[63:0] <= 0;
I13[63:0] <= 0;
I14[63:0] <= 0;
I15[63:0] <= 0;
I16[63:0] <= 0;
I17[63:0] <= 0;
I18[63:0] <= 0;
I19[63:0] <= 0;
I20[63:0] <= 0;
I21[63:0] <= 0;
I22[63:0] <= 0;
I23[63:0] <= 0;
I24[63:0] <= 0;
I25[63:0] <= 0;
I26[63:0] <= 0;
I27[63:0] <= 0;
I28[63:0] <= 0;
I29[63:0] <= 0;
I30[63:0] <= 0;
I31[63:0] <= 0;


I10[63:0] <= 64'd19;
I14[63:0] <= 64'd60;
I18[63:0] <= 64'd20;
I21[63:0] <= 64'd08;
I28[63:0] <= 64'd21;
I30[63:0] <= 64'd30;






#100 $stop;

end

always begin #5 S[0] = ~S[0]; end
always begin #10 S[1] = ~S[1]; end
always begin #20 S[2] = ~S[2]; end
always begin #40 S[3] = ~S[3]; end
always begin #80 S[4] = ~S[4]; end

endmodule