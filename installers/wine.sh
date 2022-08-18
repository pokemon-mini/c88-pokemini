#!/bin/bash

source ../config.sh

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
		grep --invert-match '^wine32=' ../config.sh > ../tmp
		mv ../tmp ../config.sh
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
			echo "wine32=\"$(which wine)\"" >> ../config.sh
			exit 0
			;;
		*' ELF '*) purge=1; ;;
		*'symbolic link'*)
			grep -m1 wine32 "$(realpath "$(which wine)")" >> ../config.sh && exit 0
			;&
		*)
			echo "Unknown wine install. If the 32-bit version of Wine is already installed, set wine32 to the full path config.sh"
			exit 1
			;;
	esac
fi

if which apt; then
	if [[ "$(uname -m)" == 'x86_64' ]]; then
		for x in dpkg wget; do
			if ! which $x; then
				echo "Requires system utility to install: $x"
				exit 1
			fi
		done

		[ "$purge" ] && sudo apt purge wine
		sudo dpkg --add-architecture i386
		wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
		sudo apt-add-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ $(lsb_release -sc) main"
		sudo apt update
		sudo apt install --install-recommends winehq-stable
	else
		sudo apt install wine
	fi
elif which brew; then
	# Won't work on macOS Catalina 10.15 or newer)
	brew tap homebrew/cask-versions
	brew install --cask --no-quarantine wine-stable
else
	echo "Can only install wine with the package managers: apt, brew"
	exit 1
fi

pfx="$(dirname "$(pwd)")/wineprefix"
mkdir "$pfx"
echo "#!/bin/sh" > ../wine
echo "WINEARCH=win32 WINEPREFIX=$pfx wineboot" >> ../wine
chmod 755 ../wine
