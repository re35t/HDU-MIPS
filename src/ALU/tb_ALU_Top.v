`timescale 1ns/1ps

module tb_ALU_Top;

reg [2:0] AB_SW;
reg [2:0] ALU_OP_SW;
reg [2:0] F_LED_SW;

wire [31:0] A;
wire [31:0] B;
wire [31:0] F;
wire [7:0] LED;
wire ZF;
wire OF;

integer ab_idx;
integer op_idx;

ALU_Top dut (
    .AB_SW(AB_SW),
    .ALU_OP_SW(ALU_OP_SW),
    .F_LED_SW(F_LED_SW),
    .A(A),
    .B(B),
    .F(F),
    .LED(LED),
    .ZF(ZF),
    .OF(OF)
);

localparam integer STEP_NS = 20;

initial begin
    $dumpfile("sim/alu_top_tb.vcd");
    $dumpvars(0, tb_ALU_Top);

    AB_SW = 3'b000;
    ALU_OP_SW = 3'b000;
    F_LED_SW = 3'b000;
    #STEP_NS;

    for (ab_idx = 0; ab_idx < 8; ab_idx = ab_idx + 1) begin
        AB_SW = ab_idx[2:0];
        #STEP_NS; // allow AB selection to settle
        for (op_idx = 0; op_idx < 8; op_idx = op_idx + 1) begin
            ALU_OP_SW = op_idx[2:0];
            #STEP_NS;
        end
        #STEP_NS; // hold last result before moving to next operand pair
    end

    F_LED_SW = 3'b011;
    #(2*STEP_NS);
    F_LED_SW = 3'b111; // show flags on LED
    #(2*STEP_NS);
    $finish;
end

endmodule
