#!/bin/bash

# Standard info queries
uninstall=
case "$1" in
	--prefix)
		if [ ! "$wine32" ]; then
			echo "wine not installed"
			exit 1
		fi
		echo "$(dirname "$wine32")"
		exit 0
		;;
	--description)
		echo "32-bit version of wine and wineboot for running Windows apps on Linux and Mac"
		exit 0
		;;
	--uninstall)
		if which apt; then
			sudo apt purge wine wine-stable && sudo apt-get autoremove
		elif which brew; then
			brew uninstall wine-stable
		else
			echo "Can only uninstall wine with the package managers: apt, brew"
			exit 1
		fi
		remove_config wine32
		exit 0
		;;
	--*)
		echo "Unknown command $1"
		exit 2
		;;
esac

# Check if it's already installed
[ "$wine32" ] && exit 0  # From config

purge=
if which wine; then
	case "$(file "$(which wine)")" in
		*32-bit* | *i386*)
			echo "wine32=\"$(which wine)\"" >> config.sh
			exit 0
			;;
		*' ELF '*) purge=1; ;;
		*'symbolic link'*)
			grep -m1 wine32 "$(realpath "$(which wine)")" >> config.sh && exit 0
			;;
		*)
			echo "Unknown wine install. If the 32-bit version of Wine is already installed, set wine32 to the full path in config.sh"
			exit 1
			;;
	esac
fi

if which brew; then
	# Won't work on macOS Catalina 10.15 or newer)
	brew tap homebrew/cask-versions
	brew install --cask --no-quarantine wine-stable
else
	echo "Can only install wine with the package managers: apt, brew"
	exit 1
fi
