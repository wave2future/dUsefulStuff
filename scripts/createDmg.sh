#!/bin/sh

# createDmg.sh
# dUsefulStuff
#
# Created by Derek Clarkson on 27/08/10.
# Copyright 2010 Derek Clarkson. All rights reserved.

echo "Copying docset ..."
mv -vf "$DC_BUILD_DIR/appledoc/docset" "$DC_ARTIFACT_DIR/au.com.dhc.$DC_PROJECT_NAME.docset"
cp installDocSet "$DC_ARTIFACT_DIR"

echo "Copying markdown documentation from root of project ..."
cp -v *.markdown "$DC_ARTIFACT_DIR"

echo "Copying other files copied by build ..."
find "$DC_BUILD_DIR/$DC_BUILD_CONFIGURATION-iphoneos" -type f -not -name "*.a" -depth 1 -exec cp -v "{}" "$DC_ARTIFACT_DIR" \;

echo Building dmg of project ...
hdiutil create "$DC_DMG_FILE" -ov -srcdir "$DC_ARTIFACT_DIR" -volname "$DC_PRODUCT_NAME v$DC_CURRENT_PROJECT_VERSION" -attach

echo "Archive $DC_DMG_FILE created successfully."

