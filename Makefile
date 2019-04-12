# This is the URL from the official website
#EPSON_TOOLCHAIN_ZIP_URL := "https://www.epsondevice.com/products_and_drivers/semicon/products/micro_controller/zip/s5u1c88000c16.zip"
EPSON_TOOLCHAIN_ZIP_URL := "https://web.archive.org/web/20190411141705/www.epsondevice.com/products_and_drivers/semicon/products/micro_controller/zip/s5u1c88000c16.zip"

all: c88tools c88tools/etc/pokemini.dsc c88tools/etc/s1c88_pokemini.cpu  wineprefix

wineprefix:
	WINEARCH=win32 WINEPREFIX=$(abspath ./wineprefix) wineboot

c88tools/etc/pokemini.dsc: etc/pokemini.dsc c88tools
	cp $< $@

c88tools/etc/s1c88_pokemini.cpu: etc/s1c88_pokemini.cpu c88tools
	cp $< $@

c88tools: temp-setup
	unshield -L -g TARGET x temp-setup/data1.cab # Main installed files
	unshield -L -g SYSTEM x temp-setup/data1.cab # Get some DLLS
	mv system/* target/bin
	mv target $@
	rm -rf system

temp-setup: s5u1c88000c16.zip
	unzip s5u1c88000c16.zip -d $@

.PRECIOUS: s5u1c88000c16.zip
s5u1c88000c16.zip:
	@echo "Zip file not found, downloading from $(EPSON_TOOLCHAIN_ZIP_URL)..."
	curl $(EPSON_TOOLCHAIN_ZIP_URL) --output $@
	touch $@

.PHONY: clean
clean:
	rm -rf c88tools temp-setup wineprefix
