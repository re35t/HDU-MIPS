module RAM (
  input         clka,
  input  [0:0]  wea,      // Xilinx 风格 [0:0]
  input  [5:0]  addra,
  input  [31:0] dina,
  output [31:0] douta
);

  // 64 x 32-bit
  reg [31:0] mem [0:63];

  // 仿真初始化（可选）
  initial begin
    $readmemh("src/CPU-R-I/data.hex", mem);
  end

  // 同步写：sw 在时钟沿写入
  always @(posedge clka) begin
    if (wea[0]) begin
      mem[addra] <= dina;
    end
  end

  // 异步读：lw 地址一变化，douta 立刻反映
  // 注意：同一周期“读写同址”时的返回值，和真实 BRAM 可能不同
  assign douta = mem[addra];

endmodule
