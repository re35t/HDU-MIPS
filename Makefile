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

.PHONY: all run wave clean

all: $(OUT)

$(OUT): $(SRC) | $(SIM_DIR)
	$(IVERILOG) -o $@ $(SRC)

$(SIM_DIR):
	mkdir -p $@

run: $(OUT)
	$(VVP) $(OUT)

wave: $(VCD)
	gtkwave $(VCD)

$(VCD): run ;

clean:
	rm -rf $(SIM_DIR)
