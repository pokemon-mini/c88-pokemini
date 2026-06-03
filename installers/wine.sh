# Bash on Linux and Mac both read scripts differently, so splitting them up for simplicity and sanity; parts will be duplicated but this is the most straightforward way to keep compatibility
#!/bin/bash
source config.sh
source installers/inc/common.sh

use_wine=0
if [[ "$(uname)" == "Linux" ]]; then
	./installers/wine-linux.sh
	use_wine=1
elif [[ "$(uname)" == "Darwin" ]]; then
	# Get version to determine which path to take; Wibo has only been tested on modern Mac OS versions
	version="$(sw_vers -productVersion)"
	major=$(echo "$version" | awk -F'.' '{print $1}')
	minor=$(echo "$version" | awk -F'.' '{print $2}')
	# Wine won't work on macOS Catalina 10.15 or newer
	if [[ "$major" -lt 10 ]]; then
		./installers/wine-mac.sh
		use_wine=1
	elif [[ "$major" -eq 10 ]] && [[ "$minor" -lt 15 ]]; then
		./installers/wine-mac.sh
		use_wine=1
	fi
fi

if [[ "$use_wine" == 1 ]]; then
	pfx="$(dirname "$(pwd)")/wineprefix"
	mkdir "$pfx"
	echo "#!/bin/sh" > wine
	echo "WINEARCH=win32 WINEPREFIX=$pfx wineboot" >> wine
	chmod 755 wine
else
	echo "Could not install dependency: wine; attempting to install wibo"
	if ! ./installers/wibo.sh; then
		exit 1
	fi
fi
