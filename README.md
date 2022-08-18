# S1C88 C Tools for Pokemon Mini

The aim of this project is to provide a multi-platform toolchain for developing games for the Pokemon Mini in the C language.

**Warning: Work in progress... Things can change drastically**

## System requirements

### Linux (not WSL)

These packages must be installed in your system (and be available in your PATH) to run all the scripts and make files:

* `git` for cloning this repository.
* `curl`, `unzip` - for downloading and extracting the  the installer
* `wine` - for running the TASKING C compiler for S1C88
  * The installer will attempt to install it for you, if it's not
* `srec_cat` (from the `srecord` package) - for converting the locator
  output to .min

```sh
# On Ubuntu and other Debian-based distros, install the prereqs
sudo apt install git curl wget unzip srecord

# Install these tools (and wine, if it's not)
./install.sh

# Install PokeMini emulator
./install.sh pokemini

# List other things you can install
./install.sh --list

# More info
./install.sh --help
```

### Windows

```ps1
# Install these tools
.\install.ps1

# Install PokeMini emulator
.\install.ps1 pokemini

# List other things you can install
.\install.ps1 -list

# More info
Get-Help .\install.ps1
```

### OSX

OSX no longer supports running 32 bit binaries as of Catalina, so running the suite on the bare OS is not possible. You will have to run them in a VM. If you have an earlier version of the OS, you can try the linux installer.

## Building the example

You may use CMD, MSYS, or a Linux shell emulator. It's recommended to have c88tools/bin in the PATH but not required.

### Commands

The makefile comes with the following targets:

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
