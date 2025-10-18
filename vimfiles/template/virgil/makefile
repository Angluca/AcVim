# make NAME=xxx.v3
TARGET= x86-64-darwin
#DEPS= $(shell echo ${VIRGIL_LOC}/lib/util/*.v3)
#SRC= $(shell echo ./*.v3)
#OUT= $(basename $(SRC))
SRC=
DEPS= $(wildcard $(shell cat DEPS))
LIBS=
OPTS=
OUT=
SOURCES= $(DEPS) $(SRC)
all: $(OUT)

#v3c -target=$(TARGET) $(OPTS) $(LIBS) $(SOURCES) -output=$(OUT)
build:
	v3c $(OPTS) $(LIBS) $(SOURCES) -output=$(OUT)
test:
	@v3i $(OPTS) $(LIBS) $(SOURCES)

.PHONY: all build test

