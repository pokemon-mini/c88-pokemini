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
##
# Do not include this file directly! Include pm.mk instead.

.SUFFIXES:
.SUFFIXES: .c .asm .obj .abs
PRODDIR := $(BASE_DIR)/c88tools

NULERR := 2>$(or $(realpath /dev/null),nul)

ifeq ($(OS), Windows_NT)
# Windows
CC = $(PRODDIR)/bin/cc88.exe
LC = $(PRODDIR)/bin/lc88.exe
SREC_CAT := $(PRODDIR)/../bin-windows/srec_cat.exe
else

WINE_PREFIX := $(realpath $(BASE_DIR)/wineprefix)
WINE := WINEARCH=win32 WINEPREFIX=$(WINE_PREFIX) wine

CC = $(WINE) $(PRODDIR)/bin/cc88.exe
LC = $(WINE) $(PRODDIR)/bin/lc88.exe
SREC_CAT := srec_cat
endif

ifeq ($(findstring rm,$(RM)), rm)
# Change the path separator
C_SOURCES := $(subst \,/,$(C_SOURCES))
ASM_SOURCES := $(subst \,/,$(ASM_SOURCES))
endif

.asm.obj:
	$(CC) -c -o $@ $(CCFLAGS) $<

.c.obj:
	$(CC) -c -o $@ $(CCFLAGS) $<
