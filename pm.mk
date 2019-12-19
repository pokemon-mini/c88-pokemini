## Copyright 2019 Jose I Romero
##
## Permission to use, copy, modify, and/or distribute this software
## for any purpose with or without fee is hereby granted, provided
## that the above copyright notice and this permission notice appear
## in all copies.
##
## THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
## WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
## WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
## AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
## DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA
## OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
## TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
## PERFORMANCE OF THIS SOFTWARE.

ifeq ($(OS), Windows_NT)
	WINE :=
	POKEMINID := $(TOOLCHAIN_DIR)/bin-windows/PokeMiniD
	SREC_CAT := $(TOOLCHAIN_DIR)/bin-windows/srec_cat
	POKEFLASH := $(TOOLCHAIN_DIR)/bin-windows/pokeflash
else # In Unix we use wine and assume the tools are in the PATH
	WINE_PREFIX := $(realpath $(TOOLCHAIN_DIR)/wineprefix)
	WINE := WINEARCH=win32 WINEPREFIX=$(WINE_PREFIX) wine
	SREC_CAT := srec_cat
	POKEMINID := PokeMiniD
	POKEFLASH := pokeflash
endif

C88_DIR := $(TOOLCHAIN_DIR)/c88tools/bin
C88 := $(WINE) $(C88_DIR)/c88
CC88 := $(WINE) $(C88_DIR)/cc88
LC88 := $(WINE) $(C88_DIR)/lc88

LDFLAGS := -M
CFLAGS := -M

ifdef $(MEM_MODEL)
	LDFLAGS += $(MEM_MODEL)
	CFLAGS += $(MEM_MODEL)
else
	LDFLAGS += -Md
	CFLAGS += -Md
endif

LDFLAGS += -cl -v
CFLAGS += -g -I$(TOOLCHAIN_DIR)/include
LCFLAGS += -e -d pokemini -M

OBJS += $(C_SOURCES:.c=.obj)
OBJS += $(ASM_SOURCES:.asm=.obj)
COMPILED_ASM = $(C_SOURCES:.c=.c.asm)

.SUFFIXES:

.PHONY: all, run, assembly
all: $(TARGET).min

assembly: $(COMPILED_ASM)

run: $(TARGET).min
	$(POKEMINID) $<

flash: $(TARGET).min
	$(POKEFLASH) /w $<

%.min: %.hex
	$(SREC_CAT) $< -o $@ -binary

%.hex %.map: %.out
	$(LC88) $(LCFLAGS) -f2 -o $@ $<

%.abs %.map: %.out
	$(LC88) $(LCFLAGS) -o $@ $<

$(TARGET).out: $(OBJS)
	$(CC88) $(LDFLAGS) -o $@ $^

%.c.asm: %.c
	$(C88) $(CFLAGS) -v -o $@ $<

%.obj: %.asm
	$(CC88) $(CFLAGS) -Tc-v -c -v -o $@ $<

%.obj: %.c
	$(CC88) $(CFLAGS) -Tc-v -c -v -o $@ $<

.PHONY: clean
clean:
	rm -f $(OBJS)
	rm -f $(TARGET).out $(TARGET).abs $(TARGET).map $(TARGET).hex
	rm -f $(TARGET).min
	rm -f $(COMPILED_ASM)
