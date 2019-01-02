#!/bin/make -f

all: clean SetDisplayResolution
	
SetDisplayResolution:
	llvm-g++ -arch x86_64 -o $@ -framework Foundation -framework ApplicationServices -framework AppKit -framework IOKit $< main.mm cmdline.mm utils.mm

install: SetDisplayResolution
	install SetDisplayResolution /usr/local/bin

uninstall:
	-rm /usr/local/bin/SetDisplayResolution

clean:
	-rm SetDisplayResolution

.PHONY: all clean install
