#!/bin/sh

# createDocumentation.sh
# dUsefulStuff
#
# Created by Derek Clarkson on 27/08/10.
# Copyright 2010 Derek Clarkson. All rights reserved.
echo "Building appledoc documentation ..."

DC_APPLEDOC_CMD="$DC_APPLEDOC --ignore .m --keep-undocumented-objects --keep-undocumented-members --keep-intermediate-files --install-docset --output $DC_BUILD_DIR/appledoc --project-name $DC_PROJECT_NAME --company-id $DC_COMPANY_ID --project-company \"$DC_COMPANY\" --templates $DC_APPLEDOC_TEMPLATES_DIR $DC_SRC"
echo 
echo Appledoc command: $DC_APPLEDOC_CMD
echo 

$DC_APPLEDOC_CMD

# Create space so we can see the warnings better.
echo 

# Build files for distribution.
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




