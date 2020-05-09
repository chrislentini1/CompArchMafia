module LEGv8_RAM(address, clock, in, writeEn, out, mem1,mem2,mem3,mem4);
	input [7:0] address;
	input clock, writeEn;
	input [63:0] in;
	
	output reg [63:0] out;
	
	output [63:0] mem1,mem2,mem3,mem4;
	
	parameter memory_words = 256;
	
	reg [63:0] mem [0:memory_words-1];
	
	always @(posedge clock) begin
		if(writeEn) begin
			mem[address] <= in;
		end
	end

	always @(*) begin
		
			out <= mem[address];
		end
	
		assign mem1=mem[1];
		assign mem2=mem[2];
		assign mem3=mem[3];
		assign mem4=mem[4];
endmodule
