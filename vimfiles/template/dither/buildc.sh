CFLAGS="$CFLAGS $(clang -c $DITHER_ROOT/std/gui/impl_cocoa.m) $DITHER_ROOT/std/gui/impl_cocoa.o -framework Cocoa"

APP=$@
gcc -O2 $APP.c $CFLAGS -lm \
  -include $DITHER_ROOT/build/config.h -I. \
  -framework Cocoa \
  -framework OpenGL \
  -framework CoreGraphics \
  -framework AudioToolbox -framework AudioUnit \
  -o $APP

# CFLAGS.txt in std/dirs
# ./buildc appname
