CFLAGS += -Iraylib/include

LDFLAGS += -Lraylib/lib -lraylib \
	-framework Cocoa \
	-framework IOKit \
	-framework AudioToolbox \
	#-framework CoreGraphics \
	#-framework CoreFoundation \
	#-framework AppKit \
	#-framework OpenGL \
	#-framework AudioUnit \
	#-framework Foundation \
	#-lobjc \
	##-x objective-c 

debug:
	#axe main.axe -o main $(CFLAGS) $(LDFLAGS) 
	axe main.axe -c $(CFLAGS)
	gcc main.o -o main $(LDFLAGS)
	./main

release:
	axe main.axe -c $(CFLAGS) --release
	gcc main.o -o main $(LDFLAGS) -O2
	./main

