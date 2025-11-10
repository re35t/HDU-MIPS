module ALU_Top (
    input [2:0] AB_SW,
    input [2:0] ALU_OP_SW,
    input [2:0] F_LED_SW,
    output reg [31:0] A,
    output reg [31:0] B,
    output [31:0] F,
    output [7:0] LED,
    output ZF,
    output OF
);

always @(*)
begin
    case (AB_SW)
        3'b000: begin A = 32'h0000_0000; B = 32'h0000_0000; end
        3'b001: begin A = 32'h0000_0003; B = 32'h0000_0607; end
        3'b010: begin A = 32'h8000_0000; B = 32'h8000_0000; end
        3'b011: begin A = 32'h7FFF_FFFF; B = 32'h7FFF_FFFF; end
        3'b100: begin A = 32'hFFFF_FFFF; B = 32'hFFFF_FFFF; end
        3'b101: begin A = 32'h8000_0000; B = 32'hFFFF_FFFF; end
        3'b110: begin A = 32'hFFFF_FFFF; B = 32'h8000_0000; end
        3'b111: begin A = 32'h1234_5678; B = 32'h3333_2222; end
        default: begin A = 32'h9ABC_DEF0; B = 32'h1111_2222; end
    endcase
end

ALU u_alu(
    .ALU_A(A),
    .ALU_B(B),
    .ALU_OP(ALU_OP_SW),
    .ALU_F(F),
    .ZF(ZF),
    .OF(OF)
);

ALU_Display u_display(
    .F(F),
    .ZF(ZF),
    .OF(OF),
    .F_LED_SW(F_LED_SW),
    .LED(LED)
);

endmodule
