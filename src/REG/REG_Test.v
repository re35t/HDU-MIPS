`timescale 1ns/1ps

module Reg_test;
	// Inputs
	reg [4:0] Addr;
	reg Write_Reg;
	reg [1:0] Opt;
	reg Clk;
	reg Reset;
	reg A_B;
	// Outputs
	wire [7:0] LED;

	Reg_Top uut (
		.Addr(Addr), 
		.Write_Reg(Write_Reg), 
		.Opt(Opt), 
		.Clk(Clk), 
		.Reset(Reset), 
		.A_B(A_B), 
		.LED(LED)
	);

    // 25 MHz clock
	always #20 Clk = ~Clk;

	initial begin
		$dumpfile("sim/reg_top_tb.vcd");
		$dumpvars(0, Reg_test);

		// reset
		Clk = 0;
		Reset = 1;
		Write_Reg = 0;
		Opt = 0;
		Addr = 5'b00001;
		A_B = 0;
		#50;

		// write
		Reset = 0;
		Write_Reg = 1;
		Opt = 0;
		Addr = 5'b00001;
		#80;

		// read
		Write_Reg = 0;
		A_B = 0;
		Opt = 0;
		Addr = 5'b00001;
		#100;

		$finish;
	end
endmodule
