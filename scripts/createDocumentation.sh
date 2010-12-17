#!/bin/sh

# createDocumentation.sh
# dUsefulStuff
#
# Created by Derek Clarkson on 27/08/10.
# Copyright 2010 Derek Clarkson. All rights reserved.

# Exit if an error occurs.
set -o errexit
# Disallows unset variables.
set -o nounset

if [ ! -f $SCRIPTS_DIR/common.sh ]; then
	echo "Error: Common.sh not found!"
	exit 1
fi

. $SCRIPTS_DIR/common.sh

assertSet TOOLS_DIR
assertSet EXTERNAL_DIR
assertSet PROJECT_NAME
assertSet BUILD_DIR
assertSet SRC

DOCSETUTIL_PATH=${DOCSETUTIL_PATH=/Developer/usr/bin/docsetutil}
APPLEDOC_DIR=${APPLEDOC_DIR=$EXTERNAL_DIR/appledoc}
APPLEDOC=${APPLEDOC=$APPLEDOC_DIR/build/Release/appledoc}
DOXYGEN=${DOXYGEN=$TOOLS_DIR/Doxygen.app/Contents/Resources/doxygen}

echo DOCSETUTIL_PATH= $DOCSETUTIL_PATH
echo APPLEDOC_DIR   = $APPLEDOC_DIR
echo APPLEDOC       = $APPLEDOC
echo DOXYGEN        = $DOXYGEN

if [ ! -f $APPLEDOC ]; then
	echo "Error: Appledoc not found at $APPLEDOC"
	exit 1
fi
if [ ! -f $DOXYGEN ]; then
	echo "Error: Doxygen not found at $DOXYGEN"
	exit 1
fi
if [ ! -f doxygen-appledoc.config ]; then
	echo "Error: doxygen-appledoc.config not found."
	exit 1
fi
if [ ! -f docset.plist ]; then
	echo "Error: docset.plist not found."
	exit 1
fi

echo "Building appledoc documentation ..."

$APPLEDOC -p "$PROJECT_NAME" --input $SRC --output "$BUILD_DIR/appledoc" -t "$APPLEDOC_DIR/Templates" -d $DOXYGEN -c doxygen-appledoc.config --xhtml-bordered-issues --docutil $DOCSETUTIL_PATH --docset --docplist docset.plist


