# iverilog/gtkwave based flow for ALU_Top testbench

SIM_DIR := sim
OUT := $(SIM_DIR)/alu_top_tb
VCD := $(SIM_DIR)/alu_top_tb.vcd

IVERILOG := iverilog
VVP := vvp

SRC := \
	src/ALU/ALU.v \
	src/ALU/ALU_Display.v \
	src/ALU/ALU_Top.v \
	src/ALU/tb_ALU_Top.v

# Reg file sources (compile-only)
REG_SRC := \
	src/REG/REG.v \
	src/REG/REG_Top.v

REG_SRC_TB := \
	$(REG_SRC) \
	src/REG/REG_Test.v

REG_OUT := $(SIM_DIR)/reg_top
REG_OUT_TB := $(SIM_DIR)/reg_top_tb
REG_VCD := $(SIM_DIR)/reg_top_tb.vcd

.PHONY: all run wave clean

all: $(OUT) $(REG_OUT_TB)

$(OUT): $(SRC) | $(SIM_DIR)
	$(IVERILOG) -o $@ $(SRC)

$(SIM_DIR):
	mkdir -p $@

run: $(OUT) $(REG_OUT_TB)
	$(VVP) $(OUT)
	$(VVP) $(REG_OUT_TB)

wave: $(VCD)
	gtkwave $(VCD)

$(VCD): run ;

# Only compile Reg_Top + REG.v to catch unknown-module errors
reg: $(REG_OUT)

$(REG_OUT): $(REG_SRC) | $(SIM_DIR)
	$(IVERILOG) -o $@ $(REG_SRC)

reg-tb: $(REG_OUT_TB)

$(REG_OUT_TB): $(REG_SRC_TB) | $(SIM_DIR)
	$(IVERILOG) -o $@ $(REG_SRC_TB)

reg-run: reg-tb
	$(VVP) $(REG_OUT_TB)

reg-wave: $(REG_VCD)
	gtkwave $(REG_VCD)

$(REG_VCD): reg-run ;

clean:
	rm -rf $(SIM_DIR)
