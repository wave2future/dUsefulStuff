#!/bin/sh

# createDmg.sh
# dUsefulStuff
#
# Created by Derek Clarkson on 27/08/10.
# Copyright 2010 Derek Clarkson. All rights reserved.

DOCSET_PATH="$DC_BUILD_DIR/appledoc/docset"
echo "Checking for docset at $DOCSET_PATH"
if [ -d $DOCSET_PATH ]; then
	echo "Copying docset ..."
	cp -fR "$DC_BUILD_DIR/appledoc/docset" "$DC_ARTIFACT_DIR/$DC_COMPANY_ID.$DC_PROJECT_NAME.docset"
	
	echo "Writing install docset script file ..."
	echo "echo \"Installing $DC_PROJECT_NAME documentation into XCode.\"" > "$DC_ARTIFACT_DIR/installDocSet"
	echo "osascript -e 'tell application \"Xcode\" to load documentation set with path (system attribute \"PWD\") & \"/$DC_COMPANY_ID.$DC_PROJECT_NAME.docset\"'" >> "$DC_ARTIFACT_DIR/installDocSet"
	chmod a+x "$DC_ARTIFACT_DIR/installDocSet"

fi

echo "Copying markdown documentation from root of project ..."
cp -v *.markdown "$DC_ARTIFACT_DIR"

echo "Copying other files copied by build ..."
find "$DC_BUILD_DIR/$DC_BUILD_CONFIGURATION-iphoneos" -type f -not -name "*.a" -depth 1 -exec cp -v "{}" "$DC_ARTIFACT_DIR" \;

echo Building dmg of project ...
hdiutil create "$DC_DMG_FILE" -ov -srcdir "$DC_ARTIFACT_DIR" -volname "$DC_PRODUCT_NAME v$DC_CURRENT_PROJECT_VERSION" -attach

echo "Archive $DC_DMG_FILE created successfully."

