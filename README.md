# S1C88 C Tools for Pokemon Mini

The aim of this project is to provide a multi-platform toolchain for
developing games for the Pokemon Mini in the C language.

**Warning: Work in progress... Things can change drastically**

# System requirements

## Linux/(OSX?)

These packages must be installed in your system to run all the scripts
and make files:

* `git` for cloning this repository.
* GNU `make` - for executing the makefiles
* `curl`, `unzip` - for downloading and extracting the  the installer
* `wine` - for running the TASKING C compiler for S1C88
* `unshield` - for extracting the compilers out of the installer
* `srec_cat` (from the `srecord` package) - for converting the locator
  output to .min
* `PokeminiD` - for debugging the compiled .min images
* `pokeflash` - for flashing the images into a flash cart

With all of that installed and in the path you can then

``` bash
$ git clone "https://github.com/pokemon-mini/c88-pokemini"
$ cd c88-pokemini
$ make
```

## Windows

Windows is supported through MSYS2, just install the base system from
https://www.msys2.org/ You then can use the msys2 shell to clone this
repository and build the toolchain.

``` bash
# Ensure dependencies
$ pacman -S git unzip curl make
# From here it goes as before
$ git clone "https://github.com/pokemon-mini/c88-pokemini"
$ cd c88-pokemini
$ make # The makefile will automatically download dependencies and build the toolchain folder
```
