#!/bin/sh

# clean.sh
# dUsefulStuff
#
# Created by Derek Clarkson on 27/08/10.
# Copyright 2010 Derek Clarkson. All rights reserved.
# setup defaults.
# set -o errexit
# Disallows unset variables.
set -o nounset

if [ ! -f $SCRIPTS_DIR/common.sh ]; then
	echo "Error: Common.sh not found!"
	exit 1
fi

. $SCRIPTS_DIR/common.sh

assertSet BUILD_DIR
assertSet ARTIFACT_DIR
assertSet CURRENT_PROJECT_VERSION
assertSet DMG_FILE

echo "Cleaning directories and artifacts ..."
rm -fvr $BUILD_DIR
rm -fvr $ARTIFACT_DIR
rm -f $DMG_FILE
echo "Directories cleared."

