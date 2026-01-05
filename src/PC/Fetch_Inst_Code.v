module Fetch_Inst_Code(clk,rst,LED,MUX,op_code,funct,rs_addr,rt_addr,rd_addr,shamt,Inst_code);
input clk,rst;
input [1:0]MUX;
output [31:0]Inst_code;
output reg[7:0]LED;
wire [31:0]PC;
wire [31:0]PC_new;
wire [1:0] PC_s;
wire [31:0] R_Data_A;
wire [25:0] address;
wire [31:0] imm_data;
output [5:0]op_code,funct;
output [4:0]rs_addr,rt_addr,rd_addr,shamt;

assign PC_s = 2'b00;
assign R_Data_A = 32'b0;
assign address = 26'b0;
assign imm_data = 32'b0;

PC pc1(clk,rst,Inst_code,PC_s,R_Data_A,address,PC,imm_data,PC_new);
always@(*)
	begin
		case(MUX)
			2'b00:LED = Inst_code[7:0];
			2'b01:LED = Inst_code[15:8];
			2'b10:LED = Inst_code[23:16];
			2'b11:LED = Inst_code[31:25];
		endcase
	end
assign op_code = Inst_code[31:26];
assign rs_addr = Inst_code[25:21];
assign rt_addr = Inst_code[20:16];
assign rd_addr = Inst_code[15:11];
assign shamt = Inst_code[10:6];
assign funct = Inst_code[5:0];
endmodule
