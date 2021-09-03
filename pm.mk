## Copyright 2019 Jose I Romero
## Copyright 2021 Sapphire Becker
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

# Use this to build with WINE: mk88 WINE=1
ifdef WINE
WINE_PREFIX := $(realpath $(PRODDIR)/../wineprefix)
WINE := WINEARCH=win32 WINEPREFIX=$(WINE_PREFIX) wine
else
WINE :=
endif

# You must define these in the PATH
SREC_CAT := srec_cat
POKEMINID := PokeMiniD

C88_DIR := $(PRODDIR)/bin
C88 := $(separate " " $(WINE) $(C88_DIR)/c88.exe)
CC88 := $(separate " " $(WINE) $(C88_DIR)/cc88.exe)
LC88 := $(separate " " $(WINE) $(C88_DIR)/lc88.exe)

RM := $(exist /bin/rm rm -f)$(nexist /bin/rm cmd /V:ON /C "del /f)

ifdef LARGE_MEM_MODEL
LDFLAGS += -Ml
CFLAGS += -Ml
else
LDFLAGS += -Md
CFLAGS += -Md
endif

LDFLAGS += -cl -v
CFLAGS += -g -I$(PRODDIR)/../include
LCFLAGS += -e -d pokemini -M

.SUFFIXES:
.SUFFIXES: .min .hex .map .abs .c .asm .obj .out

all: $(TARGET).min

run: $(TARGET).min
	$(POKEMINID) $! 

$(TARGET).min: $(TARGET).hex
$(TARGET).hex: $(TARGET).out

.hex.min:
	$(SREC_CAT) $< -o $@ -binary

.out.hex:
	$(LC88) $(LCFLAGS) -f2 -o $@ $<

$(TARGET).out: $(OBJS)
	$(CC88) $(LDFLAGS) -o $@ $!

.c.asm:
	$(C88) $(CFLAGS) -v -o $@ $<

.asm.obj:
	$(CC88) $(CFLAGS) -Tc-v -c -v -o $@ $<

.c.obj:
	$(CC88) $(CFLAGS) -Tc-v -c -v -o $@ $<

clean:
	$(exist /bin/rm $(RM) $(OBJS))
	# del does not accept / path separator
	$(nexist /bin/rm set OBJS="$(separate "\" \"" $(OBJS))"&& $(RM) !OBJS:/=\!)
	$(RM) $(TARGET).out $(TARGET).abs $(TARGET).map $(TARGET).hex
	$(RM) $(TARGET).min
