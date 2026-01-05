# iverilog/gtkwave flow for ALU / PC / REG / CPU testbenches

SIM_DIR := sim

IVERILOG := iverilog
VVP := vvp
GTK := gtkwave

ALU_SRC := \
	src/ALU/ALU.v \
	src/ALU/ALU_Display.v \
	src/ALU/ALU_Top.v \
	src/ALU/tb_ALU_Top.v
ALU_OUT := $(SIM_DIR)/alu_top_tb
ALU_VCD := $(SIM_DIR)/alu_top_tb.vcd

REG_SRC := \
	src/REG/REG.v \
	src/REG/REG_Top.v \
	src/REG/REG_Test.v
REG_OUT := $(SIM_DIR)/reg_top_tb
REG_VCD := $(SIM_DIR)/reg_top_tb.vcd

PC_SRC := \
	src/PC/PC.v \
	src/PC/Inst_ROM.v \
	src/PC/Fetch_Inst_Code.v \
	src/PC/test.v
PC_MEM := src/PC/inst.hex
PC_OUT := $(SIM_DIR)/pc_tb
PC_VCD := $(SIM_DIR)/pc_tb.vcd

CPU_R_SRC := \
	src/CPU-R/CPU.v \
	src/CPU-R/ALU.v \
	src/CPU-R/REG.v \
	src/CPU-R/PC.v \
	src/CPU-R/Inst_ROM.v \
	src/CPU-R/test.v
CPU_R_MEM := src/CPU-R/inst.hex
CPU_R_OUT := $(SIM_DIR)/cpu_r_tb
CPU_R_VCD := $(SIM_DIR)/cpu_r_tb.vcd

CPU_R_I_SRC := \
	src/CPU-R-I/CPU.v \
	src/CPU-R-I/OP_Func.v \
	src/CPU-R-I/RAM.v \
	src/CPU-R-I/ALU.v \
	src/CPU-R-I/REG.v \
	src/CPU-R-I/PC.v \
	src/CPU-R-I/Inst_ROM.v \
	src/CPU-R-I/test.v
CPU_R_I_MEM := src/PC/inst.hex
CPU_R_I_OUT := $(SIM_DIR)/cpu_r_i_tb
CPU_R_I_VCD := $(SIM_DIR)/cpu_r_i_tb.vcd

CPU_R_I_J_SRC := \
	src/CPU-R-I-J/CPU.v \
	src/CPU-R-I-J/OP_Func.v \
	src/CPU-R-I-J/RAM.v \
	src/CPU-R-I-J/ALU.v \
	src/CPU-R-I-J/REG.v \
	src/CPU-R-I-J/PC.v \
	src/CPU-R-I-J/Inst_ROM.v \
	src/CPU-R-I-J/test.v
CPU_R_I_J_MEM := src/PC/inst.hex
CPU_R_I_J_OUT := $(SIM_DIR)/cpu_r_i_j_tb
CPU_R_I_J_VCD := $(SIM_DIR)/cpu_r_i_j_tb.vcd

.PHONY: all run alu reg pc cpu-r cpu-r-i cpu-r-i-j wave wave-alu wave-reg wave-pc wave-cpu-r wave-cpu-r-i wave-cpu-r-i-j clean

all: run

run: alu reg pc cpu-r cpu-r-i cpu-r-i-j

alu: $(ALU_VCD)
reg: $(REG_VCD)
pc:  $(PC_VCD)
cpu-r: $(CPU_R_VCD)
cpu-r-i: $(CPU_R_I_VCD)
cpu-r-i-j: $(CPU_R_I_J_VCD)

$(SIM_DIR):
	mkdir -p $@

$(ALU_OUT): $(ALU_SRC) | $(SIM_DIR)
	$(IVERILOG) -o $@ $(ALU_SRC)
$(ALU_VCD): $(ALU_OUT)
	$(VVP) $(ALU_OUT)

$(REG_OUT): $(REG_SRC) | $(SIM_DIR)
	$(IVERILOG) -o $@ $(REG_SRC)
$(REG_VCD): $(REG_OUT)
	$(VVP) $(REG_OUT)

$(PC_OUT): $(PC_SRC) | $(SIM_DIR)
	$(IVERILOG) -o $@ $(PC_SRC)
$(PC_VCD): $(PC_OUT) $(PC_MEM)
	$(VVP) $(PC_OUT)

$(CPU_R_OUT): $(CPU_R_SRC) | $(SIM_DIR)
	$(IVERILOG) -o $@ $(CPU_R_SRC)
$(CPU_R_VCD): $(CPU_R_OUT) $(CPU_R_MEM)
	$(VVP) $(CPU_R_OUT)

$(CPU_R_I_OUT): $(CPU_R_I_SRC) | $(SIM_DIR)
	$(IVERILOG) -o $@ $(CPU_R_I_SRC)
$(CPU_R_I_VCD): $(CPU_R_I_OUT) $(CPU_R_I_MEM)
	$(VVP) $(CPU_R_I_OUT)

$(CPU_R_I_J_OUT): $(CPU_R_I_J_SRC) | $(SIM_DIR)
	$(IVERILOG) -o $@ $(CPU_R_I_J_SRC)
$(CPU_R_I_J_VCD): $(CPU_R_I_J_OUT) $(CPU_R_I_J_MEM)
	$(VVP) $(CPU_R_I_J_OUT)

wave: wave-alu
wave-alu: $(ALU_VCD)
	$(GTK) $(ALU_VCD)
wave-reg: $(REG_VCD)
	$(GTK) $(REG_VCD)
wave-pc: $(PC_VCD)
	$(GTK) $(PC_VCD)
wave-cpu-r: $(CPU_R_VCD)
	$(GTK) $(CPU_R_VCD)
wave-cpu-r-i: $(CPU_R_I_VCD)
	$(GTK) $(CPU_R_I_VCD)
wave-cpu-r-i-j: $(CPU_R_I_J_VCD)
	$(GTK) $(CPU_R_I_J_VCD)

clean:
	rm -rf $(SIM_DIR)
