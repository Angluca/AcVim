CXX=g++
CC=gcc
CXXINCS =  -I"C:\MinGW\include\c++\3.4.5"  -I"C:\MinGW\include\c++\3.4.5\backward"  -I"C:\MinGW\include\c++\3.4.5\mingw32\bits"  -I"C:\MinGW\include\GL"  -I"C:\MinGW\include"  -I"C:\MinGW\include\GL"
LIBS =  -L"C:\MinGW\lib" -lglut32 -lopengl32 -lglu32 -lglew32 #-lglaux 
CXXFLAGS =
OUT_OPTION= -o $@
COMPLIT_BIN= $(CXX) -O3 $(OUT_OPTION) $^ $(LIBS)
COMPLIT_CXX= $(CXX) -c $(CXXFLAGS) $< $(OUT_OPTION) $(CXXINCS)
SRCS:= $(wildcard *.cpp)
BIN:= $(patsubst %.cpp,%.exe,$(SRCS))
all: $(BIN)

%.exe: %.o
	$(COMPLIT_BIN)

#$(BIN):%.exe: %.o
	#$(COMPLIT_BIN)
#$(IMAGING_SUBSET):%.exe: %.o readimage.o
	#$(COMPLIT_BIN)

#include $(SRCS:.cpp=.d)
%.d: %.cpp
	set -e; rm -f $@; \
	$(CXX) -M $(CXXFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$ *.d \

clean:
	rm  *.o $(BIN) *.d
.PHONY: clean
