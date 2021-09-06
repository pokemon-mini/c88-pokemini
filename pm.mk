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

# You must define these in the PATH
POKEMINID := PokeMiniD

is_$(MAKE) := true
ifdef is_mk88

NULERR := 2>nul

# So you don't need to edit the PATH variable normally...
# cc88 can't seem to find the tools without this in PATH, but
# only when run from mk88. Finds them fine from GNU make?
PFX = set PATH=$(PRODDIR)\bin&&
CC = $(PFX) cc88
LC = $(PFX) lc88

ifdef TERM
# Running in wine on Linux or Mac, escape for srec_cat
SREC_CAT := start /unix /bin/sh -c "srec_cat
SREC_CAT_END := >&2"
else
# mk88 on Windows
SREC_CAT := $(PRODDIR)\..\bin-windows\srec_cat
endif

else

# GNU make, probably
BASE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
include $(BASE_DIR)/pm_gnu.mk

endif

AS = $(CC)
LD = $(CC)

ifdef MEM_MODEL
LDFLAGS += -M$(MEM_MODEL)
CCFLAGS += -M$(MEM_MODEL)
else
LDFLAGS += -Md
CCFLAGS += -Md
endif

LDFLAGS += -v
CCFLAGS += -g -I"$(PRODDIR)\..\include" -Tc-v -v
ASFLAGS = $(CCFLAGS)
LCFLAGS += -e -d pokemini -M -f2

OBJS += $(C_SOURCES:.c=.obj)
OBJS += $(ASM_SOURCES:.asm=.obj)
COMPILED_ASM = $(C_SOURCES:.c=.src)

.SUFFIXES: .min .sre .out

.PHONY: all, run, assembly

all: $(TARGET).min

assembly: $(COMPILED_ASM)

run: $(TARGET).min
	$(POKEMINID) $!

$(TARGET).min: $(TARGET).sre
$(TARGET).sre $(TARGET).map: $(TARGET).out

.sre.min:
	$(SREC_CAT) $< -o $@ -binary

# For whatever reason, -Tcl can't forward -d arg, so we have to call lc88 directly
.out.sre:
	$(LC) -o $@ $(LCFLAGS) $<

$(TARGET).out: $(OBJS)
	$(CC) -cl $(LDFLAGS) -o $@ $(OBJS)

.c.src:
	$(CC) $(CCFLAGS) -cs -Tc"-o $@" $<

clean:
	$(RM) $(OBJS) $(NULERR)
	$(RM) $(TARGET).out $(TARGET).sre $(TARGET).map $(TARGET).hex $(NULERR)
	$(RM) $(TARGET).min $(NULERR)
