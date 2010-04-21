//
//  BubbleView.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 19/04/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * This control is used by DCUIRating to display the popup bubble with the rating value. 
 * This appears just above the rating control and scrolls sieways to track where the user's finger is.
 * It displays the current rating value.
 */
@interface BubbleView : UIView {
	@private
	float value;
	UIImage *background;
	int width;
	int height;
}

/**
 * Set by the DCUIRating control. This is the value to display.
 */
@property (nonatomic) float value;

/**
 * Default constructor which provides this control with it's back ground image.
 * the control then autoamtically sizes itself and sets itself up so that details such as transparency
 * and user interaction (off) are correct.
 */
- (BubbleView *) initWithImage:(UIImage *)backgroundImage;

/**
 * Called DCUIRating control to move this control to it's new horizontal position.
 */
- (void) moveToX:(int)x;

@end
