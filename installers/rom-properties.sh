#!/bin/bash

source config.sh
source installers/inc/common.sh

# Standard info queries
uninstall=
case "$1" in
	--prefix)
		if [ ! "$romprop" ]; then
			echo "rom-properties not installed"
			exit 1
		fi
		echo "$(dirname "$romprop")"
		exit 0
		;;
	--description)
		echo "Shows Pokemon mini ROMs' (and other ROMs') properties in the file browser"
		exit 0
		;;
	--uninstall)
		if which apt; then
			sudo apt purge rom-properties-all && sudo apt-get autoremove
		else
			echo "Can only uninstall rom-properties with the package managers: apt"
			exit 1
		fi
		remove_config romprop
		exit 0
		;;
	--*)
		echo "Unknown command $1"
		exit 2
		;;
esac

# Check if it's already installed
[ "$romprop" ] && exit 0  # From config

if which apt; then
	sudo add-apt-repository ppa:gerbilsoft/ppa
	sudo apt-get update
	echo 'Select the desktop/graphical environment(s) you wish to install for or type "all":'
	echo '  kde4 - For KDE4 desktops using Dolphin file manager'
	echo '  kf5 - For KDE5/KF5 desktops using Dolphin file manager'
	echo '  xfce - For XFCE desktops'
	echo '  gtk3 - For Gnome, Unity, or MATE desktops'
	echo '  cinnamon - For Cinnamon desktops'
	echo -n 'Your choices (space separated): '
	read choices

	packages="$(for x in $choices; do echo -n "rom-properties-$x "; done)"
	sudo apt-get install $packages rom-properties-cli rom-properties-utils rom-properties-lang
	echo "romprop=\"$(which rpcli)\"" >> config.sh
else
	echo "Can only install rom-properties with the package managers: apt"
	exit 1
fi
