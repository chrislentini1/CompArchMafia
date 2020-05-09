module control_unit_tb();
	reg reset, clock;
	reg [4:0]status;
	reg [31:0]instruction;
	wire [63:0]constant;
	wire [35:0]control_word;
	
	wire[1:0] state, next_state;
	wire[16:0] select;
	
	control_unit uut(constant, instruction, status, reset, clock, control_word);
	
	assign state = uut.state;
	assign next_state = uut.next_state;
	assign select = uut.select;
	
	initial begin
	{instruction, status, reset, clock} <= 0;
	
	#2 instruction <= 32'b11010011011010111000001110011100; //LSL
	#8 instruction <= 32'b10010001000000000000010000100010; //ADDI
	#8 instruction <= 32'b10110100000000000000000000110000;// CBZ
	end
	
	always begin
	#2 clock <= ~clock;
	end
	
	initial begin
	#50 $stop;
	end
endmodule
