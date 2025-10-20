# node $VIRGIL_LOC/rt/wasm-wave/wave.node.js test.wasm
# make NAME=xxx.v3
#TARGET: x86-64-darwin x86-64-linux jar wasm x86-darwin x86-linux
TARGET= x86-64-darwin
#DEPS= $(shell echo ${VIRGIL_LOC}/lib/util/*.v3)
#APP= $(basename $(SRC))
#SRC= $(shell echo ./*.v3)
#OUT= /tmp/virgil
DEPS= $(wildcard $(shell cat DEPS))
SRC=
LIBS=
OPTS=
NAME=
SOURCES= $(DEPS) $(SRC)
APP= $(basename $(SRC))
ifneq ($(NAME),)
APP= ./$(NAME)
endif
ifeq ($(APP),)
APP= ./main
endif

all:
	make build

build:
	v3c-host --target=$(TARGET) -program-name=$(APP) $(OPTS) $(LIBS) $(SOURCES) 
test:
	@v3i $(OPTS) $(LIBS) $(SOURCES)
run:
	@v3c-host --target=$(TARGET) -program-name=$(APP) $(OPTS) $(LIBS) $(SOURCES)
	@$(APP)
clean:
	@trash ./$(APP) ./$(APP).jar
#@make build 
.PHONY: all build test run clean

