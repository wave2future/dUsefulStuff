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
@interface DCUIRatingPopupBubble : UIView {
	@private
	float value;
	UIImage *background;
	UILabel *rating;
	float width;
	float height;
	NSNumberFormatter * decimalFormatter;
}

/**
 * Set by the DCUIRating control. This is the value to display.
 */
@property (nonatomic) float value;

/**
 * Default constructor which provides this control with it's back ground image.
 * the control then autoamtically sizes itself and sets itself up so that details such as transparency
 * and user interaction (off) are correct.
 * \param backgroundImage the image to use as the background to the bubble.
 * \param font the font to use to display the rating. Nil will default to the UILabels default font.
 * \param textColour an instance of UIColor which gives the colour to paint the rating text in. Nil will default to black.
 * \param xOffset an amount of pixels to add to the horizontal offset of the rating label in oder to position it.
 * \param yOffset an amount of pixels to add to the vertical offset of the rating label in oder to position it.
 * \param displayAsDecimal if YES, then the number is displayed using a decimal format.
 */
- (DCUIRatingPopupBubble *) initWithImage:(UIImage *)backgroundImage font:(UIFont *)font textColour:(UIColor *)textColour xOffset:(int)xOffset yOffset:(int)yOffset displayAsDecimal:(BOOL)displayAsDecimal;

/**
 * Called DCUIRating control to move this control to it's new horizontal position.
 * \param aTouch the touch event that triggered the move.
 */
- (void) alignWithTough:(UITouch *) aTouch;

@end
