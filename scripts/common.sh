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

printSettings() {
	echo Current settings ...
	set | grep "DC_" 
}

# Startup.

# Exit if an error occurs and diallow unset variables.
set -o errexit
set -o nounset

# Quick and dirty debug building.
if [[ $# > 0 && $1 == "--debug" ]]; then
	echo "Switching to Debug build"
	DC_BUILD_CONFIGURATION=Debug
fi



