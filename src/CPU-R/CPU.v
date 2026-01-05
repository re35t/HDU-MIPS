module CPU(clk,rst,op_code,funct,rs_addr,rt_addr,rd_addr,shamt,OF,ZF,F,ALU_OP,Inst_code);
input clk,rst;
output [31:0]Inst_code;
output [5:0]op_code,funct;
output [4:0]rs_addr,rt_addr,rd_addr,shamt;
output [31:0]F;
output OF,ZF;
output reg [2:0]ALU_OP;

reg Write_Reg;
wire [31:0]R_Data_A,R_Data_B;
PC pc1(clk,rst,Inst_code);
assign op_code = Inst_code[31:26];
assign rs_addr = Inst_code[25:21];
assign rt_addr = Inst_code[20:16];
assign rd_addr = Inst_code[15:11];
assign shamt = Inst_code[10:6];
assign funct = Inst_code[5:0];
Reg R(rs_addr,rt_addr,Write_Reg,R_Data_A,R_Data_B,rst,~clk,rd_addr,F);
ALU A(R_Data_A, R_Data_B, ALU_OP, F, ZF, OF);
always@(*)
	begin	
		Write_Reg<=0;
			ALU_OP=0;
				if(op_code==0)
					Write_Reg<=1;
					begin 
						case(funct)
						6'b100000:ALU_OP=3'b100;//add
						6'b100010:ALU_OP=3'b101;//sub
						6'b100100:ALU_OP=3'b000;//and
						6'b100101:ALU_OP=3'b001;//or
						6'b100110:ALU_OP=3'b010;//xor
						6'b100111:ALU_OP=3'b011;//nor
						6'b101011:ALU_OP=3'b110;//sltu
						6'b000100:ALU_OP=3'b111;//sllv
						endcase 
					end
				end
endmodule
