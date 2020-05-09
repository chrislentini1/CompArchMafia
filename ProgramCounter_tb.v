module ProgramCounter_tb;

reg clock, reset;

reg [31:0] PC_IN;

reg [1:0] PS;

reg [3:0] status;

wire [31:0] PC_OUT;



ProgramCounter pc(.PC_OUT(PC_OUT), .PC_IN(PC_IN), .PS(PS), .status(status), .reset(reset), .clock(clock));



//00 PC <- PC
//01 PC <- PC + 1
//10 PC <- Input
//11 PC <- PC + Input
initial begin

clock = 1'b0;
reset = 1'b1;

#15 reset = 1'b0;

#5 PS = 2'b00; //clock high

#5 

#5 //clock high

#5
PC_IN = 32'd5;
PS = 2'b01;

#5 //clock high

#5
PS = 2'b10;

#5 //clock high

#5
PS = 2'b11;

#5 //clock high

#80 $stop;

end
always begin
#5 clock <= ~clock;
end
endmodule
