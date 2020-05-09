module CPU_tb();

reg reset;
reg clock;

wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7;
wire [63:0] mem1, mem2, mem3, mem4;
wire [35:0] control_word;
wire [31:0] instruction;
wire [15:0] rom_addr;



CPU uut(.reset(reset),.clock(clock));

assign r0 = uut.r0;
assign r1 = uut.r1;
assign r2 = uut.r2;
assign r3 = uut.r3;
assign r4 = uut.r4;
assign r5 = uut.r5;
assign r6 = uut.r6;
assign r7 = uut.r7;

assign mem1 = uut.mem1;
assign mem2 = uut.mem2;
assign mem3 = uut.mem3;
assign mem4 = uut.mem4;

assign control_word = uut.control_word;
assign instruction = uut.instruction;

assign rom_addr = uut.rom_addr;


initial begin

 {reset,clock} <= 1'b0;
 #5 reset = 1'b1;

#5 reset = 1'b0;

end


always begin #5 clock <= ~clock; end



initial begin
#150 $stop; //set to 150
end

endmodule
