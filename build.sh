#!/bin/sh

# build.sh
# dUsefulStuff
#
# Created by Derek Clarkson on 27/08/10.
# Copyright 2010 Derek Clarkson. All rights reserved.

# build specific.
DC_CURRENT_PROJECT_VERSION=${CURRENT_PROJECT_VERSION=0.0.7}
DC_PRODUCT_NAME=${PRODUCT_NAME=dUsefulStuff}
DC_SRC=src/code
DC_BUILD_TARGET="Build Library"
DC_COMPANY_ID=au.com.derekclarkson
DC_AUTHOR="Derek Clarkson"
DC_COMPANY=$DC_AUTHOR

DC_SCRIPTS_DIR=scripts
export DC_SCRIPTS_DIR 

# Include common scripts.
source $DC_SCRIPTS_DIR/defaults.sh
source $DC_SCRIPTS_DIR/common.sh

printSettings

$DC_SCRIPTS_DIR/createDocumentation.sh
exit 0
# Call the scripts.
$DC_SCRIPTS_DIR/clean.sh
$DC_SCRIPTS_DIR/buildStaticLibrary.sh
$DC_SCRIPTS_DIR/assembleFramework.sh

# Extra step here to copy the scripts into a directory of the dmg file.
mkdir $DC_ARTIFACT_DIR/scripts
find "scripts" -type f -name "*.sh" -depth 1 -exec cp -v "{}" "$DC_ARTIFACT_DIR/scripts" \;

$DC_SCRIPTS_DIR/createDmg.sh


