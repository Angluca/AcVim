CC = gcc
AR = ar
CFLAGS= -Wall -Wextra -Wno-unused -Wno-switch -Wno-unused-parameter 
CFLAGS+= -Wno-missing-field-initializers -Wno-format-zero-length
CFLAGS+= -pipe -funsigned-char -std=c99 -O2 
CFLAGS+= 
LDFLAGS= 
#---------------------------------\
https://github.com/floooh/sokol
# sokol_impl.c in LIB_DIR, build lib when hasn't libsokol.a
LIB_SOURCE= ~/SDK/Sokols/sokol
LIB_DIR= lib
APP_NAME= cube
APP_DIR= examples/$(APP_NAME)
OS= macos
# OS = macos/windows/linux/wasm or null
#=================================
OBJS= $(LIB_DIR)/sokol_impl.o
SOKOLIB= $(LIB_DIR)/libsokol.a
CFLAGS+= -I $(LIB_SOURCE)
LDFLAGS+= -L $(LIB_DIR) -lsokol
#------------------------------------
ifdef example
APP_NAME= $(example)
APP_DIR= examples/$(example)
endif
APP=  $(APP_NAME)
CGEN= output/$(APP_NAME)/cgen
ifneq ($(wildcard $(APP_DIR)),)
APP=  $(APP_DIR)/$(APP_NAME)
CGEN= $(APP_DIR)/output/$(APP_NAME)/cgen
endif #==============================
ifeq ($(OS),macos) # ------ macos
CFLAGS+= -x objective-c -DSOKOL_GLCORE  # -arch x86_64
FRAMEWORKS= -framework Cocoa \
			-framework QuartzCore \
			-framework OpenGL \
			-framework AudioToolbox \
			-framework AVFoundation \
			#-framework Metal \
			#-framework MetalKit \
			#-framework IOKit \
			#-framework Foundation
#------------------------------------
BUILD= $(CGEN)/build
LDFLAGS+= $(FRAMEWORKS)
endif #==============================
ifeq ($(OS),linux) #------- linux
CFLAGS+= -DSOKOL_GLCORE
LDFLAGS+= -lGL -lX11 -lXi -lXcursor -ldl -lpthread -lm
endif #==============================
ifeq ($(OS),windows) #----- windows
CFLAGS+= -DSOKOL_GLCORE
LDFLAGS+= -lGL -ldl -lpthread -lm
endif #==============================
ifeq ($(OS),wasm) #-------- wasm
CFLAGS= -DSOKOL_GLES3 -s USE_WEBGL2=1 
CC= emcc
endif #==============================
ifeq ($(OS),) #------------ custom
CFLAGS= -DSOKOL_GLES3 
CC=
endif #==============================

all: cc $(APP)

$(APP): $(BUILD).o getlib
	$(CC) $(LDFLAGS) -o ./$@ ./$<

$(BUILD).o: $(BUILD).c
	$(CC) $(CFLAGS) -o ./$@ -c ./$<

$(SOKOLIB): $(OBJS)
	$(AR) rcs $@ $^
	ranlib $@

getlib:
ifeq ($(wildcard $(SOKOLIB)),)
	@make $(SOKOLIB)
endif #==============================
	#$(eval $(call))
 
cc:
	$(info -------- system: $(OS) --------)
ifneq ($(wildcard $(APP).glsl),)
	make build_glsl
endif #==============================

ifneq ($(wildcard $(APP_DIR)),)
	c2c -d ./$(APP_DIR)
else
	c2c 
endif #==============================

SOKOL_EXISTS := $(shell command -v sokol-shdc 2>/dev/null) 
build_glsl:
ifneq ($(wildcard $(SOKOL_EXISTS)),)
ifdef glsl
	$(call cglsl,./$(APP_DIR)/$(glsl).glsl,glsl410:hlsl4:metal_macos)
else
	$(call cglsl,./$(APP).glsl,glsl410:hlsl4:metal_macos)
endif
endif #==============================

run: 
	@make && ./$(APP)

clean:
	rm -rf ./$(APP) ./$(APP_DIR)/output ./$(OBJS)

cleanall:
	make clean
	@rm -i ./$(SOKOLIB) 
	$(info "--- if you want del libsokol.a press [y] ---")

define cglsl
	$(info ------ build glsl: $1 ------)
	sokol-shdc -i $1 -o ./$1.c2 -l $2 -f sokol_c2
endef

.PHONY: all clean cleanall cc run getlib

