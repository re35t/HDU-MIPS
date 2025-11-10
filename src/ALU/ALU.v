module ALU(
 input [31:0]ALU_A,
 input [31:0]ALU_B,
 input [2:0]ALU_OP,
 output reg [31:0]ALU_F,
 output ZF,
 output OF
    );

always@(*)begin
 case(ALU_OP)
 3'b000:ALU_F=ALU_A&ALU_B;//and
 3'b001:ALU_F=ALU_A|ALU_B;//or
 3'b010:ALU_F=ALU_A^ALU_B;//xor
 3'b011:ALU_F=~(ALU_A|ALU_B);//nor
 3'b100:ALU_F=ALU_A+ALU_B;//add
 3'b101:ALU_F=ALU_A-ALU_B;//sub
 3'b110:ALU_F=$signed(ALU_A)<$signed(ALU_B)?1:0;//slt
 3'b111:ALU_F=ALU_A<<ALU_B[4:0];//sll using lower 5 bits
 default:ALU_F=32'b0;//default
 endcase
end

assign ZF = ~(|ALU_F);
wire add_overflow;
wire sub_overflow;
assign add_overflow = (~(ALU_A[31]^ALU_B[31])) & (ALU_A[31]^ALU_F[31]);
assign sub_overflow = (ALU_A[31]^ALU_B[31]) & (ALU_A[31]^ALU_F[31]);
assign OF = (ALU_OP==3'b100) ? add_overflow :
            (ALU_OP==3'b101) ? sub_overflow : 1'b0;

endmodule
