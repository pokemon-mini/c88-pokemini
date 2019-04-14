# This is the URL from the official website
#EPSON_TOOLCHAIN_ZIP_URL := "https://www.epsondevice.com/products_and_drivers/semicon/products/micro_controller/zip/s5u1c88000c16.zip"
EPSON_TOOLCHAIN_ZIP_URL := "https://web.archive.org/web/20190411141705/www.epsondevice.com/products_and_drivers/semicon/products/micro_controller/zip/s5u1c88000c16.zip"
WINDOWS_BINPACK_URL := "http://electrumee.com/pub/bin-windows.zip"

TARGETS :=

ifeq ($(OS), Windows_NT)
	TARGETS += bin-windows
	UNSHIELD := bin-windows/unshield
else
	TARGETS += wineprefix
	UNSHIELD := unshield
endif

TARGETS += c88tools
TARGETS += c88tools/etc/pokemini.dsc c88tools/etc/s1c88_pokemini.cpu

.PHONY: all

all: $(TARGETS)

wineprefix:
	WINEARCH=win32 WINEPREFIX=$(abspath ./wineprefix) wineboot

c88tools/etc/%: etc/% c88tools
	cp $< $@

c88tools: temp-setup
	$(UNSHIELD) -L -g TARGET x temp-setup/data1.cab # Main installed files
	$(UNSHIELD) -L -g SYSTEM x temp-setup/data1.cab # Get some DLLS
	mv system/* target/bin
	mv target $@
	rm -rf system

temp-setup: s5u1c88000c16.zip
	unzip -f $< -d $@

bin-windows: bin-windows.zip
	unzip -f $<
	touch $@

.PRECIOUS: bin-windows.zip
bin-windows.zip:
	@echo "$@ file not found, downloading from $(WINDOWS_BINPACK_URL)..."
	curl $(WINDOWS_BINPACK_URL) --output $@
	touch $@

.PRECIOUS: s5u1c88000c16.zip
s5u1c88000c16.zip:
	@echo "Zip file not found, downloading from $(EPSON_TOOLCHAIN_ZIP_URL)..."
	curl $(EPSON_TOOLCHAIN_ZIP_URL) --output $@
	touch $@

.PHONY: clean
clean:
	rm -rf c88tools temp-setup wineprefix bin-windows
