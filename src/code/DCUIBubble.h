//
//  BubbleView.h
//  dUsefulStuff
//
//  Created by Derek Clarkson on 19/04/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 A popup bubble.
 
 A bubble is a (usually) small display area that can be programmed to appear is a position
 which is related to another control. It usually displays a value or some text which the other
 control sends it. Typically bubbles appear when the user has their finger on the display and
 disappear when the user removes it. This is controlled by the other UIView through it's touch methods.
 */
@interface DCUIBubble : UIView {
	@private
	UIImage *background;
	UILabel *valueLabel;
	UIColor *color;
	UIColor *borderColor;
	int textOffsetXPixels;
	int textOffsetYPixels;
}

/// ---------------------------------------
/// @name Properties
/// ---------------------------------------

/**
 The colour to paint the value with.
 */
@property (nonatomic, retain) UIColor *fontColor;

/**
 The font to use.
 */
@property (nonatomic, retain) UIFont *font;

/**
 This shifts the text horizontaly. By default it is centered. Postive values move it to the right.
 */
@property (nonatomic) int textOffsetXPixels;

/**
 This shifts the text vertically. By default it is centered. Postive values move it up.
 */
@property (nonatomic) int textOffsetYPixels;

/**
 Can be set to define the formatting of float values. 
 
 If not set when the first draw occurs and the
 type is *DC_BUBBLE_VALUE_FLOAT*, this
 will be set to a formatter with 1 decimal place.
 */
@property (nonatomic, retain) NSNumberFormatter *decimalFormatter;

/**
 If an image is not supplied, this is the colour to paint the background with.
 */
@property (nonatomic, retain) UIColor *color;

/**
 If any image is not supplied this is the colour of the border for the background.
 */
@property (nonatomic, retain) UIColor *borderColor;

/// ---------------------------------------
/// @name Constructors
/// ---------------------------------------

/**
 Creates a bubble which makes use of the default rounded rectangle background. 
 
 Background colour and border colour can be set via properties.
 
 @param size the size in pixels to make the bubble.
 */
- (id) initWithSize:(CGSize)size;

/**
 Creates a bubble which uses an image as a background. This image can contain transparent areas. 
 
 BackgroundColor and borderColor values are ignored if this constructor is used.
 
 @param image an image to use as the backgroun to the bubble. To make odd shaped bubbles, use transparency.
 */
- (id) initWithBackgroundImage:(UIImage *)image;

/// ---------------------------------------
/// @name Events
/// ---------------------------------------

/**
 * Called by the parent control to position the bubble above it and to the right by a specified offset.
 * @param view the parent view.
 * @param offset how far along the control to display the bubble in pixels.
 */
- (void) positionAtView:(UIView *)view offset:(int) offset;


/// ---------------------------------------
/// @name Setting the value
/// ---------------------------------------

/**
 Sets the value to be displayed.
 
 @param aValue the value to display.
 */
- (void) setValue:(NSString *)aValue;

@end
