//
//  DCUIRating.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 23/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <UIKit/UIControl.h>
#import "DCUIBubble.h"
#import "DCUIRatingScaleStrategy.h"
#import "DCUIRating.h"
#import "DCUIRatingDelegate.h"

/**
 This enum dictates what type of scale the control uses.
 */
enum DCScaleEnum {
	/// @deprecated 0, 1, 2, 3 ... 5
	DC_SCALE_0_TO_5,

	/// @deprecated 0, 0.5, 1, 1.5, ... 5
	DC_SCALE_0_TO_5_WITH_HALVES,

	/// @deprecated 0, 1, 2, 3, ... 10
	DC_SCALE_0_TO_10,
	
	/// Each touchable rating icon represents an increment of 1. i.e. 0, 1, 2, 3, 4, 5
	/// Therefore each 
	DC_UI_RATING_SCALE_WHOLE,
	
	/// Each touchable rating icon represents an increment of 2 halves which the user is able to select. This gives a finer level of control and value setting. i.e. 0, 0.5, 1, 1.5, ... 5
	DC_UI_RATING_SCALE_HALF,
	/// Each touchable rating icon represents an increment of 2 which the user is able to select. This gives a finer level of control and value setting and produes a large range. i.e. 0, 1, 2, 3, ... 10
	DC_UI_RATING_SCALE_DOUBLE
};
typedef enum DCScaleEnum DCRATINGSCALE;

/**
 This control provides a rating display similar to that seen in iTunes for rating songs. It draws a set of 3 to 5 icons across the display which the user can use to select a rating based on the scales in the DCScaleEnum (typedef DCRATINGSCALE). The user can select a rating value by either taping the control at the rating they want, or swiping their finger back and forwards to adjust the rating. However they must start the swipe inside the control.
 
 There are six scale types (3 deprecated, 3 new) which control the way the control calculates a rating from the users selection. Here is a list of the scale types:
 
 * *DC_UI_RATING_SCALE_WHOLE* - the users actions can only turn whole rating icons on or off and each icon represents an increment of 1.
 
 The developer can also choose to display a popup bubble above the rating controller. This bubble tracks the
 users touch and displays the value during the touch operation. It appears at the first touch and disappears when
 the touch leaves. This bubble can be configured with an image background (setting this causes the bubble to be displayed), font, text colour and text position.
 */
@interface DCUIRating : UIControl {
	@private

	// Public interface variables.
	UIImage *offRatingImage;
	UIImage *onRatingImage;
	UIImage *halfRatingImage;
	DCRATINGSCALE scaleType;
	DCUIBubble *bubble;
	NSObject<DCUIRatingDelegate> * delegate;

	// Internal use for display and layout.
	int lastTouchX;
	float initialRating;
	NSObject<DCUIRatingScaleStrategy> * scaleStrategy;
}

/** @name Properties */

/**
 If you wish to have the rating control notify another class of changes, implement the DCUIRatingDelegate
 protocol and set the class as the DCUIRating delegate.
 */
@property(retain,nonatomic) NSObject<DCUIRatingDelegate> * delegate;

/**
 Defines the range of values that the control will produce. There are three options:

 - *DC_SCALE_0_TO_5* - produces 0, 1, 2, 3, 5
 - *DC_SCALE_0_TO_5_WITH_HALVES* - produces 0, 0.5, 1, 1.5, ... 5
 - *DC_SCALE_0_TO_10* - produces 0, 1, 2, 3, ... 10
 
 */
@property (nonatomic) DCRATINGSCALE scaleType;

/**
 The current value of the control. This value depends on the current setting of the scaleType; Set this value to have the control light up the necessary rating images.
 */
@property (nonatomic) float rating;

/** @name Icons */

/**
 The image to use for when a rating is on.
 */
@property (nonatomic, retain) UIImage *onRatingImage;

/**
 The image to use for when a rating is off.
 */
@property (nonatomic, retain) UIImage *offRatingImage;

/**
 If the scale type is 0 - 10 or 0 - 5 with halves, then this image is used to display the half/odd values.
 */
@property (nonatomic, retain) UIImage *halfRatingImage;

/** @name Bubble */

/**
 Set this property with an instance of DCUIBubble to have the bubble displayed when the user is touching the control.
 */
@property (nonatomic,retain) DCUIBubble * bubble;

@end
