CC      := gcc
SRC_DIR := .
BUILD   := build
BIN     := mytest

SRCS := $(wildcard $(SRC_DIR)/*.c)
OBJS := $(patsubst $(SRC_DIR)/%.c,$(BUILD)/%.o,$(SRCS))
#OBJS := $(SRCS:.c=.o)
#OBJS := $(shell find src/ -name '*.c' | sed -e 's/\.c$$/.o/g')
#OBJS := $(shell find $(SRC_DIR) -name '*.c' | sed -e 's/\.c$$/.o/g')

CFLAGS:= -Wall -Wextra -Wno-unused -Wno-switch -Wno-unused-parameter 
CFLAGS+= -Wno-missing-field-initializers -Wno-format-zero-length
CFLAGS+= -pipe -funsigned-char -std=c99 -O2 

CFLAGS+= -I../../allegro5/include
LDFLAGS:= -L../../allegro5/lib

LDFLAGS += \
	-lallegro_main-static \
	-lallegro_image-static \
	-lallegro_primitives-static \
	-lallegro_color-static \
	-lallegro_font-static \
	-lallegro_dialog-static \
	-lallegro_audio-static \
	-lallegro_acodec-static \
	-lallegro-static

LDFLAGS += \
	-lpng -lwebp -ljpeg \
	-lFLAC -lvorbisfile -lvorbis -logg \
	-lopusfile -lopus \
	-lz

FRAMEWORKS += \
	-framework Cocoa \
	-framework QuartzCore \
	-framework OpenGL \
	-framework AudioToolbox \
	-framework CoreAudio \
	-framework OpenAL \
	-framework IOKit \
	-framework UniformTypeIdentifiers \
	-framework Carbon

all: $(BIN)

$(BIN): $(OBJS)
	@mkdir -p $(dir $@)
	$(CC) $(OBJS) $(LDFLAGS) $(FRAMEWORKS) -o $@

$(BUILD)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

run: 
	@make && ./$(BIN)

clean:
	rm -rf $(BUILD) $(BIN) $(SRC_DIR)/*.o

.PHONY: all clean

