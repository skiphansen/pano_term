include $(dir $(abspath $(lastword $(MAKEFILE_LIST))))/common.mk
###############################################################################
# Variables
###############################################################################
VERILATOR_SRC ?= /usr/share/verilator/include
SYSTEMC_HOME  ?= /usr/local/systemc-2.3.1

OBJ_DIR      ?= obj/
EXE_DIR      ?= build/
SRC_DIR      ?= ./

TARGET       ?= test.x

# Additional include directories
INCLUDE_PATH ?=
INCLUDE_PATH += $(SRC_DIR)
INCLUDE_PATH += ./verilated
INCLUDE_PATH += $(CPU_CORE_DIR)/isa_sim
INCLUDE_PATH += $(VERILATOR_SRC)
INCLUDE_PATH += $(VERILATOR_SRC)/vltstd
INCLUDE_PATH += $(SYSTEMC_HOME)/include

# Dependancies
LIB_PATH     ?=
LIB_PATH     += ./lib 
LIB_PATH     += $(CPU_CORE_DIR)/isa_sim
LIBS          = -lisa_sim -lsyscverilated -lelf -lbfd

# Flags
CFLAGS       ?= -fpic -O2
CFLAGS       += $(patsubst %,-I%,$(INCLUDE_PATH))
CFLAGS       += -DVM_TRACE=1
LDFLAGS      ?= -O2
LDFLAGS      += -L$(SYSTEMC_HOME)/lib-linux64 
LDFLAGS      += $(patsubst %,-L%,$(LIB_PATH))

EXTRA_CLEAN_FILES ?=

# SRC / Object list
src2obj       = $(OBJ_DIR)$(patsubst %$(suffix $(1)),%.o,$(notdir $(1)))
SRC          ?= $(foreach src,$(SRC_DIR),$(wildcard $(src)/*.cpp))
OBJ          ?= $(foreach src,$(SRC),$(call src2obj,$(src)))

###############################################################################
# Rules
###############################################################################
define template_c
$(call src2obj,$(1)): $(1) | $(OBJ_DIR)
	g++ $(CFLAGS) -c $$< -o $$@
endef

all: $(EXE_DIR)$(TARGET)

$(OBJ_DIR) $(EXE_DIR):
	mkdir -p $@

$(foreach src,$(SRC),$(eval $(call template_c,$(src))))

$(EXE_DIR)$(TARGET): $(OBJ) | $(EXE_DIR) 
	g++ $(LDFLAGS) $(OBJ) -o $@ -lsystemc -lpthread $(LIBS)

clean:
	-rm -rf $(EXE_DIR) $(OBJ_DIR) $(EXTRA_CLEAN_FILES)
