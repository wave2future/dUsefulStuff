# This file contains default values for the builds. 
# You should update it whenever you upgrade xcode with new SDKs etc.

echo Loading default values ...

DC_PROJECT_NAME=${PROJECT_NAME=$PRODUCT_NAME}

# Exports from main build.
export DC_SCRIPTS_DIR 
export DC_PROJECT_NAME 
export DC_PRODUCT_NAME 
export DC_COMPANY_ID
export DC_CURRENT_PROJECT_VERSION 
export DC_BUILD_TARGET 
export DC_SRC
export DC_AUTHOR
export DC_COMPANY

# Set used directories. Notice some allow for setting from xcode.
DC_TOOLS_DIR=${DC_TOOLS_DIR=../tools}
DC_PROJECT_DIR=${PROJECT_DIR=.}
DC_BUILD_DIR=${BUILD_DIR=build}
DC_UNIVERSAL_DIR=$BUILD_DIR/universal
DC_ARTIFACT_DIR=Releases/v$DC_CURRENT_PROJECT_VERSION

DC_DMG_FILE=Releases/$DC_PRODUCT_NAME-$DC_CURRENT_PROJECT_VERSION.dmg

export DC_TOOLS_DIR 
export DC_BUILD_DIR 
export DC_UNIVERSAL_DIR 
export DC_PROJECT_DIR 
export DC_ARTIFACT_DIR 
export DC_DMG_FILE

# SDKs.
DC_SIMULATOR_SDK=iphonesimulator4.2
DC_SIMULATOR_ARCHS=i386
DC_SIMULATOR_VALID_ARCHS=i386

DC_DEVICE_SDK=iphoneos4.2
DC_DEVICE_ARCHS="armv6 armv7"
DC_DEVICE_VALID_ARCHS="armv6 armv7"

export DC_SIMULATOR_SDK 
export DC_SIMULATOR_ARCHS 
export DC_SIMULATOR_VALID_ARCHS 
export DC_DEVICE_SDK 
export DC_DEVICE_ARCHS 
export DC_DEVICE_VALID_ARCHS

# Normally this is set to release. But you can override it 
# or use the --debug command line parameter to switch to debug.
DC_BUILD_CONFIGURATION=${BUILD_CONFIGURATION=Release}

export DC_BUILD_CONFIGURATION

DC_APPLEDOC_DIR=${DC_APPLEDOC_DIR=$DC_TOOLS_DIR/appledoc}
DC_APPLEDOC=${DC_APPLEDOC=$DC_APPLEDOC_DIR/appledoc}
DC_APPLEDOC_TEMPLATES_DIR=${DC_APPLEDOC_TEMPLATES_DIR=$DC_APPLEDOC_DIR/Templates}

if [ ! -f $DC_APPLEDOC ]; then
	echo "Warning: Appledoc not found at $DC_APPLEDOC"
fi

export DC_APPLEDOC_DIR
export DC_APPLEDOC
export DC_APPLEDOC_TEMPLATES_DIR

# Framework related settings.
DC_FRAMEWORK_DIR=$DC_ARTIFACT_DIR/$DC_PROJECT_NAME.framework  

export DC_FRAMEWORK_DIR
