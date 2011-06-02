# dUsefulStuff static library

This library is intended as a container of useful defines and classes which can make life easier when developing iPhone applications. It's built as a set of static libraries, ready to go. Of course you can also use the source code as well.

# Installing

1. Download the latest dmg file. This contains a static framework usable on both iPhones and iPads, scripts, documentation and some sample graphics.
1. Copy the library contents to a folder somewhere. For example, ~/projects/libs/dUsefulStuff
1. Drag and drop the dUsefulStuff.framework folder to xcode. This is essentially the same as adding a framework.
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
	<td>OCMOCK_VALUE(variable)</td>
	<td>An update to the OCMOCK_VALUE define. Works better with iPhone code. Note that 
	to use this you must pass it a variable. Here's a simple example:
	<pre>
BOOL yes = YES;
[[mockThing expect] andReturnValue:OCMOCK_VALUE(yes)] isThingReady];</pre>
	</td>
</tr>
</table>

## DCUIRating

![Screen dump of rating controller](http://drekka.github.com/dUsefulStuff/Screenshot%202011.01.08%2021.25.08.png)

This class can be used on iPhone displays to produce a star rating control similar to what you can see in Tunes. It produces a single horizontal bar of 5 images across the display. The user can tap or swipe across the bar to set the rating value they want. In addition, you can create and add a DCUIBubble to it which will display the current value of the rating whenever the users finger is on the display. This is useful for instant feed back because he users finger often obscures the control and therefore the current value.

It's core features include :

* 3 scales addressable by the icons on the display : one whole icon = rating 1, half an icon = rating 0.5, or half an icon equals rating 1.
* Selectable number of icons - between 3 and 5.
* Provided star images but can be configured with any images you like.
* Resizes itself to match the width and height of the supplied images and number of icons specified.
* Can popup a bubble above the users finger displaying the newly selected rating.
* Able to update a delegate so your controller can respond to changes.

### Using DCUIRating

1. First you need to add some code to your controller. You will need an outlet for each rating controller you want to add to the view and you (optionally need to ensure that the delegate implements the DCUIRatingDelegate protocol. Here's an example header file:
 
		#import <UIKit/UIKit.h>
		#import <dUsefulStuff/DCUIRating.h>
		#import <dUsefulStuff/DCUIRatingDelegate.h>
		
		@interface RatingTestController : UIViewController<DCUIRatingDelegate> {
			@private
			DCUIRating * ratingControl;
		}
		
		@property (retain, nonatomic) IBOutlet DCUIRating * ratingControl;
		
		@end

1. And some example code interface your **viewDidLoad:** method:

		- (void) viewDidLoad {
			[super viewDidLoad];
			
			// Load the images for the active and inactive rating symbols.
			NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"star" ofType:@"png"];
			UIImage *myNoRatingImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
		
			imagePath = [[NSBundle mainBundle] pathForResource:@"star-active" ofType:@"png"];
			UIImage *myRatingImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
		
			// Now setup the rating control.
			self.ratingControl.onRatingImage = myRatingImage;
			self.ratingControl.offRatingImage = myNoRatingImage;
			self.ratingControl.scale = DCRatingScaleWhole;
			
			// Not required unless you want to get notified of changes.
			self.ratingControl.delegate = self;

			[myRatingImage release];
			[myNoRatingImage release];
			
			//Now add a bubble.
			imagePath = [[NSBundle mainBundle] pathForResource:@"bubble" ofType:@"png"];
			UIImage *myBubbleImage = [[UIImage alloc] initWithContentsOfFile:imagePath];

			DCUIBubble * bubble = [[DCUIBubble alloc] initWithBackgroundImage:myBubbleImage];
			bubble.textOffsetXPixels = -2;
			bubble.textOffsetYPixels = -9;
			bubble.fontColor = [UIColor redColor];
			
			self.ratingControl.bubble = bubble;

			[bubble release];
			[myBubbleImage release];
		}

		// Delegate method.
		-(void) ratingDidChange:(DCUIRating *) rating {
			DC_LOG(NSString stringWithFormat:@"Value: %f", rating.rating]);
		}


1. The last thing to do is to add the the control to your xib file. Open Interface Builder and the view. 
1. In the **Library** dialog, click on the **Classes** button to show all classes in the project.
1. Scroll down until you find the DCUIRating classes, then drag it onto your view.
1. Size and position the control. Note you won't see anything because Interface Builder does not see it
as a control and therefore does not draw it. Also note that an instance of DCUIRating will resize itself to fit the height and number of icons specified (5 is the default) using the width of the inactive image you have set.
1. Lastly, make sure that the control is connected to the controllers IBOutlet.

## DCUIBubble

This class can be used to display values from another control. 
Generally speakng it's designed to be a popup bubble which appears when the user presses their 
finger against a control. Here's a example of how your control can display a DCUIBubble

		- (void) popBubbleAtTouch:(UITouch *)atTouch {
			[self.bubble alignWithTough:atTouch];
			self.bubble.hidden = NO;
		}
		
		- (void) hideBubble {
			self.bubble.hidden = YES;
		}
				
		- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { // From UIResponder
			UITouch *aTouch = [[event touchesForView:self] anyObject];
			[self popBubbleAtTouch:aTouch];
			[super touchesBegan:touches withEvent:event];
		}
		
		- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {     // From UIResponder
			[self hideBubble];
			[super touchesEnded:touches withEvent:event];
		}
		
		- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {     // From UIResponder
			UITouch *aTouch = [[event touchesForView:self] anyObject];
			[self popBubbleAtTouch:aTouch];
			}
		}
		
		- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event { // From UIResponder
			[self hideBubble];
			[super touchesCancelled:touches withEvent:event];
		}
 
