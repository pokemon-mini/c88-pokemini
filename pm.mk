## Copyright 2019 Jose I Romero
## Copyright 2021 Sapphire Becker, Jhynjhiruu
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
# You must define these in the PATH
SREC_CAT := srec_cat
POKEMINID := PokeMiniD
else
WINE :=
SREC_CAT := $(PRODDIR)/../bin-windows/srec_cat
POKEMINID := $(PRODDIR)/../bin-windows/PokeMiniD
endif

# Separate is used here because otherwise MK88 tries to include the space in the filename
C88_DIR := $(PRODDIR)/bin
C88 := $(separate " " $(WINE) $(C88_DIR)/c88.exe)
CC88 := $(separate " " $(WINE) $(C88_DIR)/cc88.exe)
LC88 := $(separate " " $(WINE) $(C88_DIR)/lc88.exe)

RM := $(exist /bin/rm rm -f)$(nexist /bin/rm cmd /V:ON /C "del /f)

ifdef MEM_MODEL
LDFLAGS += -M$(MEM_MODEL)
CFLAGS += -M$(MEM_MODEL)
else
LDFLAGS += -Md
CFLAGS += -Md
endif

LDFLAGS += -cl -v
CFLAGS += -g -I$(PRODDIR)/../include
LCFLAGS += -e -d pokemini -M

OBJS += $(C_SOURCES:.c=.obj)
OBJS += $(ASM_SOURCES:.asm=.obj)
COMPILED_ASM = $(C_SOURCES:.c=.s)

.SUFFIXES:
.SUFFIXES: .min .hex .map .abs .c .c.asm .asm .obj .out

.PHONY: all, run, assembly

.DEFAULT: all

all: $(TARGET).min

assembly: $(COMPILED_ASM)

run: $(TARGET).min
	$(POKEMINID) $(TARGET).min

$(TARGET).min: $(TARGET).hex
	$(SREC_CAT) $(TARGET).hex -o $@ -binary

$(TARGET).hex $(TARGET).map: $(TARGET).out
	$(LC88) $(LCFLAGS) -f2 -o $@ $(TARGET).out

$(TARGET).out: $(OBJS)
	$(CC88) $(LDFLAGS) -o $@ $!

.c.s:
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
