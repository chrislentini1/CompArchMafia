module mux4to1_32bit(F, S, I0, I1, I2, I3);
	input [31:0] I0, I1, I2, I3;
	input [1:0] S;
	output reg [31:0] F;
	always @(*) begin
		case(S)
			2'b00: F <= I0;
			2'b01: F <= I1;
			2'b10: F <= I2;
			2'b11: F <= I3;
			default:F <= I0;
		endcase
	end
endmodule