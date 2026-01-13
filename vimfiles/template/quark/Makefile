# Build tools
QC := qc
CC := gcc

# Entry source
MAIN ?= main
MAIN_QK := src/$(MAIN).qk

# Test directory
TEST_DIR := tests

# Quark library path
QUARK_ROOT := $(QUARK_ROOT)

# Default build mode is debug
MODE ?= debug

# Default ARGS is empty
ARGS ?=

# Platform detection
UNAME_S := $(shell uname -s 2>/dev/null)
ifeq ($(OS),Windows_NT)
  PLATFORM := windows
else ifeq ($(UNAME_S),Darwin)
  PLATFORM := macos
else
  PLATFORM := linux
endif

# Executable suffix
ifeq ($(PLATFORM),windows)
  EXE := .exe
else
  EXE :=
endif

# Build flags
ifeq ($(MODE),debug)
  BUILD := build/debug
  CFLAGS := -O0 -g -Wall -Wextra
  ifneq ($(PLATFORM),windows)
    CFLAGS += -fsanitize=address
    LDFLAGS += -fsanitize=address
  endif
else
  BUILD := build/release
  CFLAGS := -O2 -Wall -Wextra
  LDFLAGS :=
endif

# Output paths
C_OUT := $(BUILD)/c
O_OUT := $(BUILD)/o
T_OUT := $(BUILD)/tests
TARGET := $(BUILD)/$(MAIN)$(EXE)

# Flatten path helper
FLAT = $(subst /,__,$(basename $1))

# Main generated files
MAIN_C := $(C_OUT)/$(call FLAT,$(MAIN_QK)).c
MAIN_O := $(O_OUT)/$(notdir $(MAIN_C:.c=.o))

# Test sources (recursive and sorted)
TEST_QK  := $(sort $(shell find $(TEST_DIR) -name '*.qk'))
TEST_C   := $(foreach f,$(TEST_QK),$(C_OUT)/$(call FLAT,$(f)).c)
TEST_O   := $(foreach f,$(TEST_C),$(O_OUT)/$(notdir $(f:.c=.o)))
TEST_BIN := $(foreach f,$(TEST_QK),$(T_OUT)/$(call FLAT,$(f))$(EXE))

# Default target
all: $(TARGET)

# Run main program with ARGS
run: $(TARGET)
	$(TARGET) $(ARGS)

# Link main executable
$(TARGET): $(MAIN_O)
	$(CC) $(MAIN_O) $(LDFLAGS) -o $@

# Generate C from main qk
$(MAIN_C): $(MAIN_QK)
	@mkdir -p $(C_OUT)
	$(QC) $< -o $@ -l $(QUARK_ROOT)

# Compile C to object
$(MAIN_O): $(MAIN_C)
	@mkdir -p $(O_OUT)
	$(CC) $(CFLAGS) -c $< -o $@

# Generic C compilation rule
$(O_OUT)/%.o: $(C_OUT)/%.c
	@mkdir -p $(O_OUT)
	$(CC) $(CFLAGS) -c $< -o $@

# Generate C from test qk
define QK_TO_C
$(C_OUT)/$(call FLAT,$(1)).c: $(1)
	@mkdir -p $(C_OUT)
	$(QC) $(1) -o $$@ -l $(QUARK_ROOT)
endef
$(foreach f,$(TEST_QK),$(eval $(call QK_TO_C,$(f))))

# Link test executables
define TEST_LINK
$(T_OUT)/$(call FLAT,$(1))$(EXE): $(O_OUT)/$(call FLAT,$(1)).o
	@mkdir -p $(T_OUT)
	$(CC) $$< $(LDFLAGS) -o $$@
endef
$(foreach f,$(TEST_QK),$(eval $(call TEST_LINK,$(f))))

# Build tests only
test: $(TEST_BIN)

# Build and run tests with ARGS
test-run: $(TEST_BIN)
	@set -e; \
	for t in $(TEST_BIN); do \
	  echo "==> $$t"; \
	  $$t $(ARGS); \
	done

# ----------------------------
# Shortcut targets for build modes
# ----------------------------

release:
	$(MAKE) MODE=release

debug:
	$(MAKE) MODE=debug

# Remove all build artifacts
clean:
	rm -rf build

.PHONY: all run test test-run clean release debug

