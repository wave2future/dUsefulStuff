# dUsefulStuff static library v0.0.4

This library is intended as a container of useful defines and classes which can make life easier when developing iPhone applications. It's built as a set of static libraries, ready to go. Of course you can also use the source code as well.

# Installing

1. Download the latest dmg file. This contains compiled versions of the library for the devices (iPhone and iPad), simulator, documentation and some sample graphics.
1. Copy the library contents to a folder somewhere. For example, ~/projects/libs/dUsefulStuff
1. Drag and drop the dUsefulStuff.framework folder to xcode.
1. Add the header imports you need to your project. As this is a framework, you can now use the framework style syntax. For example

		#import <dUsefulStuff/DCUIRating.h>

# The library

## DCCommons.h

This header fine contains the following useful defines :

<table>
<tr>
<th> Define</th>
<th> Description</th>
</tr>
<tr>
<td> DC_LOG(template, ...) </td>
<td> Wraps NSLog and includes only the compiler flag DC_DEBUG is set.</td>
</tr>
<tr>
<td> DC_LOG_LAYOUT(UIView) </td>
<td> Logs the position and size of the passed UIView instance.</td>
</tr>
<tr>
<td> DC_DEALLOC(name) </td>
<td> Cleanly releases pointers and set 's then to point at nil. Also will log various info to
	NSLog if DC_LOG_DEALLOC is set as a compiler flag.</td>
</tr>
<tr>
	<td>DC_PRETTY_BOOL(boolean)</td>
	<td>Outputs either the string "YES" or "NO". Useful for logging.</td>
</tr>
<tr>
	<td>DC_DATA_TO_STRING(data)</td>
	<td>Returns a NSString * from the passed NSData *.</td>
</tr>
<tr>
	<td>DC_STRING_TO_DATA(string)</td>
	<td>Returns a NSData * from the passed NSString *.</td>
</tr>
<tr>
	<td>DC_MOCK_VALUE(variable)</td>
	<td>An update to the OCMOCK_VALUE define. Works better with iPhone code.</td>
</tr>
</table>

## DCUIRating

![Screen dump of rating controller](http://drekka.github.com/images/screendump1.png)

This class can be used on iPhone displays to produce a star rating control similar to what you can see in Tunes. It produces a single horizontal bar of 5 images across the display. The user can tap or swipe across the bar to set the rating value they want. In addition, it can also display a popup like bubble showing the current value of the control when the users finger is touching it. This is useful for instant feed back because he users finger often obscures the control and therefore the current value.

It's core features include :

* 3 scales : 0 - 5, 0 - 5 with half values, and 0 - 10.
* Provided star images but can be configured with any images you like.
* Resizes itself to match the width and height of the supplied images.
* Can popup a bubble above the users finger displaying the newly selected rating.
* Bubble background, font and colour is all configurable.

### Using DCUIRating

1. First you need to add some code to your controller. You will need an outlet for each rating controller you want to add to the view. Here's the header file:

		#import <UIKit/UIKit.h>
		#import "DCUIRating.h"
		
		@interface RatingTestController : UIViewController {
		
			@private
			DCUIRating * ratingControl;
		
		}
		
		@property (retain, nonatomic) IBOutlet DCUIRating * ratingControl;
		
		@end

1. Then you will need to add the following code to your **viewDidLoad:** method:

		- (void) viewDidLoad {
			[super viewDidLoad];
			
			// Load the images for the active and inactive rating symbols.
			NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"star" ofType:@"png"];
			UIImage *myNoRatingImage = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
		
			imagePath = [[NSBundle mainBundle] pathForResource:@"star-active" ofType:@"png"];
			UIImage *myRatingImage = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
		
			// Now setup the rating control. First the properties.
			self.ratingControl.onRatingImage = myRatingImage;
			self.ratingControl.offRatingImage = myNoRatingImage;
			self.ratingControl.bubbleBackgroundImage = myBubbleImage;
			self.ratingControl.scaleType = DC_SCALE_0_TO_5;
			
			// Now tell the control it can setup.
			[self.ratingControl setupControl];
			
		}

