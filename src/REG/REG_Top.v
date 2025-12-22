module Reg_Top(Addr,Write_Reg,Opt,Clk,Reset,A_B,LED);
input [1:0]Opt;
input [4:0]Addr;
input Write_Reg,Clk,Reset,A_B;
output reg [7:0]LED;
wire [31:0]R_Data_A,R_Data_B;
reg [4:0]R_Addr_A,R_Addr_B;
reg [31:0]W_Data;

initial
	LED <= 0;

Reg Reg_one(R_Addr_A,R_Addr_B,Write_Reg,R_Data_A,R_Data_B,Reset,Clk,Addr,W_Data);

always @ (Addr or Write_Reg or Opt or A_B or R_Data_A or R_Data_B)
	begin
		if(Write_Reg)
			begin
				case(Opt)
					2'b00: begin W_Data=32'h000f_000f;  end
					2'b01: begin W_Data=32'h0f0f_0f00;  end
					2'b10: begin W_Data=32'hf0f0_f0f0;  end 
					2'b11: begin W_Data=32'hffff_ffff;  end
				endcase
			end
		else
			if(A_B)
				begin
					R_Addr_A=Addr;
					case(Opt)
						2'b00: LED=R_Data_A[7:0];
						2'b01: LED=R_Data_A[15:8];
						2'b10: LED=R_Data_A[23:16];
						2'b11: LED=R_Data_A[31:24];
					endcase
				end
			else
				begin
					R_Addr_B=Addr;
					case(Opt)
						2'b00: LED=R_Data_B[7:0];
						2'b01: LED=R_Data_B[15:8];
						2'b10: LED=R_Data_B[23:16];
						2'b11: LED=R_Data_B[31:24];
					endcase
				end
	end
endmodule
