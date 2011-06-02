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
typedef enum {
	/// Each touchable rating icon represents an increment of 1. i.e. 0, 1, 2, 3, 4, 5
	/// Therefore each 
	DCRatingScaleWhole,
	
	/// Each touchable rating icon represents an increment of 2 halves which the user is able to select. This gives a finer level of control and value setting. i.e. 0, 0.5, 1, 1.5, ... 5
	DCRatingScaleHalf,
	/// Each touchable rating icon represents an increment of 2 which the user is able to select. This gives a finer level of control and value setting and produes a large range. i.e. 0, 1, 2, 3, ... 10
	DCRatingScaleDouble
} DCRatingScale;

/**
 This control provides a rating display similar to that seen in iTunes for rating songs. It draws a set of 3 to 5 icons across the display which the user can use to select a rating based on the scales in the DCScaleEnum (typedef DCRATINGSCALE). The user can select a rating value by either taping the control at the rating they want, or swiping their finger back and forwards to adjust the rating. However they must start the swipe inside the control.
 
 There are 3 scales which control the way the control calculates a rating from the users selection:
 
 * *DC_UI_RATING_SCALE_WHOLE* - the users actions can only turn whole rating icons on or off and each icon represents an increment of 1. This produces a sequence of ratings 0, 1, 2, ...
 * *DC_UI_RATING_SCALE_HALF* - the users actions can turn half a rating icon on or off and each half an icon represents an increment of 0.5. This produces a sequence of ratings 0, 0.5, 1, 1.5, ...
 * *DC_UI_RATING_SCALE_DOUBLE* - the users actions can turn half a rating icon on or off and each half an icon represents an increment of 1. This produces a sequence of ratings 0, 1, 2, ... 
 
 The maximum value is defined by the iconCount property. See the properties doco for details.
 
 The developer can also choose to display a popup bubble above the rating controller. This bubble tracks the
 users touch and displays the value during the touch operation. It appears at the first touch and disappears when
 the touch leaves. This bubble can be configured with an image background (setting this causes the bubble to be displayed), font, text colour and text position.
 */
@interface DCUIRating : UIControl {
@private
	
	// Public interface variables.
	NSObject<DCUIRatingDelegate> * delegate;
	int iconCount;
	DCRatingScale scale;
	
	// Internal use for display and layout.
	int lastTouchX;
	NSObject<DCUIRatingScaleStrategy> * scaleStrategy;
	
	//BOOL enabled;
}

//@property (nonatomic) BOOL enabled;

/** @name Properties */

/**
 If you wish to have the rating control notify another class of changes, implement the DCUIRatingDelegate
 protocol and set the class as the DCUIRating delegate.
 */
@property(assign,nonatomic) NSObject<DCUIRatingDelegate> * delegate;

/**
 Tells the control how many icons to draw.
 
 Must be one of 3, 4 or 5. This is also the maximum rating that the control will return unless scaleType is set to *DC_UI_RATING_SCALE_DOUBLE* in which case it is double. i.e. 3 = 6, 4 = 8, 5 = 10. 
 
 @exception NSException thrown if the number is out of range.
 
 */
@property (nonatomic) int iconCount;

/**
 Sets the scale.
 
 There are three options:
 
 - *DC_UI_RATING_SCALE_WHOLE*(default) - produces 0, 1, 2, 3, ...
 - *DC_UI_RATING_SCALE_HALF* - produces 0, 0.5, 1, 1.5, ... 
 - *DC_UI_RATING_SCALE_DOUBLE* - produces 0, 1, 2, 3, ... 
 */
@property (nonatomic) DCRatingScale scale;

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