1. The last thing to do is to add the the control to your xib file. Open Interface Builder and the view. 
1. In the **Library** dialog, click on the **Classes** button to show all classes in the project.
1. Scroll down until you find the DCUIRating classes, then drag it onto your view.
1. Size and position the control. Note you won't see anything because Interface Builder does not see it as a control and therefore does not draw it. Also note that an instance of DCUIRating will resize itself to fit the height and 5 times the width of the inactive image you set in the controller code.
1. Lastly, make sure that the control is connected to the controllers IBOutlet.


## NSDictionary + dUsefulStuff and NSMutableDictionary + dUsefulStuff

These two are categories which allow you to store and retrieve dictionary entries based on the integer primitive.This saves having to do constant boxing and unboxing of values when you want to index based on a number .

## DCAlerts

Class of static methods for displaying messages to the user.

## Scripts

In the **scripts** directory there are a number of scripts which can be used for building static libraries and documentation from the command line. To see an example how they can be used look at the **build.sh** file in the source root of this project. Each script is a distinct part or phase of a build process. Here users of Ant or Maven will be familiar with what I am talking about. These scripts are designed to be used either from a command line or from within xcode. Hence they make use of the standard xcode properties.

Here is an example of using them (actually it's a copy of the build.sh script :-):

		#!/bin/sh
		
		# build.sh
		# dUsefulStuff
		#
		# Created by Derek Clarkson on 27/08/10.
		# Copyright 2010 Derek Clarkson. All rights reserved.
		
		# Exit if an error occurs.
		set -o errexit
		# Disallows unset variables.
		set -o nounset
		
		# Set build related values.
		PRODUCT_NAME=dUsefulStuff
		PROJECT_NAME=$PRODUCT_NAME
		CURRENT_PROJECT_VERSION=0.0.4
		SRC=src/code
		
		BUILD_TARGET="Build Library"
		
		# SDKs.
		SIMULATOR_SDK=iphonesimulator3.2
		SIMULATOR_ARCHS=i386
		SIMULATOR_VALID_ARCHS=i386
		DEVICE_SDK=iphoneos3.2
		DEVICE_ARCHS="armv6 armv7"
		DEVICE_VALID_ARCHS="armv6 armv7"
		
		# Set used directories. Notice some allow for setting from xcode.
		SCRIPTS_DIR=./scripts
		TOOLS_DIR=../tools
		EXTERNAL_DIR=../External
		PROJECT_DIR=${PROJECT_DIR=.}
		BUILD_DIR=${BUILD_DIR=build}
		ARTIFACT_DIR=Releases/v$CURRENT_PROJECT_VERSION
		
		DMG_FILE=Releases/$PRODUCT_NAME-$CURRENT_PROJECT_VERSION.dmg
		
		# Export so the scripts can see the setting.
		export SCRIPTS_DIR TOOLS_DIR EXTERNAL_DIR SIMULATOR_SDK SIMULATOR_ARCHS SIMULATOR_VALID_ARCHS DEVICE_SDK DEVICE_ARCHS DEVICE_VALID_ARCHS PROJECT_NAME PRODUCT_NAME BUILD_DIR PROJECT_DIR CURRENT_PROJECT_VERSION BUILD_TARGET ARTIFACT_DIR DMG_FILE SRC
		
		# Call the scripts.
		$SCRIPTS_DIR/clean.sh
		$SCRIPTS_DIR/buildStaticLibrary.sh
		$SCRIPTS_DIR/createDocumentation.sh
		$SCRIPTS_DIR/assembleFramework.sh
		$SCRIPTS_DIR/createDmg.sh

### buildStaticLibrary.sh

This is the main script for building. It will compile both a simulator and device version of the code in your project and then combine them into a single library. 

### common.sh

A script which is included by other scripts to provide some commonly used functions.

### createDocumentation.sh

This script will create and install api documentation using he doxygen and appledoc tools. If either of these two tools are not found then documentation is not created and wil be skipped. Setting this up is quite complicated because it also depends on a **docset.plist** file and a **doxygen-appledoc.config** file. Both of these are supplied in the dmg.

### clean.sh

This is the equivalent of the ant and maven clean tasks. It deletes the projects build directory and the target artifacts and directories. 

### assembleFramework.sh

This script takes in the compiled static library and creates a framework. This also includes the header files and the **framework.plist** file. This framework is assembled in the artifact directory.

### createDmg.sh

This takes in all the files it finds into the artifact directory and builds a dmg file suitable for uploaded to distribution sites. Also included are any markdown documentation files (such as this one) that are in the project.


 