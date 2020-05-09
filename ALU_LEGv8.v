module ALU_LEGv8(A, B, FS, Cin, F, status);

	input [63:0] A, B; // output from regfile A, regfile B
	input [4:0]FS; // 5 bit function select
	input Cin; // carry in
	output [63:0]F; // output
	output [3:0]status; // Z, N, C, V
	
	wire Z, N, Cout, V;

	assign status = {V, Cout, N, Z}; //overflow, carry out, negative, zero
	wire [63:0] A_Signal, B_Signal;
	assign A_Signal = FS[1] ? ~A : A; // A Mux
	assign B_Signal = FS[0] ? ~B : B; // B Mux
	assign N = F[63];
	assign Z = (F == 64'b0) ? 1'b1 : 1'b0;
	assign V = ~(A_Signal[63] ^ B_Signal[63]) & (F[63] ^ A_Signal[63]);
	wire [63:0]and_output, or_output, xor_output, add_output, shift_left, shift_right;
	assign and_output = A_Signal & B_Signal;
	assign or_output = A_Signal | B_Signal;
	assign xor_output = A_Signal ^ B_Signal;

	carry_lookahead_64bits cla(add_output, Cout, A_Signal, B_Signal, Cin);
	Shifter shift_inst (A, B[5:0], shift_left, shift_right);

	Mux8to1_64bit main_mux (F, FS[4:2], and_output, or_output, add_output, xor_output, shift_left, shift_right, 64'b0, 64'b0);

endmodule 