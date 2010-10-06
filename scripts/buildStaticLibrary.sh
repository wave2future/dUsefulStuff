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
assertSet BUILD_CONFIGURATION

# Moves the  <user>.pbxuser file out of the way so that command line compiles 
# will work without error. Otherwise it's presence triggers an exception.
archivePbxuser() {
	if [[ $XCODE_VERSION_ACTUAL != "0400" && $XCODE_VERSION_ACTUAL != "4.0" ]]; then
		echo "Moving pbxuser file out of the way...."
		mv $PROJECT_NAME.xcodeproj/$USER.pbxuser $PROJECT_NAME.xcodeproj/$USER.pbxuser.old
	fi
}

# Restores the <user>.pbxuser file so that xcode can continue working.
restorePbxuser() {
	if [[ $XCODE_VERSION_ACTUAL != "0400" && $XCODE_VERSION_ACTUAL != "4.0" ]]; then
		echo "Restoring pbxuser file...."
		mv $PROJECT_NAME.xcodeproj/$USER.pbxuser.old $PROJECT_NAME.xcodeproj/$USER.pbxuser
	fi
}

# Encapslates the compilation of the project against a specific set of architectures.
compile() {

	echo "Starting compilation ..."

	archivePbxuser

	# Reset error trapping.
	set +o errexit

	echo "Building $COMPILE_ARCHS library ..."
	xcodebuild -target "$BUILD_TARGET" -sdk $COMPILE_SDK -configuration $BUILD_CONFIGURATION VALID_ARCHS="$COMPILE_VALID_ARCHS" ARCHS="$COMPILE_ARCHS"
	BUILD_RC=$?
	
	# if it failed then restore user settings and exit.
	if [ $BUILD_RC != 0 ]; then
		echo "Executing build failure sequence ..."
		restorePbxuser
		echo "Exiting as build threw an error."
		exit $BUILD_RC
	fi
	
	echo "Compiled."
	
	restorePbxuser
	
	# Restore error trapping.
	set -o errexit
}


# Start of run.
echo "Starting build ..."

COMPILE_SDK=$SIMULATOR_SDK
COMPILE_VALID_ARCHS=$SIMULATOR_VALID_ARCHS
COMPILE_ARCHS=$SIMULATOR_ARCHS
compile

COMPILE_SDK=$DEVICE_SDK
COMPILE_VALID_ARCHS=$DEVICE_VALID_ARCHS
COMPILE_ARCHS=$DEVICE_ARCHS
compile

echo "Combining libraries..."
mkdir "$BUILD_DIR/lib"
lipo -create "${PROJECT_DIR}/build/$BUILD_CONFIGURATION-iphoneos/lib${PROJECT_NAME}.a" "${PROJECT_DIR}/build/$BUILD_CONFIGURATION-iphonesimulator/lib${PROJECT_NAME}.a" -o "$BUILD_DIR/lib/$PROJECT_NAME"

echo "Static library created at $BUILD_DIR/lib/$PROJECT_NAME"

exit 0

