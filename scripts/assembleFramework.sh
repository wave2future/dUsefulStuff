#!/bin/sh

# assembleFramework.sh
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

# Check or help requests if not running within xcode.
assertSet ARTIFACT_DIR
assertSet PROJECT_NAME
assertSet CURRENT_PROJECT_VERSION
assertSet BUILD_CONFIGURATION

echo "Creating artifact directory ..."
mkdir -p $ARTIFACT_DIR

echo "Setting up framework directories..."  
FRAMEWORK_DIR=$ARTIFACT_DIR/$PROJECT_NAME.framework  
mkdir -p $FRAMEWORK_DIR  
mkdir -p $FRAMEWORK_DIR/Versions  
mkdir -p $FRAMEWORK_DIR/Versions/$CURRENT_PROJECT_VERSION
mkdir -p $FRAMEWORK_DIR/Versions/$CURRENT_PROJECT_VERSION/Resources
mkdir -p $FRAMEWORK_DIR/Versions/$CURRENT_PROJECT_VERSION/Headers

# Copying files
echo "Copying files into place ..."
find $BUILD_DIR/$BUILD_CONFIGURATION-iphoneos -name "*.h" -exec cp -v "{}" $FRAMEWORK_DIR/Versions/$CURRENT_PROJECT_VERSION/Headers \;
cp -v "$BUILD_DIR/lib/$PROJECT_NAME" $FRAMEWORK_DIR/Versions/$CURRENT_PROJECT_VERSION

echo "Creating framework symlinks..."  
ln -s $CURRENT_PROJECT_VERSION $FRAMEWORK_DIR/Versions/Current
ln -s Versions/Current/Headers $FRAMEWORK_DIR/Headers
ln -s Versions/Current/Resources $FRAMEWORK_DIR/Resources
ln -s Versions/Current/$PROJECT_NAME $FRAMEWORK_DIR/$PROJECT_NAME 

if [ ! -f framework.plist ]; then
	echo "Error: framework.plist not found."
	exit 1
fi

echo "Creating plist for framework ..."
sed -e 's/${PROJECT_NAME}/'"${PROJECT_NAME}"'/' -e 's/${CURRENT_PROJECT_VERSION}/'"${CURRENT_PROJECT_VERSION}"'/' framework.plist > "$FRAMEWORK_DIR/Resources/Info.plist"  

exit 0
