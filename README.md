# S1C88 C Tools for Pokemon Mini

The aim of this project is to provide a multi-platform toolchain for developing games for the Pokemon Mini in the C language.

**Warning: Work in progress... Things can change drastically**

## System requirements

### Linux (not WSL)

These packages must be installed in your system (and be available in your PATH) to run all the scripts and make files:

* `git` for cloning this repository.
* GNU `make` - for running the installer Makefile
* `curl`, `unzip` - for downloading and extracting the  the installer
* `wine` - for running the TASKING C compiler for S1C88
* `unshield` - for extracting the compilers out of the installer
* `srec_cat` (from the `srecord` package) - for converting the locator
  output to .min
* `PokeMiniD` - for debugging the compiled .min images

```sh
# On Ubuntu and other Debian-based distros
sudo apt install make git curl wget unzip unshield srecord
# ...for 32 bit versions:
sudo apt install wine
# ...for 64 bit versions:
sudo apt purge wine
sudo dpkg --add-architecture i386
wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo apt-add-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ $(lsb_release -sc) main"
sudo apt update && sudo apt install --install-recommends winehq-stable

# Install pokemini dev (make sure to have $HOME/.local/bin in PATH)
curl -Lo pokemini_060_linux32dev.zip https://sourceforge.net/projects/pokemini/files/0.60/pokemini_060_linux32dev.zip/download
unzip pokemini_060_linux32dev.zip PokeMiniD -d ~/.local/bin

# Install these tools
git clone "https://github.com/pokemon-mini/c88-pokemini"
cd c88-pokemini
make
```

### Windows

Windows is supported through MSYS2, just install the base system from https://www.msys2.org/ You then can use the msys2 shell to clone this repository and build the toolchain.

Some tools are downloaded automatically by the setup script: unshield, srec_cat, PokeMiniD. You must place the PokeMiniD location on your PATH in order to use `mk88 run` in projects, whether it's your own version or the included one.

```sh
# Ensure dependencies
pacman -S git unzip curl make
# From here it goes as before
git clone "https://github.com/pokemon-mini/c88-pokemini"
cd c88-pokemini
make # The makefile will automatically download dependencies and build the toolchain folder
```

### OSX

OSX no longer supports running 32 bit binaries, so running the suite on the bare OS is not possible. You will have to run them in a VM.

## Building the example

You may use CMD, MSYS, or a Linux shell emulator. It's recommended to have c88tools/bin in the PATH but not required.

### Commands

The makefile comes with the following commands:

* `all` - the default, build the min
* `clean` - clean up all the build object
* `assembly` - build all C files to their assembler forms
* `run` - build and run the min in PokeMiniD
* `src/main.src` - build main.c to its assembler form (can do this with any C file)

### Linux

```sh
# Start in the example's directory
cd examples/helloworld
# Build with mk88
WINEARCH=win32 WINEPREFIX=../../wineprefix wine mk88
# ...or...
WINEARCH=win32 WINEPREFIX=../../wineprefix wine ../../c88tools/bin/mk88.exe
# ...or with GNU make
make
```

### Windows

```batch
:: Start in the example's directory
cd examples\helloworld
:: Build with mk88
mk88
:: ...or...
..\..\c88tools\bin\mk88
:: ...or, in MSYS only, with GNU make
make
```
