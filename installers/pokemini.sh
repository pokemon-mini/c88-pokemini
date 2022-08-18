#!/bin/bash

source ../config.sh

DOWNLOAD_URL='https://sourceforge.net/projects/pokemini/files/0.60/pokemini_060_linux32dev.zip/download'

# Standard info queries
case "$1" in
	--prefix)
		if [ ! "$pokemini" ]; then
			echo "pokemini not installed"
			exit 1
		fi
		echo "$pokemini"
		exit 0
		;;
	--description)
		echo "PokeMini emulator by JustBurn v0.60"
		exit 0
		;;
	--uninstall)
		rm -rf "$pokemini"
		grep --invert-match '^pokemini=' ../config.sh > ../tmp
		mv ../tmp ../config.sh
		echo 'You will have to remove any entry in the path variable yourself.'
		exit 0
		;;
	--*)
		echo "Unknown command $1"
		exit 2
esac

# Check if it's already installed
[ "$pokemini" ] && exit 0  # From config

for x in curl unzip realpath; do
	if ! which $x; then
		echo "Requires system utility to install: $x"
		exit 1
	fi
done

curl -Lo /tmp/pokemini_linux32dev.zip "$DOWNLOAD_URL"
unzip /tmp/pokemini_linux32dev.zip -d ../tools/pokemini

pokemini="$(realpath '../tools/pokemini')"
echo 'Saving to config...'
echo "pokemini=\"$pokemini\"" >> ../config.sh

echo 'Add PokeMini to your path with:'
echo "  PATH=\"\$PATH:$pokemini/bin\""

echo 'Associate .min files with PokeMini (y/n)?'
read yn

if [ "$yn" == "y" ]; then
	$pokemini/associateMin.sh register "$pokemini/PokeMini"
	echo '...done'
fi
