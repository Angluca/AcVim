CC= gcc

TARGET:=  myapp

CFLAGS:= -g -Wall 

LDFLAGS:= -pthread 

all: $(TARGET)

$(TARGET):  $(TARGET).o
	$(CC) -o $@ $^  $(LDFLAGS) $(CFLAGS)
cc:
	$(CC) -c -o $*.o $(CFLAGS) $*.c


clean:
	rm -f *.o $(TARGET) 
