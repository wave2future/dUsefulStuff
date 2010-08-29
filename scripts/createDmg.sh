#!/bin/sh

# createDmg.sh
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

assertSet DMG_FILE
assertSet BUILD_DIR

echo "Copying docset ..."
mv -vf "$BUILD_DIR/appledoc/docset" "$ARTIFACT_DIR/au.com.dhc.$PROJECT_NAME.docset"
cp installDocSet "$ARTIFACT_DIR"

echo "Copying markdown documentation from root of project ..."
cp -v *.markdown "$ARTIFACT_DIR"

echo "Copying other files copied by build ..."
find "$BUILD_DIR/Release-iphoneos" -type f -not -name "*.a" -depth 1 -exec cp -v "{}" "$ARTIFACT_DIR" \;

echo Building dmg of project ...
hdiutil create "$DMG_FILE" -ov -srcdir "$ARTIFACT_DIR" -volname "$PRODUCT_NAME v$CURRENT_PROJECT_VERSION" -attach

echo "Archive $DMG_FILE created successfully."

