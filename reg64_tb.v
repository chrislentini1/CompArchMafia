//reg64 testbench

module reg64_tb;

reg [63:0]D;

reg L;

reg R;

wire [63:0]Q;

reg clock;

reg64 uut(.Q(Q), .D(D), .L(L), .R(R), .clock(clock));

initial


begin
clock = 0;

D=64'b0;

L=1'b0;

R=1'b0;

#5 R=1'b1;

#10 R=1'b0;

#5 L=1'b1;

#20 D=3;

#20 D=5;

#40 $stop;

end

always begin

#5 clock<=~clock;

end

endmodule

