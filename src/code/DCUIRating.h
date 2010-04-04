//
//  DCUIRating.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 23/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <UIKit/UIControl.h>

/**
 * What type of scale the control uses.
 */
enum DCScaleEnum {
	DC_SCALE_0_TO_5,                     // 0, 1, 2, 3 ... 5
	DC_SCALE_0_TO_5_WITH_HALVES,         // 0, 0.5, 1, 1.5, ... 5
	DC_SCALE_0_TO_10                     // 0, 1, 2, 3, ... 10
};
typedef enum DCScaleEnum DCRATINGSCALE;

/**
 * This control provides a rating display similar to that seen in iTunes for rating songs. It draws a set of 5 icons across the display which the user can use to select a rating from 0 to 5.
 * The user can select a rating value by either taping the control at the rating they want, or swiping their finger back and forwards to adjust the rating.
 *
 * There are two options for the value of the rating. Like iTunes the default is a value from 0 - 5. Each icon from left to right represents 1 rating value, so tapping the second icon from the right will choose a rating of 4 out of 5. However you can also select to using ratings from 0 to 10 or 0 - 5 with half values. This is represented by the control drawing half stars for either the odd numbers or half values.
 */
@interface DCUIRating : UIControl {
	@private
	UIImage *offRatingImage;
	UIImage *onRatingImage;
	UIImage *halfRatingImage;
	DCRATINGSCALE scaleType;
	int padding;
	double rating;
	BOOL controlIsSetup;
	int offsetPixels;
	int segmentSize;
	float fuzzFactor;

}

/**
 * The current value of the control. This value depends on the current setting of the scaleType;
 */
@property (nonatomic) double rating;

/**
 * This method must be called before the first drawRect: call is made by the UI. Preferably call this in the viewDidLoad: as part of setting up the control.
 * It's job is to store in the control all the images and settings that the control needs to layout the rating display. It also calculates various values used internally during the controls operation by the user.
 * \param aRatingImage - the image that will be used to represent a selected rating. For example a filled in star.
 * \param aNoRatingImage the image that will be used to represent a rating not selected by the user. For example a star outline.
 * \param aHalfRatingImage the image used whenusing the 0 - 10 or 0 - 5 with halves scales. This image is used when a half rating is needed. For example a half filled in star. If using the DC_SCALE_0_TO_5 scale, this parameter can be nil as it is not used.
 * \param aPadding the number of pixels padding to apply between images. usually 0.
 * \param aScaleType one of the above DCRATINGSCALE enum values above. Most of the time DC_SCALE_0_TO_5 would be used.
 */
- (void) setupControlWithRatingImage:(UIImage *)aRatingImage noRatingImage:(UIImage *)aNoRatingImage
  halfRatingImage:(UIImage *)aHalfRatingImage padding:(int)aPadding scaleType:(DCRATINGSCALE)aScaleType;


@end
