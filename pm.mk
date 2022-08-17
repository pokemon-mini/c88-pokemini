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

RM := $(PRODDIR)\..\rm.bat

# So you don't need to edit the PATH variable normally...
# cc88 can't seem to find the tools without this in PATH, but
# only when run from mk88. Finds them fine from GNU make?
PFX = set PATH=$(PRODDIR)\bin&&
CC = $(PFX) cc88
LC = $(PFX) lc88
SREC_CAT := $(PRODDIR)\..\srec_cat.bat

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

LDFLAGS += -v -d pokemini -Tlc"-e -M -f2"
CCFLAGS += -I"$(PRODDIR)\..\include" -Tc-v -v
ASFLAGS = $(CCFLAGS)

OBJS += $(C_SOURCES:.c=.obj)
OBJS += $(ASM_SOURCES:.asm=.obj)
COMPILED_ASM = $(C_SOURCES:.c=.src)

.SUFFIXES: .min .sre

.PHONY: all, run, assembly

all: $(TARGET).min

assembly: $(COMPILED_ASM)

run: $(TARGET).min
	$(POKEMINID) $!

$(TARGET).min: $(TARGET).sre

.sre.min:
	$(SREC_CAT) $< -o $@ -binary

$(TARGET).sre: $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS)

.c.src:
	$(CC) $(CCFLAGS) -cs -Tc"-o $@" $<

clean:
	$(RM) $(OBJS)
	$(RM) $(TARGET).out $(TARGET).sre $(TARGET).map $(TARGET).hex
	$(RM) $(TARGET).min
