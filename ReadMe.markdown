# dUsefulStuff static library v0.0.3

This library is intended as a container of useful defines and classes which can make life easier when developing iPhone applications. It's built as a set of static libraries, ready to go. Of course you can also use the source code as well.

The only difference between the Release and debug versions is that the Debug versions contain debug code wihich logs information out to the standard out via NSLog(). Generaly speaking you won't need this unless you want to see whats going on inside a particular class from the library.


# Installing

This is if you want to just use the library.

1. Download the latest dmg file. This contains compiled versions of the library for the devices (IiPhone and iPad) and simulator, in both debug and release versions.
1. Create a group within Frameworks in your XCode project.
1. Drag and drop one of the four libraries into the group:
    
	 /Releases/libdUsefulStuff-device.a   
    /Releases/libdUsefulStuff-simulator.a   
    /Debug/libdUsefulStuff-device.a   
    /Debug/libdUsefulStuff-simulator.a   
 
    Don't forget to link, not copy this.
1. Select all the .h header files and drag them into the group as well. 

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

![Screen dump of rating controller](blob/master/screendump1.png)

This class can be used on iPhone displays to produce a star rating control similar to what you can see in Tunes. It produces a single horizontal bar of 5 images across the display. The user can tap or swipe across the bar to set the rating value they want.

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

