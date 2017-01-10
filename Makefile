#!/bin/make -f

all: clean SetDisplayResolution
	
SetDisplayResolution:
	g++ -Wall -o $@ -framework Foundation -framework ApplicationServices -framework IOKit $< main.mm cmdline.mm utils.mm

install: SetDisplayResolution
	install SetDisplayResolution /usr/local/bin

uninstall:
	-rm /usr/local/bin/SetDisplayResolution

clean:
	-rm SetDisplayResolution

.PHONY: all clean install
