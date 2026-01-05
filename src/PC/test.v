module test;
	// Inputs
	reg clk;
	reg rst;
	reg [1:0] MUX;
	// Outputs
	wire [7:0] LED;
	wire [5:0] op_code;
	wire [5:0] funct;
	wire [4:0] rs_addr;
	wire [4:0] rt_addr;
	wire [4:0] rd_addr;
	wire [4:0] shamt;
	wire [31:0] Inst_code;
	Fetch_Inst_Code uut (
		.clk(clk), 
		.rst(rst), 
		.LED(LED), 
		.MUX(MUX), 
		.op_code(op_code), 
		.funct(funct), 
		.rs_addr(rs_addr), 
		.rt_addr(rt_addr), 
		.rd_addr(rd_addr), 
		.shamt(shamt), 
		.Inst_code(Inst_code)
	);
	always #33 clk = ~clk;
	initial begin
		$dumpfile("sim/pc_tb.vcd");
		$dumpvars(0, test);

		clk = 0;
		rst = 1;
		MUX = 0;
		#2;
      rst = 0;
		#500;
		$finish;
	end
      
endmodule
