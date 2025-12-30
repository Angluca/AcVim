CC = clang
AR = ar
CFLAGS= -Wall -Wextra -Wno-unused -Wno-switch -Wno-unused-parameter 
CFLAGS+= -Wno-missing-field-initializers -Wno-format-zero-length
CFLAGS+= -pipe -funsigned-char -std=c99 -O2
CFLAGS+= -mmacosx-version-min=10.13 -target x86_64-apple-macos10.13 -fno-objc-arc
LDFLAGS= 
#---------------------------------\
https://github.com/floooh/sokol
# sokol_impl.c in LIB_DIR, build lib when hasn't libsokol.a
#LIB_SOURCE= ~/SDK/Sokols/sokol
LIB_SOURCE= ./c
LIB_DIR= lib
#APP_NAME= clear
#APP_DIR= examples/$(APP_NAME)
APP_NAME= main
APP_DIR= 
OS= macos
# OS = macos/windows/linux/wasm or null
#=================================
OBJS= $(LIB_DIR)/sokol_impl.o
SOKOLIB= $(LIB_DIR)/libsokol.a
CFLAGS+= -I $(LIB_SOURCE)
#LDFLAGS+= -L$(LIB_DIR) -lsokol
#------------------------------------
ifdef example
APP_NAME= $(example)
APP_DIR= examples/$(example)
endif
APP=  $(APP_NAME)
CGEN= 
ifneq ($(wildcard $(APP_DIR)),)
APP=  $(APP_DIR)/$(APP_NAME)
CGEN= $(APP_DIR)
endif #==============================
ifeq ($(OS),macos) # ------ macos
CFLAGS+= -x objective-c -DSOKOL_GLCORE  # -arch x86_64
FRAMEWORKS= -framework Cocoa \
			-framework OpenGL \
			-framework IOKit \
			-framework AudioToolbox \
			#-framework AVFoundation \
			#-framework QuartzCore \
			#-framework Foundation
			#-framework Metal \
			#-framework MetalKit
#------------------------------------
BUILD= $(CGEN)
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

#all: cc $(APP)
all: cc

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
	nature build --ldflags '$(LDFLAGS)' -o ./$(APP) ./$(APP_DIR)/main.n
else
	nature build --ldflags '$(LDFLAGS)' main.n
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
	@make 
	@cd ./$(APP_DIR) && ./$(APP_NAME)

clean:
	rm -rf ./$(APP) ./$(OBJS)

cleanall:
	make clean
	@rm -i ./$(SOKOLIB) 
	$(info "--- if you want del libsokol.a press [y] ---")

define cglsl
	$(info ------ build glsl: $1 ------)
	sokol-shdc -i $1 -o ./$1.c2 -l $2 -f sokol_nature
endef

.PHONY: all clean cleanall cc run getlib

