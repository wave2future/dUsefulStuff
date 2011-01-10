#!/bin/bash

# buildStaticLibrary.sh
# dUsefulStuff
#
# Created by Derek Clarkson on 26/08/10.
# Copyright 2010 Derek Clarkson. All rights reserved.

# Moves the  <user>.pbxuser file out of the way so that command line compiles 
# will work without error. Otherwise it's presence triggers an exception.
archivePbxuser() {
if [ -f $DC_PROJECT_NAME.xcodeproj/$USER.pbxuser ]; then
		echo "Moving pbxuser file out of the way...."
		mv $DC_PROJECT_NAME.xcodeproj/$USER.pbxuser $DC_PROJECT_NAME.xcodeproj/$USER.pbxuser.old
	fi
}

# Restores the <user>.pbxuser file so that xcode can continue working.
restorePbxuser() {
	if [ -f $DC_PROJECT_NAME.xcodeproj/$USER.pbxuser.old ]; then
		echo "Restoring pbxuser file...."
		mv $DC_PROJECT_NAME.xcodeproj/$USER.pbxuser.old $DC_PROJECT_NAME.xcodeproj/$USER.pbxuser
	fi
}

# Encapslates the compilation of the project against a specific set of architectures.
compile() {

	echo "Starting compilation ..."

	archivePbxuser

	# Reset error trapping.
	set +o errexit

	echo "Building $DC_COMPILE_ARCHS library ..."
	xcodebuild -target "$DC_BUILD_TARGET" -sdk $1 -configuration $DC_BUILD_CONFIGURATION VALID_ARCHS="$3" ARCHS="$2"
	DC_BUILD_RC=$?
	
	# if it failed then restore user settings and exit.
	if [ $DC_BUILD_RC != 0 ]; then
		echo "Executing build failure sequence ..."
		restorePbxuser
		echo "Exiting as build threw an error."
		exit $DC_BUILD_RC
	fi
	
	echo "Compiled."
	
	restorePbxuser
	
	# Restore error trapping.
	set -o errexit
}


# Start of run.
echo "Starting build ..."
compile "$DC_SIMULATOR_SDK" "$DC_SIMULATOR_ARCHS" "$DC_SIMULATOR_VALID_ARCHS"
compile "$DC_DEVICE_SDK" "$DC_DEVICE_ARCHS" "$DC_DEVICE_VALID_ARCHS"

echo "Combining libraries..."
echo "Creating universal directory $DC_UNIVERSAL_DIR"
mkdir "$DC_UNIVERSAL_DIR"
echo "Combining ..."
lipo -create "${DC_PROJECT_DIR}/build/$DC_BUILD_CONFIGURATION-iphoneos/lib${DC_PROJECT_NAME}.a" "${DC_PROJECT_DIR}/build/$DC_BUILD_CONFIGURATION-iphonesimulator/lib${DC_PROJECT_NAME}.a" -o "$DC_UNIVERSAL_DIR/$DC_PROJECT_NAME"

echo "Static library created at $DC_UNIVERSAL_DIR/$DC_PROJECT_NAME"

exit 0

