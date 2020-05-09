module control_unit(constant,instruction, status, reset, clock, control_word);

input reset, clock;
input [3:0]status;
input [31:0]instruction;
output reg [63:0]constant;
output reg [35:0]control_word;
	
reg[1:0] state;
reg[1:0] next_state;
wire [16:0]select;
assign select = {state, instruction[31:21], status};
	
	
reg result;

// status [0] = Z, status [1] = N, status [2] = C, status [3] = V
always @(instruction) begin
      casex(instruction[4:0])
       5'b00000: result <= status[0];
       5'b00001: result <= ~status[0]; 
       5'b00010: result <= status[2];
       5'b00011: result <= ~status[2];
       5'b00100: result <= status[1];
       5'b00101: result <= ~status[1];
       5'b00110: result <= status[3];
       5'b00111: result <= ~status[3];
       5'b01000: result <= status[2] & ~status[0];
       5'b01001: result <= ~status[2] || status[0];
       5'b01010: result <= ~(status[1]^status[3]);
       5'b01011: result <= status[1] ^ status[3];
       5'b01100: result <= ~status[0]& ~(status[1]^status[3]);
       5'b01101: result <= status[0] || (status[1]^status[3]);
endcase
end
	
	
	

initial 
	state <= 2'b00;
		
always @(posedge clock or posedge reset) begin
	if(reset) state <= 2'b00;
	else state <= next_state;
end
	
always @(select) begin
	if (state == 2'b00) begin
	{next_state,control_word, constant} <= {38'b01000000000000000000000000000000001110, 64'd0};
   end
	
if (state == 2'b01)
    begin
//  DATA IMM       
if (instruction[28:26] == 3'b100) begin
 casex(instruction[25:23])
   3'b01x:
      begin 
        casex(instruction[30])
			1'b0: {next_state, control_word, constant} <= {2'b00, instruction[4:0], instruction[9:5], 26'b00000110010000100001000000, 52'b0, instruction[21:10]}; //ADDI       
			1'b1: {next_state, control_word, constant} <= {2'b00, instruction[4:0], instruction[9:5], 26'b00000_110_01001_0100001000000, 52'b0, instruction[21:10]}; //SUBI       
		  endcase
       end
   3'b100: 
       begin
         casex(instruction[30:29])
        2'b00: {next_state, control_word, constant} <= {2'b00, instruction[4:0], instruction[9:5], 26'b00000110000000100001000000, {52'b0,instruction[21:10]}}; //ANDI  
        2'b01: {next_state, control_word, constant} <= {2'b00, instruction[4:0], instruction[9:5], 26'b00000110001000100001000000, {52'b0, instruction[21:10]}}; //ORRI  
        2'b10: {next_state, control_word, constant} <= {2'b00, instruction[4:0], instruction[9:5], 26'b00000110011000100001000000, {52'b0,instruction[21:10]}}; //EORI
        2'b11: {next_state, control_word, constant} <= {2'b00, instruction[4:0], instruction[9:5], 26'b00000110000000100001000001, {52'b0,instruction[21:10]}}; //ANDIS
         endcase
        end
   
     3'b101:
       begin
          casex(instruction[29])
           1'b0: {next_state, control_word, constant} <= {2'b00, instruction[4:0], 5'b11111, 26'b00000110010000100001000000, {48'b0,instruction[20:5]}}; //MOVZ   
           1'b1: {next_state,control_word, constant} <= {2'b10, instruction[4:0], instruction[4:0], 26'b0000011000000010000000000, 48'b1,16'b0}; //MOVK-0 
          endcase
		 end
		 
	  3'b110:
   begin
     casex(instruction[21])
         1'b0: {next_state,control_word, constant} <= {2'b00, instruction[4:0], instruction[9:5], 26'b00000_110_101000100001000000, {58'b0,instruction[15:10]}}; //lsr
         1'b1: {next_state,control_word, constant} <= {2'b00, instruction[4:0], instruction[9:5], 26'b00000_110_10000_0100001000000, {58'b0,instruction[15:10]}}; //lsl
	  endcase	
	end

		 
	endcase	 
  end

// BRANCHES
if(instruction[28:26] == 3'b101)
    begin
       casex({instruction[30:29],instruction[25]})
         3'b010:
           begin
              casex(instruction[24])
               1'b0: {next_state,control_word, constant} <= {7'b1000000, instruction[4:0], 26'b11111000010000000000000001, 64'b0}; //CBZ 
               1'b1: {next_state,control_word, constant} <= {7'b1000000, instruction[4:0], 26'b11111000010000000000000001, 64'b0};  //CBNZ 
              endcase
            end
          3'b100: {next_state,control_word, constant} <= {7'b1000000, instruction[4:0], 26'b11111000010000000000000001, 64'b0}; //b.cond
          3'b00x: //
            begin
              casex(instruction[31])
              1'b0: {next_state,control_word, constant} <= {38'b00000000000000000010000000000011000000, {38{instruction[25]}},instruction[25:0]}; //B 
              1'b1: {next_state,control_word, constant} <= {38'b00111100000000000100000000000011110000, {38{instruction[25]}},instruction[25:0]}; //BL 
              endcase
            end
          3'b101: {next_state,control_word, constant} <= {7'b0, instruction[9:5], 26'b00000000000000000010000000, 64'b0}; //BR  

           
        endcase
     end



