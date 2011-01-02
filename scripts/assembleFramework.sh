#!/bin/sh

# assembleFramework.sh
# dUsefulStuff
#
# Created by Derek Clarkson on 27/08/10.
# Copyright 2010 Derek Clarkson. All rights reserved.

echo "Creating artifact directory ..."
mkdir -p $DC_ARTIFACT_DIR

echo "Setting up framework directories..."  
mkdir -p $DC_FRAMEWORK_DIR  
mkdir -p $DC_FRAMEWORK_DIR/Versions  
mkdir -p $DC_FRAMEWORK_DIR/Versions/$DC_CURRENT_PROJECT_VERSION
mkdir -p $DC_FRAMEWORK_DIR/Versions/$DC_CURRENT_PROJECT_VERSION/Resources
mkdir -p $DC_FRAMEWORK_DIR/Versions/$DC_CURRENT_PROJECT_VERSION/Headers

# Copying files
echo "Copying files into place ..."
find $DC_BUILD_DIR/$DC_BUILD_CONFIGURATION-iphoneos -name "*.h" -exec cp -v "{}" $DC_FRAMEWORK_DIR/Versions/$DC_CURRENT_PROJECT_VERSION/Headers \;
cp -v "$DC_UNIVERSAL_DIR/$DC_PROJECT_NAME" $DC_FRAMEWORK_DIR/Versions/$DC_CURRENT_PROJECT_VERSION

echo "Creating framework symlinks..."  
ln -s $DC_CURRENT_PROJECT_VERSION $DC_FRAMEWORK_DIR/Versions/Current
ln -s Versions/Current/Headers $DC_FRAMEWORK_DIR/Headers
ln -s Versions/Current/Resources $DC_FRAMEWORK_DIR/Resources
ln -s Versions/Current/$DC_PROJECT_NAME $DC_FRAMEWORK_DIR/$DC_PROJECT_NAME 

echo "Creating plist for framework ..."
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>English</string>
	<key>CFBundleExecutable</key>
	<string>${DC_PROJECT_NAME}</string>
	<key>CFBundleIdentifier</key>
	<string>${DC_COMPANY_ID}.${DC_PROJECT_NAME}</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundlePackageType</key>
	<string>FMWK</string>
	<key>CFBundleSignature</key>
	<string>????</string>
	<key>CFBundleVersion</key>
	<string>${DC_CURRENT_PROJECT_VERSION}</string>
</dict>
</plist>" > "$DC_FRAMEWORK_DIR/Resources/Info.plist"

exit 0
