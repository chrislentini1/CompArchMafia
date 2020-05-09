module CPU (reset, clock);

input reset, clock;

wire SL;

wire [63:0] k;

wire [63:0] D;

wire [63:0] mem1, mem2, mem3, mem4;

wire [4:0] FS, SA, SB, DA;

wire selBork, W, Cin, triselBtoD, triselFtoD, triselFtoRAM, triselRAMtoD, writeenable;

wire [3:0] status;

wire [63:0] memout;

wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7; 

wire [31:0] P;

wire [63:0] A, B, muxout, F;

wire [3:0] status_new;
RegisterFile32x64 regfile(A, B, SA, SB, D, DA, W, reset, clock, r0, r1, r2, r3, r4, r5, r6, r7);

ALU_LEGv8 alu(A, muxout, FS, Cin, F, status);

assign muxout = selBork ? k : B;

assign D = triselBtoD ? B : 64'bz;
assign D = triselFtoD ? F : 64'bz;
assign P = triselFtoRAM ? F[31:0] : 32'bz;
assign D = triselRAMtoD ? memout : 64'bz;


LEGv8_RAM ram(P, clock, D, writeenable, memout, mem1, mem2, mem3, mem4);
wire [15:0] PC_In;
wire [15:0] PC_Out;
wire [1:0] PS;
wire Pcsel;

assign PC_In = Pcsel ? k : A;

ProgramCounter PC(PC_Out, PC_In, PS, reset, clock);
                 
wire EN_PC_ROM;
wire [15:0]rom_addr;

assign rom_addr = EN_PC_ROM ? PC_Out : 16'bz;

wire EN_PC_REG;
assign D = EN_PC_REG ? PC_Out: 16'bz;

wire [31:0] ROM_Out;
wire [31:0] instruction;

rom_case ROM(ROM_Out, rom_addr);

wire EN_IR;
assign instruction  = EN_IR ? ROM_Out : 32'bz;

instruction_register IR(instruction, ROM_Out , IL, reset, clock);

wire [35:0] control_word;
assign {DA, SA, SB, W, selBork, triselBtoD, FS, Cin, triselFtoD, triselFtoRAM, triselRAMtoD, writeenable, PS, Pcsel, EN_PC_REG, EN_PC_ROM, EN_IR, IL, SL} = control_word;

control_unit CU(k, instruction, status_new, reset, clock, control_word);


status_register SR(status_new,status,SL,reset,clock);

endmodule 
