#!/bin/bash

source config.sh
source installers/inc/common.sh

DOWNLOAD_URL='https://github.com/logicplace/c88-pokemini/releases/download/s1c88/c88tools.zip'

# Standard info queries
case "$1" in
	--prefix)
		if [ ! "$c88tools" ]; then
			echo "c88tools not installed"
			exit 1
		fi
		case "$2" in
			alc88 | ar88 | as88 | c88 | c88spawn | cc88 | ice88ur | lc88 | lk88 | mk88 | pr88 | sed88 | sy88 | wb88)
				echo "$c88tools/bin/$2.exe"
				;;
			db88) echo "$c88tools/db88/db88.exe"; ;;
			obpw88) echo "$c88tools/writer/obpw/obpw88.exe"; ;;
			"") echo "$c88tools"; ;;
			*) echo "Unknown tool $2"; exit 2; ;;
		esac
		exit 0
		;;
	--description)
		echo "Official EPSON S1C88 build tools + srec_cat"
		exit 0
		;;
	--uninstall)
		rm -rf "$c88tools"
		remove_config c88tools
		echo 'You will have to remove any entry in the path variable yourself.'
		exit 0
		;;
	--*)
		echo "Unknown command $1"
		exit 2
esac

# Check if it's already installed
[ "$c88tools" ] && exit 0  # From config

if [ ! -d c88tools ]; then
	if ! ./installers/wine.sh; then
		echo "Could not install dependency: wine"
		exit 1
	fi

	for x in curl unzip realpath; do
		if ! which $x; then
			echo "Requires system utility to install: $x"
			exit 1
		fi
	done

	curl -Lo /tmp/c88tools.zip "$DOWNLOAD_URL"
	unzip /tmp/c88tools.zip -d c88tools
	find c88tools -type f -name '*.exe' -exec chmod 0755 {} \;
fi

c88tools=$(realpath "c88tools")
echo "c88tools=\"$c88tools\"" >> config.sh

echo "Add the S1C88 tools to your path with:"
echo "  PATH=\"\$PATH:$c88tools/bin\""
