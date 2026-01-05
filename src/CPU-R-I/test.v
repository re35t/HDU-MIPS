module test;
	reg clk;
	reg rst;
	reg clk_M;
	wire OF;
	wire ZF;
	wire [31:0] F;
	wire [2:0] ALU_OP;
	wire [31:0] M_R_Data;
	wire rd_rt_s;
	wire imm_s;
	wire rt_imm_s;
	wire Mem_Write;
	wire alu_mem_s;
	wire Write_Reg;
	wire [31:0] R_Data_B;
	wire [31:0] Inst_code;
	CPU uut (
		.clk(clk), 
		.rst(rst), 
		.OF(OF), 
		.ZF(ZF), 
		.F(F), 
		.ALU_OP(ALU_OP), 
		.M_R_Data(M_R_Data), 
		.rd_rt_s(rd_rt_s), 
		.imm_s(imm_s), 
		.rt_imm_s(rt_imm_s), 
		.Mem_Write(Mem_Write), 
		.alu_mem_s(alu_mem_s), 
		.Write_Reg(Write_Reg), 
		.clk_M(clk_M), 
		.R_Data_B(R_Data_B), 
		.Inst_code(Inst_code)
	);
	always #9  clk_M = ~clk_M;
	always #20 clk = ~clk;
	initial begin
		clk = 0;
		rst = 1;
		clk_M = 0;
		#2;
      rst = 0;
	end     
	initial begin
		// Run for 32 instruction cycles, then stop.
		repeat (40) @(posedge clk);
		$finish;
	end
	initial begin
		$dumpfile("sim/cpu_r_i_tb.vcd");
		$dumpvars(0, test);
	end
endmodule
