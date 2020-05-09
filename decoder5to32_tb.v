module decoder5to32_tb;

reg [4:0]S; // select

wire [31:0]m; 
decoder5to32 uut(.S(S), .m(m));

initial begin

S[0] = 0;
S[1] = 0;
S[2] = 0;
S[3] = 0;
S[4] = 0;


#200 $stop;
end

always begin

#5 S[0] = ~S[0];
end

always begin


#10 S[1] = ~S[1];

end

always begin


#20 S[2] = ~S[2];

end

always begin

#40 S[3] = ~S[3];

end

always begin

#80 S[4] = ~S[4];
end


endmodule
