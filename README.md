# S1C88 C Tools for Pokemon Mini

The aim of this project is to provide a multi-platform toolchain for
developing games for the Pokemon Mini in the C language.

**Warning: Work in progress... Things can change drastically**

# System requirements

## Windows

Windows is supported through WSL2 on Windows 10+, just follow these instructions to get it setup: https://docs.microsoft.com/en-us/windows/wsl/install-win10 . Make sure it's WSL2 for its ability to access the Windows filesystem and general speed improvements. Then install any of the Linux images in the Windows Store (recommend Ubuntu for the best supported one but any Linux distro can be run in WSL with enough know-how). Open your WSL instance, install all dependencies from the next section using your distro's package manager, and build the toolchain.

## Linux/(OSX?)/WSL2 Required Dependencies (for downloading and extracting the tools)

* `git` for cloning this repository.
* GNU `make` - for executing the makefiles
* `curl`, `unzip` - for downloading and extracting the  the installer
* `unshield` - for extracting the compilers out of the installer

## Linux/(OSX?) Only Extra Dependencies and Special Notes (for running the tools)

* `wine` - for running the TASKING C compiler for S1C88 (See notes below for extra steps required if running a modern 64-bit install)
* `PokeminiD` - for debugging the compiled .min images
* `pokeflash` - for flashing the images into a flash cart
* `srec_cat` (from the `srecord` package) - for converting the locator
  output to .min

## 64-bit WINE Caveat (Very Important Step that cannot be skipped)

Most modern Linux distros and all current Macs use 64-bit OSs. 32-bit support has gotten substantially better for WINE, a software used for running Windows applications on non-Windows systems, but there are still applications that can only run in a 32-bit instance (see here for some basic info on why: https://wiki.winehq.org/FAQ#How_do_I_create_a_32_bit_wineprefix_on_a_64_bit_system.3F). To solve this issue, you'll need to run this extra command while in the c88-pokemini directory:

``` bash
$ WINEARCH=win32 WINEPREFIX=wineprefix wineboot
```

## Build the Toolchain

``` bash
$ git clone "https://github.com/pokemon-mini/c88-pokemini"
$ cd c88-pokemini
$ make
```