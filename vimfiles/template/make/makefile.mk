CXX=g++
CC=gcc
CXXINCS =  -I"C:\MinGW\include\c++\3.4.5"  -I"C:\MinGW\include\c++\3.4.5\backward"  -I"C:\MinGW\include\c++\3.4.5\mingw32\bits"  -I"C:\MinGW\include\GL"  -I"C:\MinGW\include"  -I"C:\MinGW\include\GL"
LIBS =  -L"C:\MinGW\lib" -mwindows -lopengl32 -lglu32 #-lglaux 
CXXFLAGS =
OUT_OPTION= -o  $(OUTFLAGS) $@
COMPLIT_BIN= $(CXX) -O3 $(OUT_OPTION) $^ $(LIBS)
COMPLIT_CXX= $(CXX) -c $(CXXFLAGS) $< $(OUT_OPTION) $(CXXINCS)
SRCS = $(wildcard *.cpp)
OBJ=$(patsubst %.cpp,%.o,$(SRCS))
BIN=Mytest.exe

all: $(BIN)

$(BIN): $(OBJ)
	$(COMPLIT_BIN)

#include $(SOURCS:.c=.d)
%.d: %.cpp
	set -e; rm -f $@; \
	$(CXX) -MM $(CXXFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$

clean:
	rm *.o
cleanall:
	rm  *.o $(BIN)
.PHONY: clean cleanall