//MEM

if(instruction[31:27] == 5'b11111)
   begin
      casex(instruction[22])
        1'b0: {next_state,control_word, constant} <= {7'b0, instruction[9:5], instruction[4:0], 21'b011010000010101000000, {55{instruction[20]}},instruction[20:12]}; //STUR  
        1'b1: {next_state,control_word, constant} <= {2'b00, instruction[4:0], instruction[9:5], 26'b00000110010000011001000000, {55{instruction[20]}},instruction[20:12]}; //LDUR  

      endcase
   end


//DATA REG: AND, ANDS, ORR, EOR, ADD, ADDS, SUB, SUBS
if(instruction[28] == 1'b0)
  begin
    casex(instruction[31:21])
      11'b10001010000: {next_state,control_word, constant} <= {2'b00, instruction[4:0], instruction[9:5], instruction[20:16], 21'b110000000100001000001, 64'b0}; //and
      
		11'b11101010000: {next_state,control_word, constant} <= {2'b00, instruction[4:0], instruction[9:5], instruction[20:16], 21'b110000000100001000001, 64'b0}; //ands

      11'b10101010000: {next_state,control_word, constant} <={2'b00, instruction[4:0], instruction[9:5], instruction[20:16], 21'b100001000100001000000, 64'b0}; //orr
      
		11'b11001010000: {next_state,control_word, constant} <= {2'b00, instruction[4:0], instruction[9:5], instruction[20:16], 21'b100011000100001000000, 64'b0}; //eor

      11'b10001011000: {next_state,control_word, constant} <= {2'b00, instruction[4:0], instruction[9:5], instruction[20:16], 21'b100010000100001000000, 64'b0};//add

      11'b10101011000: {next_state,control_word, constant} <= {2'b00, instruction[4:0], instruction[9:5], instruction[20:16], 21'b100010000100001000001, 64'b0}; //adds

      11'b11001011000: {next_state,control_word, constant} <= {2'b00, instruction[4:0], instruction[9:5], instruction[20:16], 21'b100010011100001000000, 64'b0};   //sub

      11'b11101011000: {next_state,control_word, constant} <= {2'b00, instruction[4:0], instruction[9:5], instruction[20:16], 21'b100010011100001000001, 64'b0}; //subs 

      11'b00100010101: {next_state, control_word, constant} <= {2'b00, instruction[4:0], instruction[9:5], 5'b11111, 21'b100001010100010000000, 64'b0}; //not

      11'b10001011011: {next_state,control_word, constant} <= {2'b00, instruction[4:0], instruction[9:5], instruction[20:16], 21'b100_01000_1_100001000000, 64'b0}; //ADC Add with carry

      11'b11001011001: {next_state,control_word, constant} <= {2'b00, instruction[4:0], instruction[9:5], instruction[20:16], 21'b100_01001_0_100001000000, 64'b0};   //Sub with carry
    endcase
  end
 

  end 
// EX1
if (state == 2'b10) begin
   casex(instruction[31:21])
       11'b111100101xx: {next_state,control_word, constant} <= {2'b00, instruction[4:0], instruction[4:0], 26'b00000110010000100001000000, 48'b0, instruction[20:5]};  //movk
       11'b10110100xxx:  //cbz
          begin
            casex(status[0])
              1'b0: {next_state,control_word, constant} <= {38'b000000000000000000000000000000_01_100000, {45{instruction[23]}},instruction[23:5]}; // cbz1-nz
              1'b1: {next_state,control_word, constant} <= {7'b0000000, instruction[4:0], 26'b11111000010000000011100000, {45{instruction[23]}}, instruction[23:5]}; //cbz1-z
            endcase
          end 
      

     11'b10110101xxx: //cbnz
          begin
            casex(status[0])
              1'b0: {next_state,control_word, constant} <= {38'b00000000000000000000000000000011_100000, {45{instruction[23]}}, instruction[23:5]};    //cbnz - nz

              1'b1: {next_state,control_word, constant} <= {7'b0000000, instruction[4:0], 26'b11111000010000000001100000, {45{instruction[23]}}, instruction[23:5]};    //cbnz - z
         endcase
          end
			 
		11'b01010100xxx: {next_state, control_word, constant} <= {30'b000000000000000000000000000000, {2{result}} ,6'b100000, 45'b0, instruction[23:5]};  //b.cond		
	 endcase
        

	end
 end
endmodule 