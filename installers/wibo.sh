#!/bin/bash

source config.sh
source installers/inc/common.sh

# Wibo's standalone binary gets downloaded from here if Wine's not available
wibo_url="https://github.com/decompals/wibo/releases/latest/download"

# Standard info queries
# Prefix isn't used by Wibo, so no need to call or set it
uninstall=
case "$1" in
	--description)
		echo "standalone wrapper for running 32-bit Windows apps on Linux and Mac; doesn't have as many features as wine but is portable, adds modern Mac support, and runs S1C88 tools"
		exit 0
		;;
	--uninstall)
		if "./wibo"; then
			rm -r wibo > /dev/null 2>&1
			echo "wibo removed"
		fi
		exit 0
		;;
	--*)
		echo "Unknown command $1"
		exit 2
		;;
esac

arch=""
if [[ "$(uname)" == "Linux" ]]; then
	if [[ "$(uname -m)" == "x86_64" ]] || [[ "$(uname -m)" == "amd64" ]]; then
		arch="x86_64"
	elif [[ "$(uname -m)" == "x86" ]] || [[ "$(uname -m)" == "i686" ]]; then
		arch="i686"
	else
		echo "Current Linux architecture not officially supported; install wine or build wibo from source and manually copy wibo binary to this directory"
		exit 1
	fi
elif [[ "$(uname)" == "Darwin" ]]; then
	if [[ "$(uname -m)" == "powerpc" ]]; then
		echo "PowerPC Macs are not officially supported; install wine or build wibo from source and manually copy wibo binary to this directory"
		exit 1
	else
		arch="macos"
	fi
else
	echo "Platform not officially supported; install wine or build wibo from source and manually copy wibo binary to this directory"
	exit 1
fi

# Check if wibo is not installed locally; since it can be built from source for unsupported platforms, it needs to be allowed to exist here
if [ ! -e "./wibo" ]; then
	curl -Lo wibo $wibo_url/wibo-$arch
	chmod 0755 wibo
	echo "wibo installed successfully"
else
	echo "wibo currently already installed; if this was not intended, delete file and run script again"
fi
