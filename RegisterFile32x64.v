module RegisterFile32x64(A, B, SA, SB, D, DA, W, reset, clock, r0, r1, r2, r3, r4, r5, r6, r7);

	output [63:0]A; // A bus
	output [63:0]B; // B bus
	input [4:0]SA; // Select A - A Address
	input [4:0]SB; // Select B - B Address
	input [63:0]D; // Data input
	input [4:0]DA; // Data destination address
	input W; // write enable
	input reset; // positive logic asynchronous reset
	input clock;
	output [15:0] r0, r1, r2, r3, r4, r5, r6, r7; // outputs for visualization
	
	wire [31:0]m;//m is decoder output i.e. the # of the chosen register
	wire [31:0]load_enable;//load_enable is W

	decoder5to32 decoder (DA, m);//DA is decoder select S, m is decoder output
	assign load_enable = m & {32{W}};
	
	wire [63:0]R00, R01, R02, R03, R04, R05, R06, R07, R08, R09;
	wire [63:0]R10, R11, R12, R13, R14, R15, R16, R17, R18, R19;
	wire [63:0]R20, R21, R22, R23, R24, R25, R26, R27, R28, R29;
	wire [63:0]R30, R31;
	
	reg64 reg00 (R00, D, load_enable[0], reset, clock);
	reg64 reg01 (R01, D, load_enable[1], reset, clock);
	reg64 reg02 (R02, D, load_enable[2], reset, clock);
	reg64 reg03 (R03, D, load_enable[3], reset, clock);
	reg64 reg04 (R04, D, load_enable[4], reset, clock);
	reg64 reg05 (R05, D, load_enable[5], reset, clock);
	reg64 reg06 (R06, D, load_enable[6], reset, clock);
	reg64 reg07 (R07, D, load_enable[7], reset, clock);
	reg64 reg08 (R08, D, load_enable[8], reset, clock);
	reg64 reg09 (R09, D, load_enable[9], reset, clock);
	reg64 reg10 (R10, D, load_enable[10], reset, clock);
	reg64 reg11 (R11, D, load_enable[11], reset, clock);
	reg64 reg12 (R12, D, load_enable[12], reset, clock);
	reg64 reg13 (R13, D, load_enable[13], reset, clock);
	reg64 reg14 (R14, D, load_enable[14], reset, clock);
	reg64 reg15 (R15, D, load_enable[15], reset, clock);
	reg64 reg16 (R16, D, load_enable[16], reset, clock);
	reg64 reg17 (R17, D, load_enable[17], reset, clock);
	reg64 reg18 (R18, D, load_enable[18], reset, clock);
	reg64 reg19 (R19, D, load_enable[19], reset, clock);
	reg64 reg20 (R20, D, load_enable[20], reset, clock);
	reg64 reg21 (R21, D, load_enable[21], reset, clock);
	reg64 reg22 (R22, D, load_enable[22], reset, clock);
	reg64 reg23 (R23, D, load_enable[23], reset, clock);
	reg64 reg24 (R24, D, load_enable[24], reset, clock);
	reg64 reg25 (R25, D, load_enable[25], reset, clock);
	reg64 reg26 (R26, D, load_enable[26], reset, clock);
	reg64 reg27 (R27, D, load_enable[27], reset, clock);
	reg64 reg28 (R28, D, load_enable[28], reset, clock);
	reg64 reg29 (R29, D, load_enable[29], reset, clock);
	reg64 reg30 (R30, D, load_enable[30], reset, clock);
	assign R31 = 64'b0;
	
	mux32to1 muxA (A, SA, R00, R01, R02, R03, R04, R05, R06, R07, R08, R09, R10, R11, R12,
	R13, R14, R15, R16, R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27, R28, R29, R30,
	R31);
	
	//A,B = F SA,SB = S R00 = I00 etc.

	mux32to1 muxB (B, SB, R00, R01, R02, R03, R04, R05, R06, R07, R08, R09, R10, R11, R12,
	R13, R14, R15, R16, R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27, R28, R29, R30,
	R31);
	
	// outputs to visualize
	assign r0 = R00[15:0];
	assign r1 = R01[15:0];
	assign r2 = R02[15:0];
	assign r3 = R03[15:0];
	assign r4 = R04[15:0];
	assign r5 = R05[15:0];
	assign r6 = R06[15:0];
	assign r7 = R07[15:0];

endmodule
