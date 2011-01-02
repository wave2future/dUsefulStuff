#!/bin/sh

# createDocumentation.sh
# dUsefulStuff
#
# Created by Derek Clarkson on 27/08/10.
# Copyright 2010 Derek Clarkson. All rights reserved.
echo "Building appledoc documentation ..."

DC_APPLEDOC_CMD="$DC_APPLEDOC --install-docset --output $DC_BUILD_DIR/appledoc --no-warn-undocumented-member --project-name $DC_PROJECT_NAME --company-id $DC_COMPANY_ID --project-company $DC_COMPANY --templates $DC_APPLEDOC_TEMPLATES_DIR $DC_SRC"
echo 
echo Appledoc command: $DC_APPLEDOC_CMD
echo 

$DC_APPLEDOC_CMD

#$DC_APPLEDOC --install-docset --output "$DC_BUILD_DIR/appledoc" --project-name $DC_PROJECT_NAME --company-id $DC_COMPANY_ID --project-company "$DC_COMPANY" --templates "$DC_APPLEDOC_TEMPLATES_DIR"  "$DC_SRC"



