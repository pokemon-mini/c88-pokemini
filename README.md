# S1C88 C Tools for Pokemon Mini

The aim of this project is to provide a multi-platform toolchain for developing games for the Pokemon Mini in the C language.

**Warning: Work in progress... Things can change drastically**

## System requirements

### Linux (not WSL)

These packages must be installed in your system (and be available in your PATH) to run all the scripts and make files:

* `git` for cloning this repository.
* `curl`, `unzip` - for downloading and extracting the  the installer
* `wine` or `wibo` - for running the TASKING C compiler for S1C88
  * The installer will attempt to install wine for you, if it's not, it'll attempt to install wibo instead
  * `wibo` only officially builds for and supports Linux i686 and x86_64 and newer OSX versions (Catalina and higher)
* `srec_cat` (from the `srecord` package) - for converting the locator
  output to .min

### OSX
* Linux dependencies above plus the following:
  * `coreutils` - for realpath command
  * `bash` - for running the scripts; OSX doesn't always ship or update bash by default

```sh
# On Ubuntu and other Debian-based distros, install the prereqs
sudo apt install git curl wget unzip srecord

# On Fedora and other RHEL-based distros, install the prereqs
sudo dnf install git curl wget unzip srecord

# On OSX
brew install git curl wget unzip srecord bash coreutils

# Install these tools (and wine or wibo, if neither are installed)
./install.sh

# Install PokeMini emulator
./install.sh pokemini

# List other things you can install
./install.sh --list

# More info
./install.sh --help

# Optionally install Wibo even if Wine is installed
./install.sh wibo
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
# ...or with GNU make (or using wibo)
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
