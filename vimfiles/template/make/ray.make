# Makefile for compiling web build of the Zig Raylib WASM game
#
# Using `bash -c` anywhere is janky, but the alternative is to source the env
# in your shell before calling `make`?? I haven't seen anyone with a resonable
# setup that just allows you to call `make`. Everything assumes that you manually
# activate the environment. That seems very much against the spirit of Makefiles.
#
# ===== Please Note =====
#
# This makefile is _intentionally_ dumb. It works. It's simple and stupid. So
# many makefiles for WASM/emscripten don't work because they try to be too fancy.
# Who cares that the Makefile is super generic if it doesn't work in the first
# place? Instead, the Makefile is an example the distills everything to the bone.
# If you can't get this working you _for sure_ can't get those more complicated
# examples working.
#
# Take this, use it, learn from it, then make it what you actually want.
#
# Yes, it forces you to take a bunch of steps on your own, but _it at least gives
# you the chance of taking that first step_.


# Update this to your actual emscripten path
EMSDK_PATH := $(HOME)/Github/emsdk
EM_SYSROOT := $(EMSDK_PATH)/upstream/emscripten/cache/sysroot
#CFLAGS += -O2 --memory-init-file 0
#CFLAGS += -DRAYGUI_IMPLEMENTATION
LDFLAGS += -sUSE_GLFW=3 -sFORCE_FILESYSTEM=1 -sASYNCIFY 
LDFLAGS += -DPLATFORM_WEB -sUSE_OFFSET_CONVERTER
LDFLAGS += -s EXPORTED_RUNTIME_METHODS=ccall
#LDFLAGS += -sTOTAL_MEMORY=16mb
LDFLAGS += -sTOTAL_MEMORY=64mb
LDFLAGS += --shell-file raylib/src/minshell.html
LDFLAGS += --preload-file assets

dev: web

release: release/mygame.zip

release/game.zip: web
	mkdir -p release
	cp -R assets build/assets
	zip -r -9 release/game.zip build/index.html build/index.js build/index.wasm build/index.data build/assets

web: build/index.html

build/index.html: build/libraylib.a src/main.zig raylib/src/minshell.html
	zig build-obj libs/libs.c -target wasm32-emscripten -O ReleaseSmall -I. -Iraylib/src -Iraylib/src/external -I$(EM_SYSROOT)/include -Ilibs/raylib -lc -femit-bin=build/libs.o 
	zig build-obj src/main.zig -target wasm32-emscripten -O ReleaseSmall -I. -Iraylib/src -Iraylib/src/external -I$(EM_SYSROOT)/include -Ilibs/raylib -lc -femit-bin=build/main.o 
	zsh -c 'source $(EMSDK_PATH)/emsdk_env.sh && emcc -o build/index.html build/libs.o build/main.o -Lbuild -lraylib -Lraylib/src -Iraylib/src -lidbfs.js $(LDFLAGS)'

# # Here's the sort of approach you'd want to take to make this generic
#
# RAYLIB_SOURCES = $(wildcard raylib/src/*.c)
# RAYLIB_OBJECTS = $(RAYLIB_SOURCES:raylib/src/%.c=build/%.o)
# 
# build/libraylib.a: $(RAYLIB_OBJECTS)
# 	mkdir -p build
# 	bash -c 'source $(EMSDK_PATH)/emsdk_env.sh && emar rcs $@ $(RAYLIB_OBJECTS)'
# 
# build/%.o: raylib/src/%.c
# 	mkdir -p build
# 	bash -c 'source $(EMSDK_PATH)/emsdk_env.sh && emcc -o $@ -c $< -Os -Wall -DPLATFORM_WEB -DGRAPHICS_API_OPENGL_ES2'

build/libraylib.a:
	mkdir -p build
	zsh -c 'source $(EMSDK_PATH)/emsdk_env.sh && emcc -o build/rcore.o -c raylib/src/rcore.c -Os -Wall -DPLATFORM_WEB -DGRAPHICS_API_OPENGL_ES2'
	zsh -c 'source $(EMSDK_PATH)/emsdk_env.sh && emcc -o build/rshapes.o -c raylib/src/rshapes.c -Os -Wall -DPLATFORM_WEB -DGRAPHICS_API_OPENGL_ES2'
	zsh -c 'source $(EMSDK_PATH)/emsdk_env.sh && emcc -o build/rtextures.o -c raylib/src/rtextures.c -Os -Wall -DPLATFORM_WEB -DGRAPHICS_API_OPENGL_ES2'
	zsh -c 'source $(EMSDK_PATH)/emsdk_env.sh && emcc -o build/rtext.o -c raylib/src/rtext.c -Os -Wall -DPLATFORM_WEB -DGRAPHICS_API_OPENGL_ES2'
	zsh -c 'source $(EMSDK_PATH)/emsdk_env.sh && emcc -o build/rmodels.o -c raylib/src/rmodels.c -Os -Wall -DPLATFORM_WEB -DGRAPHICS_API_OPENGL_ES2'
	zsh -c 'source $(EMSDK_PATH)/emsdk_env.sh && emcc -o build/utils.o -c raylib/src/utils.c -Os -Wall -DPLATFORM_WEB'
	zsh -c 'source $(EMSDK_PATH)/emsdk_env.sh && emcc -o build/raudio.o -c raylib/src/raudio.c -Os -Wall -DPLATFORM_WEB'
	zsh -c 'source $(EMSDK_PATH)/emsdk_env.sh && emar rcs build/libraylib.a build/rcore.o build/rshapes.o build/rtextures.o build/rtext.o build/rmodels.o build/utils.o build/raudio.o'

run:
	make && emrun ./build/index.html

clean:
	rm -rf build

.PHONY: dev release clean run
