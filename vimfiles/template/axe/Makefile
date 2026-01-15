# ===== Config =====

AXE_ROOT ?= $(HOME)/SDK/Axes/_axe
AXE_BIN  := $(AXE_ROOT)/axe
INSTALL  := install -m 755

AXE_BOOTSTRAP := axe-bootstrap
AXE			  := axe
SAW           := saw
AXEDOC        := axedoc
AXELS         := axels
AXE_COMPILER  := $(AXE)/source/compiler

# ===== Toolchain =====

CC := $(shell command -v clang >/dev/null 2>&1 && echo clang || echo cc)

HAS_LDCONFIG := $(shell command -v ldconfig >/dev/null 2>&1 && echo yes || echo no)

ifeq ($(HAS_LDCONFIG),yes)
  ifneq ($(shell ldconfig -p 2>/dev/null | grep -q libexecinfo && echo yes),)
    BOOTSTRAP_LIBS := -lexecinfo
  endif
endif

BOOTSTRAP_CFLAGS := -fmax-errors=1 -Wno-everything

# ===== Targets =====

.PHONY: all build update clean bootstrap axe saw axedoc axels

all: build

build: bootstrap axe saw axedoc axels

# ===== Update =====

update:
	@echo "-- Update axe-bootstrap"
	git -C $(AXE_BOOTSTRAP) pull
	@echo "-- Update axe"
	git -C $(AXE) pull
	@echo "-- Update saw"
	git -C $(SAW) pull
	@echo "-- Update axedoc"
	git -C $(AXEDOC) pull
	@echo "-- Update axels"
	git -C $(AXELS) pull

# ===== Rules =====

bootstrap:
	@echo "-- Build bootstrap --"
	$(CC) $(AXE_BOOTSTRAP)/axc.c \
	      -o $(AXE_BOOTSTRAP)/axe \
	      $(BOOTSTRAP_LIBS) $(BOOTSTRAP_CFLAGS)
	$(INSTALL) $(AXE_BOOTSTRAP)/axe $(AXE_ROOT)/_axe
	rm -f $(AXE_BOOTSTRAP)/axe
	@echo "-- bootstrap ok --"

axe:
	@echo "-- Build axe --"
	$(AXE_ROOT)/_axe $(AXE_COMPILER)/axc.axe --release
	$(INSTALL) $(AXE_COMPILER)/axc $(AXE_BIN)
	rm -f $(AXE_COMPILER)/axc
	rm -rf $(AXE_COMPILER)/axc.dSYM
	@echo "-- axe ok --"

saw:
	@echo "-- Build saw --"
	axe $(SAW)/saw --release
	$(INSTALL) $(SAW)/saw $(AXE_ROOT)/saw
	rm -f $(SAW)/saw
	@echo "-- saw ok --"

axedoc:
	@echo "-- Build axedoc --"
	axe $(AXEDOC)/axedoc --release -lpcre
	$(INSTALL) $(AXEDOC)/axedoc $(AXE_ROOT)/axedoc
	rm -f $(AXEDOC)/axedoc
	@echo "-- axedoc ok --"

axels:
	@echo "-- Build axels --"
	dmd -O -release -inline \
	    $(AXELS)/source/axels/main.d \
	    -of=$(AXELS)/axels
	$(INSTALL) $(AXELS)/axels $(AXE_ROOT)/axels
	rm -f $(AXELS)/axels $(AXELS)/axels.o
	@echo "-- axels ok --"

clean:
	rm -rf \
	$(AXE_COMPILER)/axc \
	$(AXE_COMPILER)/axc.dSYM \
	$(SAW)/saw \
	$(AXEDOC)/axedoc \
	$(AXELS)/axels \
	$(AXELS)/axels.o

