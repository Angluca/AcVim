CC = gcc
AR = ar
QC = qc
CFLAGS:= -Wall -Wextra -Wno-unused -Wno-switch -Wno-unused-parameter 
CFLAGS+= -Wno-missing-field-initializers -Wno-format-zero-length
CFLAGS+= -pipe -funsigned-char -std=c99 -O2 
CFLAGS+= 
LDFLAGS:= 
#---------------------------------
LIB_DIR:= lib
APP_NAME:= test
APP_DIR:= .
OS:= macos
# OS = macos/windows/linux/wasm or null
#=================================
ifdef test
APP_NAME= $(test)
APP_DIR= ./test
endif
APP=  $(APP_NAME)
ifneq ($(wildcard $(APP_DIR)),)
APP=  $(APP_DIR)/$(APP_NAME)
endif #==============================
#LIB= $(APP_DIR)/$(APP_NAME).a
LIB= $(APP).a
BUILD= $(APP_DIR)/build/$(APP_NAME)
#OBJS= $(BUILD).o
ifeq ($(OS),macos) # ------ macos
#CFLAGS+=
#FRAMEWORKS= -framework Cocoa \
			#-framework QuartzCore \
			#-framework OpenGL \
			#-framework AudioToolbox \
			#-framework AVFoundation \
			##-framework Metal \
			##-framework MetalKit \
			##-framework IOKit \
			##-framework Foundation
#------------------------------------
#LDFLAGS+= $(FRAMEWORKS)
endif #==============================
ifeq ($(OS),linux) #------- linux
#LDFLAGS+= -lX11 -lXi -lXcursor -ldl -lpthread -lm
endif #==============================
ifeq ($(OS),windows) #----- windows
LIB= $(APP).lib
APP+= .exe
#CFLAGS+=
#LDFLAGS+= -ldl -lpthread -lm
endif #==============================
ifeq ($(OS),wasm) #-------- wasm
#CFLAGS=
#CC= emcc
endif #==============================
ifeq ($(OS),) #------------ custom
#CFLAGS=
#CC=
endif #==============================

all: cc $(APP)

$(APP): $(BUILD).o
	$(CC) $(LDFLAGS) -o ./$@ ./$<

$(BUILD).o: $(BUILD).c
	$(CC) $(CFLAGS) -o ./$@ -c ./$<

$(LIB): $(BUILD).o
	$(AR) rcs $@ $^
	ranlib $@

lib:
ifeq ($(wildcard $(LIB)),)
	@make qc
	@make $(LIB)
endif #==============================
 
cc: qc
	$(info -------- system: $(OS) --------)

qc:
	@mkdir -p build
ifneq ($(wildcard $(APP_DIR)),)
	$(QC) $(APP).qk -o $(APP_DIR)/build/$(APP_NAME).c -l $(QUARK_ROOT)
else
	$(QC) ./main.qk -o ./build/main.c -l $(QUARK_ROOT)
endif #==============================

run: 
	@make 
	@cd ./$(APP_DIR) && ./$(APP_NAME)
	

clean:
	rm -rf $(APP) $(APP_DIR)/build/** $(LIB)

#cleanall:
	#@make clean
#ifneq ($(wildcard $(LIB)),)
	#@rm -i ./$(LIB) 
	#$(info "--- if you want del $(LIB) press [y] ---")
#endif #==============================
	

.PHONY: all clean cc run lib qc

