#!/bin/bash

# common.sh
# dUsefulStuff
#
# Created by Derek Clarkson on 26/08/10.
# Copyright 2010 Derek Clarkson. All rights reserved.

# Validates that a variable has been set.
assertSet() {
    : ${!1:? "$1 has not been set, aborting."}
}

printHelp() {
	echo "Syntax:"
	echo "   build.sh [-?] [-d] [-D] [-m]"
	echo "Where:"
	echo "   -? prints this message."
	echo "   -d switches to building Debug instead of Release."
	echo "   -D skips building, just calls appledoc to build and install the documentation."
	echo "   -m mounts the final dmg file."
	exit 0
}

printSettings() {
	echo Current settings ...
	set | grep "DC_" 
}

# Parses the command line and picks up various arguments.
while getopts ":dDm" opt; do
	if [ "$OPTARG" == "?" ]; then
		printHelp
		exit 0
	fi
  case $opt in
    d)
      echo "Debug build requested."
		DC_BUILD_CONFIGURATION=Debug
      ;;
    D)
		echo "Doco only requested."
		DC_BUILD_DOCO_ONLY=YES
	   ;;
    m)
		echo "Mounting of final dmg file requested."
		DC_ATTACH_DMG=-attach
	   ;;
    \?)
		echo
      echo "Invalid option: -$OPTARG"
		echo
		printHelp
      ;;
  esac
done

# Exit if an error occurs and diallow unset variables.
set -o errexit
set -o nounset




