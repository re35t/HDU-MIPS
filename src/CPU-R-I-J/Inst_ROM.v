module Inst_ROM(
    input  wire        clka,
    input  wire [7:2]  addra,   // 对齐实验5: 64 words => PC[7:2]
    output reg  [31:0] douta
);
    reg [31:0] rom [0:63];

    initial begin
        // Use project-root-relative path so vvp from Makefile can find it
        $readmemh("src/CPU-R-I-J/inst.hex", rom);
    end

    // 同步读：地址打一拍，数据下一拍出（像同步 Memory IP）
    always @(posedge clka) begin
        douta <= rom[addra];
    end
endmodule
