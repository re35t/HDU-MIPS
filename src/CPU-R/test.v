module test;
	// Inputs
	reg clk;
	reg rst;
	// Outputs
	wire [5:0] op_code;
	wire [5:0] funct;
	wire [4:0] rs_addr;
	wire [4:0] rt_addr;
	wire [4:0] rd_addr;
	wire [4:0] shamt;
	wire OF;
	wire ZF;
	wire [31:0] F;
	wire [2:0] ALU_OP;
	wire [31:0] Inst_code;
	CPU uut (
		.clk(clk), 
		.rst(rst), 
		.op_code(op_code), 
		.funct(funct), 
		.rs_addr(rs_addr), 
		.rt_addr(rt_addr), 
		.rd_addr(rd_addr), 
		.shamt(shamt), 
		.OF(OF), 
		.ZF(ZF), 
		.F(F), 
		.ALU_OP(ALU_OP), 
		.Inst_code(Inst_code)
	);
	always #20 clk = ~clk;
	initial begin
		clk = 0;
		rst = 1;
		#2;
      rst = 0;  
	end      
	initial begin
		// Run for 32 instruction cycles, then stop.
		repeat (40) @(posedge clk);
		$finish;
	end
	initial begin
		$dumpfile("sim/cpu_r_tb.vcd");
		$dumpvars(0, test);
	end
endmodule
