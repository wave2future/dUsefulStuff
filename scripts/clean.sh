#!/bin/sh

# clean.sh
# dUsefulStuff
#
# Created by Derek Clarkson on 27/08/10.
# Copyright 2010 Derek Clarkson. All rights reserved.

echo "Cleaning directories and artifacts ..."
rm -fr $DC_BUILD_DIR
rm -fr $DC_ARTIFACT_DIR
rm -f $DC_DMG_FILE
echo "Directories cleared."

