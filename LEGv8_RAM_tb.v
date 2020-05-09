module LEGv8_RAM_tb;

reg [7:0] address;

reg clock;

reg [63:0] in;

reg writeEn, readEn;

wire [63:0] out;


LEGv8_RAM uut(.address(address), .clock(clock), .in(in), .writeEn(writeEn), .out(out), .readEn(readEn));


initial begin
{address,clock,in,writeEn,readEn} = 0;

#10 //clock falls
	in = 64'd8;
	address = 8'd7;
	writeEn = 1'b1;
	
#5 //clock rises
	
	
#5 //clock falls
	writeEn = 1'b0;
	readEn = 1'b1;
#5 //clock rises
	
#5
	writeEn = 1'b1;
	readEn = 1'b0;
#5

	
#5 //clock falls

#5 //clock rises
	readEn =1'b1;
#5 //clock falls
	in = 64'd90;
	address = 8'd5;
	
#100 $stop;

end
always begin #5 clock <= ~clock; end

endmodule
