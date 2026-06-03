#!/bin/sh

VERSION=0.0.1

cwd="$(pwd)"
cd "$(dirname "$0")"
touch config.sh

# Commands
cmd=
start='Installing'
success='Installed successfully!'
failure='Installation failed.'
case "$1" in
	-h | --help)
		echo "Pokemon mini tool installer v$VERSION"
		echo "Usage: ./install.sh [command] TOOL"
		echo "Commands:"
		echo "  -h --help       This help information."
		echo "  -v --version    Print installer version."
		echo "  -l --list       List tools available to install."
		echo "  -U --uninstall  Uninstall the specified tool."
		cd "$cwd"
		exit 0
		;;
	-v | --version)
		echo "$VERSION"
		cd "$cwd"
		exit 0
		;;
	-l | --list)
		for x in installers/*.sh; do
			echo -n "$(basename "$x" .sh): "
			./installers/"$x" --description
		done
		cd "$cwd"
		exit 0
		;;
	-U | --uninstall)
		echo "Are you sure you want to uninstall $2 (y/n)?"
		read yn
		[ "$yn" != "y" ] && cd "$cwd" && exit 0
		shift
		cmd=--uninstall
		start='Uninstalling'
		success='Uninstalled successfully!'
		failure='Uninstallation failed.'
		;;
	--prefix)
		shift
		cmd=--prefix
		start=
		success=
		failure=
		;;
	-*)
		echo "Unknown command $1"
		cd "$cwd"
		exit 2
		;;
esac

# Install c88tools by default
tool="$1"
[ "$tool" ] || tool="c88tools"

if [ -f "installers/${tool}.sh" ]; then
	[ "$start" ] && echo "${start} ${tool}..."
	if ./installers/"${tool}.sh" $cmd; then
		[ "$success" ] && echo "$success"
	else
		[ "$failure" ] && echo "$failure"
		cd "$cwd"
		exit 1
	fi
else
	echo "No tool $tool found..."
	cd "$cwd"
	exit 2
fi

cd "$cwd"
