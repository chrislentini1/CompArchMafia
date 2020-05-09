module reg32(Q, D, L, R, clock);

output reg [31:0]Q; // registered output

input [31:0]D; // data input

input L; // load enable

input R; // positive logic asynchronous reset

input clock;

always @(posedge clock or posedge R) begin

if(R)

Q <= 0;

else if(L)

Q <= D;

else

Q <= Q;

end

endmodule
