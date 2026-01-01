CC = gcc
AR = ar
QC = qc
CFLAGS:= -Wall -Wextra -Wno-unused -Wno-switch -Wno-unused-parameter 
CFLAGS+= -Wno-missing-field-initializers -Wno-format-zero-length
CFLAGS+= -pipe -funsigned-char -std=c99 -O2 
LDFLAGS:=

#-- allegro5 ----
CFLAGS+= -I../../allegro5/include
LDFLAGS+= -L../../allegro5/lib 
LDFLAGS+= -lallegro_main-static -lallegro_image-static -lallegro_primitives-static -lallegro_color-static -lallegro-static  -lallegro_font-static -lallegro_dialog-static -lallegro_audio-static -lallegro_acodec-static
LDFLAGS+= -lpng -lwebp -ljpeg -lFLAC -lvorbisfile -lvorbis -logg -lopusfile -lopus
#---------------------------------
LIB_DIR:= lib
APP_NAME:= mytest
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
FRAMEWORKS= -framework Cocoa \
			-framework QuartzCore \
			-framework OpenGL \
			-framework AudioToolbox \
			-framework IOKit \
			-framework OpenAL \
			-framework CoreAudio \
			-framework UniformTypeIdentifiers \
			-framework Carbon
#------------------------------------
LDFLAGS+= $(FRAMEWORKS)
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
#all: $(APP)

$(APP): $(BUILD).o
	$(CC) $(LDFLAGS) -o ./$@ ./$<

$(BUILD).o: $(APP).c
	$(CC) $(CFLAGS) -o ./$@ -c ./$<

$(LIB): $(BUILD).o
	$(AR) rcs $@ $^
	ranlib $@

lib:
ifeq ($(wildcard $(LIB)),)
	@make qc
	@make $(LIB)
endif #==============================
 
cc: 
	$(info -------- system: $(OS) --------)
#$(CC) $(CFLAGS) $(LDFLAGS) -o $(APP) $(APP).c
	@mkdir -p build
	@$(CC) $(CFLAGS) -c -o $(BUILD).o $(APP).c 

qc:
	@mkdir -p build
ifneq ($(wildcard $(APP_DIR)),)
	#$(QC) $(APP).qk -o $(APP_DIR)/build/$(APP_NAME).c -l $(QUARK_ROOT)
else
	#$(QC) ./main.qk -o ./build/main.c -l $(QUARK_ROOT)
endif #==============================

run: 
	@make 
	@cd ./$(APP_DIR) && ./$(APP_NAME)
	

clean:
	rm -rf $(APP) $(APP_DIR)/build/**

#cleanall:
#@make clean
#ifneq ($(wildcard $(LIB)),)
#@rm -i ./$(LIB) 
#$(info "--- if you want del $(LIB) press [y] ---")
#endif #==============================
	

.PHONY: all clean cc run lib qc

