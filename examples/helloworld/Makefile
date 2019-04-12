TOOLCHAIN_DIR := ../..
WINE_PREFIX = $(realpath $(TOOLCHAIN_DIR)/wineprefix)
WINE = WINEARCH=win32 WINEPREFIX=$(WINE_PREFIX) wine
CC88 = $(WINE) $(TOOLCHAIN_DIR)/c88tools/bin/cc88
LC88 = $(WINE) $(TOOLCHAIN_DIR)/c88tools/bin/lc88

TARGET=helloworld

SOURCES = src/cstart.c src/main.c
OBJECTS = $(SOURCES:.c=.obj)

all: $(TARGET).abs

%.abs %.map: %.out
	$(LC88) -d pokemini -M -o $@ $<

$(TARGET).out: $(OBJECTS)
	$(CC88) -Ml -cl -v -o $@ $^

%.obj: %.c
	$(CC88) -Ml -c -v -I$(TOOLCHAIN_DIR)/include -o $@ $<

.PHONY: clean
clean:
	rm -f $(OBJECTS) $(TARGET).out $(TARGET).abs $(TARGET).map
