#!/bin/bash

# buildStaticLibrary.sh
# dUsefulStuff
#
# Created by Derek Clarkson on 26/08/10.
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
assertSet PROJECT_DIR
assertSet PROJECT_NAME
assertSet PRODUCT_NAME
assertSet CURRENT_PROJECT_VERSION
assertSet BUILD_DIR
assertSet BUILD_TARGET
assertSet DEVICE_SDK
assertSet DEVICE_ARCHS
assertSet DEVICE_VALID_ARCHS
assertSet SIMULATOR_SDK
assertSet SIMULATOR_ARCHS
assertSet SIMULATOR_VALID_ARCHS

# Start of run.
echo "Starting build ..."

echo "Building simulator library ..."
# xcodebuild -target "$BUILD_TARGET" -sdk $SIMULATOR_SDK -configuration Debug VALID_ARCHS="$SIMULATOR_VALID_ARCHS" ARCHS="$SIMULATOR_ARCHS"
xcodebuild -target "$BUILD_TARGET" -sdk $SIMULATOR_SDK -configuration Release VALID_ARCHS="$SIMULATOR_VALID_ARCHS" ARCHS="$SIMULATOR_ARCHS"

echo "Building device library ..."
# xcodebuild -target "$BUILD_TARGET" -sdk $DEVICE_SDK -configuration Debug VALID_ARCHS="$DEVICE_VALID_ARCHS" ARCHS="$DEVICE_ARCHS"
xcodebuild -target "$BUILD_TARGET" -sdk $DEVICE_SDK -configuration Release VALID_ARCHS="$DEVICE_VALID_ARCHS" ARCHS="$DEVICE_ARCHS"

echo "Combining libraries..."
mkdir "$BUILD_DIR/lib"
lipo -create "${PROJECT_DIR}/build/Release-iphoneos/lib${PROJECT_NAME}.a" "${PROJECT_DIR}/build/Release-iphonesimulator/lib${PROJECT_NAME}.a" -o "$BUILD_DIR/lib/$PROJECT_NAME"

echo "Static library created at $BUILD_DIR/lib/$PROJECT_NAME"

exit 0

