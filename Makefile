###############################################################################
# UALINK UPLI VIP – Verification Makefile
###############################################################################

PROJECT_NAME := ualink_upli

###############################################################################
# Directory Structure
###############################################################################
ROOT_DIR      := ../../..
TEST_DIR      := ../../
TB_DIR        := $(TEST_DIR)/tb_ualink_upli_back_to_back_sys

INCLUDE_DIR   := $(ROOT_DIR)/ualink_include
SRC_DIR       := $(ROOT_DIR)/src

###############################################################################
# Include Paths
###############################################################################
INCL := \
 +incdir+$(INCLUDE_DIR)/define \
 +incdir+$(INCLUDE_DIR)/includes \
 +incdir+$(INCLUDE_DIR)/interface \
 +incdir+$(INCLUDE_DIR)/package \
 +incdir+$(ROOT_DIR)/ualink_upli_orignator_agent \
 +incdir+$(ROOT_DIR)/ualink_upli_completer_agent \
 +incdir+$(ROOT_DIR)/ualink_upli_env \
 +incdir+$(ROOT_DIR)/Transaction_Layer/ualink_tl_tx_flit_transactor \
 +incdir+$(ROOT_DIR)/Transaction_Layer/ualink_tl_env \
 +incdir+$(SRC_DIR) \
 +incdir+$(TB_DIR)/env \
 +incdir+$(TB_DIR)/test \
 +incdir+$(TB_DIR)/hdl \
 +incdir+$(TB_DIR)/pkg \
 +incdir+$(TB_DIR)/top

###############################################################################
# Package & Source Ordering (CRITICAL)
###############################################################################
BASE_PKG := \
 $(INCLUDE_DIR)/package/ualink_upli_pkg.sv \
 $(SRC_DIR)/ualink_upli_transaction.svh \
 $(SRC_DIR)/ualink_upli_orignator_transaction.sv \
 $(SRC_DIR)/ualink_upli_completer_transaction.sv \
 $(SRC_DIR)/ualink_upli_config.sv \
 $(INCLUDE_DIR)/package/ualink_tl_pkg.sv \
 $(SRC_DIR)/ualink_tl_transaction.sv

TOP_SV := \
 $(TB_DIR)/top/ualink_upli_top.sv

###############################################################################
# Simulation Control
###############################################################################
UVM_TEST  ?= ualink_upli_base_test
TOP       := ualink_upli_top
VERBOSITY ?= UVM_LOW
TIMEOUT   ?= 20000
ITERATIONS ?= 1

SEEDS := $(shell shuf -i 1-100000 -n $(ITERATIONS))

###############################################################################
# Defines
###############################################################################
DEFINES := \
 +define+UALINK_UPLI \
 +define+UPLI_CLK_PERIOD_NS=10 \
 +define+UPLI_RESET_DEASSERT_NS=100 \
 +define+UVM_NO_DEPRECATED \
 +define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR \
 +error+20

###############################################################################
# Waveform Control
###############################################################################
ifdef FSDB
  DEFINES += +define+ENABLE_FSDB
endif

ifdef VCD
  DEFINES += +define+ENABLE_VCD
endif

###############################################################################
# Tool Detection (VCS)
###############################################################################
ifdef VCS_HOME
  ifndef UVM_HOME
    UVM := -ntb_opts uvm
  else
    UVM := +incdir+$(UVM_HOME)/src \
           $(UVM_HOME)/src/uvm_pkg.sv \
           $(UVM_HOME)/src/dpi/uvm_dpi.cc -CFLAGS -DVCS
  endif
else
  ERR_STATUS := 1
endif

###############################################################################
# Compile / Run Options
###############################################################################
COMP_OPTS := \
 -sverilog \
 -full64 \
 -timescale=1ns/1ps \
 -debug_access+all \
 -kdb \
 -l vcs_compile.log \
 $(UVM) \
 $(INCL) \
 $(DEFINES)
# $(BASE_PKG) \

RUN_OPTS := \
 +UVM_TESTNAME=$(UVM_TEST) \
 +UVM_VERBOSITY=$(VERBOSITY) \
 +UVM_TIMEOUT=$(TIMEOUT)

###############################################################################
# Targets
###############################################################################
all: check clean comp run

check:
ifdef ERR_STATUS
	@echo "ERROR: VCS_HOME is not set"
	@exit 1
endif

###############################################################################
# Compile
###############################################################################
comp:
	vcs $(COMP_OPTS) $(TOP_SV)

###############################################################################
# Run
###############################################################################
run:
	@for seed in $(SEEDS); do \
		echo "Running $(UVM_TEST) with SEED=$$seed"; \
		./simv -l $(UVM_TEST)_$$seed.log \
		 +ntb_random_seed=$$seed \
		 $(RUN_OPTS); \
	done

###############################################################################
# Wave Targets
###############################################################################
fsdb:
	$(MAKE) run FSDB=1

vcd:
	$(MAKE) run VCD=1

###############################################################################
# Regression
###############################################################################
REGRESS_TESTS := \
 ualink_upli_base_test \
 ualink_upli_back_to_back_test

regress: clean comp
	@for test in $(REGRESS_TESTS); do \
		for seed in $(SEEDS); do \
			mkdir -p $$test; \
			echo "Running $$test SEED=$$seed"; \
			./simv -l $$test/$$test_$$seed.log \
			 +ntb_random_seed=$$seed \
			 +UVM_TESTNAME=$$test \
			 +UVM_VERBOSITY=$(VERBOSITY) \
			 +UVM_TIMEOUT=$(TIMEOUT); \
		done \
	done

###############################################################################
# Clean
###############################################################################
clean:
	rm -rf simv* csrc *.log *.key *.fsdb *.vcd
	rm -rf work vcs_compile.log

###############################################################################
# Help
###############################################################################
help:
	@echo "UALINK UPLI VIP Makefile"
	@echo ""
	@echo "Targets:"
	@echo "  make comp          Compile only"
	@echo "  make run           Run single test"
	@echo "  make fsdb          Run with FSDB"
	@echo "  make vcd           Run with VCD"
	@echo "  make regress       Run regression"
	@echo "  make clean         Cleanup"
	@echo ""
	@echo "Variables:"
	@echo "  UVM_TEST=<test>"
	@echo "  VERBOSITY=UVM_LOW|UVM_MEDIUM|UVM_HIGH"
	@echo "  TIMEOUT=<cycles>"
	@echo "  ITERATIONS=<N>"
