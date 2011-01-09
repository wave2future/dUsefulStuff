# This file contains default values for the builds. 
# You should update it whenever you upgrade xcode with new SDKs etc.

# Also notice that most of the settings are coded to set a value unless one already exists.
# This allows you to set overrides when calling from xcode or other scripts. The basic form
# is:
#
#    VAR=${$VAR=<default value>}
#
# Which basically says that VAR is equal to the value of $VAR if it exists, otherwise the default is used.

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
export DC_SCRIPTS_DIR 

# Set variables which apply to many projects.
DC_PROJECT_DIR=${PROJECT_DIR=.}
DC_BUILD_DIR=${BUILD_DIR=build}

# Base directory where projects are stored. This is used to locate resources external to the project being built.
DC_PROJECTS_HOME=${DC_PROJECTS_HOME=$USER/projects}

DC_TOOLS_DIR=${DC_PROJECTS_HOME/tools}
DC_UNIVERSAL_DIR=${DC_UNIVERSAL_DIR=$BUILD_DIR/universal}
DC_ARTIFACT_DIR=${DC_ARTIFACT_DIR=$DC_PROJECTS_HOME/Releases/$DC_PROJECT_NAME/v$DC_CURRENT_PROJECT_VERSION}

DC_DMG_FILE=${$DC_DMG_FILE=$DC_PROJECTS_HOME/Releases/$DC_PROJECT_NAME/$DC_PRODUCT_NAME-$DC_CURRENT_PROJECT_VERSION.dmg}
DC_ATTACH_DMG=${DC_ATTACH_DMG=}

export DC_PROJECTS_HOME
export DC_TOOLS_DIR 
export DC_BUILD_DIR 
export DC_UNIVERSAL_DIR 
export DC_PROJECT_DIR 
export DC_ARTIFACT_DIR 
export DC_DMG_FILE
export DC_ATTACH_DMG

# SDKs.
DC_SIMULATOR_SDK=${$DC_SIMULATOR_SDK=iphonesimulator4.2}
DC_SIMULATOR_ARCHS=${$DC_SIMULATOR_ARCHS=i386}
DC_SIMULATOR_VALID_ARCHS=${$DC_SIMULATOR_VALID_ARCHS=i386}

DC_DEVICE_SDK=${$DC_DEVICE_SDK=iphoneos4.2}
DC_DEVICE_ARCHS=${$DC_DEVICE_ARCHS="armv6 armv7"}
DC_DEVICE_VALID_ARCHS=${$DC_DEVICE_VALID_ARCHS="armv6 armv7"}

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
DC_BUILD_DOCO_ONLY=${DC_BUILD_DOCO_ONLY=}

if [ ! -f $DC_APPLEDOC ]; then
	echo "Warning: Appledoc not found at $DC_APPLEDOC"
fi

export DC_APPLEDOC_DIR
export DC_APPLEDOC
export DC_APPLEDOC_TEMPLATES_DIR
export DC_BUILD_DOCO_ONLY

# Framework related settings.
DC_FRAMEWORK_DIR=${$DC_FRAMEWORK_DIR=$DC_ARTIFACT_DIR/$DC_PROJECT_NAME.framework}

export DC_FRAMEWORK_DIR