Setting the bubbles value is simple. here's an example which sets it to an integer value:

		[self.bubble setValue:[NSString stringWithFormat:@"%i", 5];

## NSDictionary+dUsefulStuff and NSMutableDictionary+dUsefulStuff

These two are categories which allow you to store and retrieve dictionary entries based on the integer primitive.This saves having to do constant boxing and unboxing of values when you want to index based on a number .

## UIColor+dUsefulStuff

This category adds a colour comparison function which can be used to test UIColor instances for equality.

## UIView+dUsefulStuff

This category adds a method for drawing rounded rectangles on the view.

## DCCoreData

This class is intended to be a base class providing infrastructure and useful methods for dealing with
core data.

## DCDialogs

Class of static methods for displaying messages to the user. Just takes some pain out of rewriting code.

## Scripts

In the **scripts** directory there are a number of scripts which can be used for building static libraries and documentation from the command line. To see an example how they can be used look at the **build.sh** file in the source root of this project. Each script is a distinct part or phase of a build process. Here users of Ant or Maven will be familiar with what I am talking about. These scripts are designed to be used either from a command line or from within xcode. Hence they make use of the standard xcode properties.

You will notice that all the sripts make use of variables prefixed with *DC_*. This is a deliberate thing because it makes it easier to see which variables are being used and there values.

Here is an example of using them (actually it's a copy of the build.sh script from this project :-). Check that file for the latest version and settings.

    #!/bin/sh

    # build.sh
    # dUsefulStuff
    #
    # Created by Derek Clarkson on 27/08/10.
    # Copyright 2010 Derek Clarkson. All rights reserved.

    # build specific.
    DC_CURRENT_PROJECT_VERSION=${CURRENT_PROJECT_VERSION=0.0.8}
    DC_PRODUCT_NAME=${PRODUCT_NAME=dUsefulStuff}
    DC_SRC=src/code
    DC_BUILD_TARGET="Build Library"
    DC_COMPANY_ID=au.com.derekclarkson
    DC_AUTHOR="Derek Clarkson"
    DC_COMPANY=$DC_AUTHOR

    DC_SCRIPTS_DIR=scripts

    # Include common scripts.
    source $DC_SCRIPTS_DIR/defaults.sh
    source $DC_SCRIPTS_DIR/common.sh

    # Clean and setup.
    $DC_SCRIPTS_DIR/clean.sh
    $DC_SCRIPTS_DIR/setup.sh

    # Check for a doco only build.
    if [ -n "$DC_BUILD_DOCO_ONLY" ]; then
    	$DC_SCRIPTS_DIR/createDocumentation.sh
    	exit 0
    fi

    # Otherwise do a full build.
    $DC_SCRIPTS_DIR/buildStaticLibrary.sh
    $DC_SCRIPTS_DIR/assembleFramework.sh
    $DC_SCRIPTS_DIR/createDocumentation.sh

    # Extra step here to copy the scripts into a directory of the dmg file.
    mkdir $DC_ARTIFACT_DIR/scripts
    find "scripts" -type f -name "*.sh" -depth 1 -exec cp -v "{}" "$DC_ARTIFACT_DIR/scripts" \;

    # Final assembly.
    $DC_SCRIPTS_DIR/createDmg.sh

### defaults.sh

This script takes in the values previously setup in the build.sh script and uses then as the basis for further settings. Therefore it is important that it is included using the *source* statement rather than called as a subscript.

### common.sh

A script which is included by other scripts to provide some commonly used functions. This script also handles arguments. There are several possible arguments that this build system understands so just do ./build.sh -? to see them.

### buildStaticLibrary.sh

This is the main script for building. It will compile both a simulator and device version of the code in your project and then combine them into a single static framework. 

### createDocumentation.sh

This script will create and install api documentation using *appledoc V2* tools. If appledoc is not found then documentation is not created and this step will be skipped. 

### clean.sh

This is the equivalent of the ant and maven clean tasks. It deletes the projects build directory and the target artifacts and directories. 

### assembleFramework.sh

This script takes in the compiled static library and creates a framework. This also includes the header files and the **framework.plist** file. This framework is assembled in the artifact directory.

### createDmg.sh

This takes in all the files it finds into the artifact directory and builds a dmg file suitable for uploaded to distribution sites. Also included are any markdown documentation files (such as this one) that are in the project.

## Uncrustify.sh

This is a shelle script which can be added to xcode as a script. You can use it to reformat the source code
using the uncrustify code formatter.

# Thanks

I'd like to say thanks to several developers for developing the following tools which have helped me tremendously is developing dUsefulStuff:

* Tomaž Kragelj for [Appledoc V2](http://www.gentlebytes.com/home/appledocapp/)
* Gabriel Handford for [GHUnit](https://github.com/gabriel/gh-unit)
* Erik Doernenburg for [OCMock](http://www.mulle-kybernetik.com/software/OCMock/)
