module mux32to1(F, S, I00, I01, I02, I03, I04, I05, I06, I07, I08, I09, I10, I11, I12,
I13, I14, I15, I16, I17, I18, I19, I20, I21, I22, I23, I24, I25, I26, I27, I28, I29, I30, I31);

	output reg [63:0]F; // output
	input [4:0]S; // select
	input [63:0]I00, I01, I02, I03, I04, I05, I06, I07, I08, I09, I10, I11, I12, I13, I14, I15,
	I16, I17, I18, I19, I20, I21, I22, I23, I24, I25, I26, I27, I28, I29, I30, I31;

	always @(*) begin
		case(S)
			5'd00: F <= I00;
			5'd01: F <= I01;
			5'd02: F <= I02;
			5'd03: F <= I03;
			5'd04: F <= I04;
			5'd05: F <= I05;
			5'd06: F <= I06;
			5'd07: F <= I07;
			5'd08: F <= I08;
			5'd09: F <= I09;
			5'd10: F <= I10;
			5'd11: F <= I11;
			5'd12: F <= I12;
			5'd13: F <= I13;
			5'd14: F <= I14;
			5'd15: F <= I15;
			5'd16: F <= I16;
			5'd17: F <= I17;
			5'd18: F <= I18;
			5'd19: F <= I19;
			5'd20: F <= I20;
			5'd21: F <= I21;
			5'd22: F <= I22;
			5'd23: F <= I23;
			5'd24: F <= I24;
			5'd25: F <= I25;
			5'd26: F <= I26;
			5'd27: F <= I27;
			5'd28: F <= I28;
			5'd29: F <= I29;
			5'd30: F <= I30;
			5'd31: F <= I31;
			default: F <= I00; 
		endcase
	end

endmodule
