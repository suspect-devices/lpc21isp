all:      lpc21isp

GLOBAL_DEP  = adprog.h lpc21isp.h lpcprog.h lpcterm.h
# TODO use environment's chosen gcc or check for clang 
CC = gcc
CFLAGS	+= -Wall

ifneq ($(findstring(freebsd, $(OSTYPE))),)
CFLAGS+=-D__FREEBSD__
CFLAGS	+= -static
endif

ifeq ($(OSTYPE),)
OSTYPE		= $(shell uname)
endif

ifneq ($(findstring Darwin,$(OSTYPE)),)
CFLAGS+=-D__APPLE__
endif


adprog.o: adprog.c $(GLOBAL_DEP)
	$(CC) $(CDEBUG) $(CFLAGS) -c -o adprog.o adprog.c

lpcprog.o: lpcprog.c $(GLOBAL_DEP)
	$(CC) $(CDEBUG) $(CFLAGS) -c -o lpcprog.o lpcprog.c

lpcterm.o: lpcterm.c $(GLOBAL_DEP)
	$(CC) $(CDEBUG) $(CFLAGS) -c -o lpcterm.o lpcterm.c

lpc21isp: lpc21isp.c adprog.o lpcprog.o lpcterm.o $(GLOBAL_DEP)
	$(CC) $(CDEBUG) $(CFLAGS) -o lpc21isp.out lpc21isp.c adprog.o lpcprog.o lpcterm.o

clean:
	$(RM) adprog.o lpcprog.o lpcterm.o lpc21isp
