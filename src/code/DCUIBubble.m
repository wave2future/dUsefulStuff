//
//  BubbleView.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 19/04/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import "DCUIBubble.h"
#import "DCCommon.h"
#import "UIView+dUsefulStuff.h"

/**
 * Declares private methods.
 */
@interface DCUIBubble ()
- (void) commonInit;
- (void) positionValueLabel;
@end


@implementation DCUIBubble

@synthesize decimalFormatter;
@synthesize color;
@synthesize borderColor;
@dynamic fontColor;
@dynamic font;
@dynamic textOffsetXPixels;
@dynamic textOffsetYPixels;

// Getter/Setters
- (UIColor *) fontColor {
	return valueLabel.textColor;
}

- (void) setFontColor:(UIColor *)aColor {
	valueLabel.textColor = aColor;
}

- (UIFont *) font {
	return valueLabel.font;
}

- (void) setFont:(UIFont *)aFont {
	valueLabel.font = aFont;
}

- (int) textOffsetXPixels {
	return textOffsetXPixels;
}

- (void) setTextOffsetXPixels:(int)xOffset {
	DC_LOG(@"Offsetting label horizontally by %i pixels.", xOffset);
	textOffsetXPixels = xOffset;
	[self positionValueLabel];
}

- (int) textOffsetYPixels {
	return textOffsetYPixels;
}

- (void) setTextOffsetYPixels:(int)yOffset {
	DC_LOG(@"Offsetting label vertically by %i pixels.", yOffset);
	textOffsetYPixels = yOffset;
	[self positionValueLabel];
}
// End Getter/Setters

- (id) initWithSize:(CGSize)size {
	self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
	if (self) {
		DC_LOG(@"Creating a bubble with a default background.");
		[self commonInit];
	}
	return self;
}

- (id) initWithBackgroundImage:(UIImage *)image {
	self = [super initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
	if (self) {
		DC_LOG(@"Creating a bubble with an image background.");
		background = [image retain];
		[self commonInit];
	}
	return self;
}

/**
 * Called by constructors to setup the rest of the control as much as possible.
 */
- (void) commonInit {

	DC_LOG(@"Executing common initialisation");
	self.userInteractionEnabled = NO;
	self.backgroundColor = [UIColor clearColor];
	self.hidden = YES;

	// Setup the label which displays the value.
	valueLabel = [[UILabel alloc] init];
	valueLabel.backgroundColor = [UIColor clearColor];
	valueLabel.textAlignment = UITextAlignmentCenter;
	[self positionValueLabel];

	// Add the label as a subview of this control.
	[self addSubview:valueLabel];
 
}

/**
 * Internal method which centers the label on the bubble.
 */
- (void) positionValueLabel {
	CGRect labelFrame = CGRectMake(textOffsetXPixels, textOffsetYPixels, self.frame.size.width, self.frame.size.height);
	valueLabel.frame = labelFrame;
	DC_LOG(@"Label offsets x => %i y => %i", textOffsetXPixels, textOffsetYPixels);
}

- (void) drawRect:(CGRect)rect {
	
	DC_LOG(@"Drawing bubble");
	if (background != nil) {
		//Draw the supplied graphic background.
		DC_LOG(@"Drawing background image.");
		[background drawInRect:CGRectMake(0, 0, background.size.width, background.size.height)];
	} else {
		[self drawRoundedRectOnContext:UIGraphicsGetCurrentContext() 
									rectangle:self.bounds 
										radius:10
								 borderWidth:2
								 borderColor:borderColor
									fillColor:color];
	}
}

- (void) alignWithTough:(UITouch *)aTouch {

	//If the bubble is not in the view hirachy then add it to the current window.
	//This effectively adds to to the top of the z-order.
	if (self.window == nil) {
		DC_LOG(@"Adding bubble to window");
		[[[UIApplication sharedApplication] keyWindow] addSubview:self];
	}

	// Tell the controls superview to calculate it's origin in main window.
	CGPoint controlOriginInWindow = [aTouch.view.superview convertPoint:aTouch.view.frame.origin toView:nil];
	DC_LOG(@"Control position in window: %f x %f", controlOriginInWindow.x, controlOriginInWindow.y);

	// Stop the bubble moving to far to the left or right.
	float bubbleXPos = fmin(controlOriginInWindow.x + aTouch.view.frame.size.width, [aTouch locationInView:aTouch.window].x);
	bubbleXPos = fmax(controlOriginInWindow.x, bubbleXPos);

	// Find out where the control is on the window and put the bubble above it.
	float bubbleYPos = controlOriginInWindow.y - self.frame.size.height;
	DC_LOG(@"Bubble Y pos %f = control.y %f - bubble.height %f", bubbleYPos, controlOriginInWindow.y, self.frame.size.height);

	// Position the bubble.
	self.frame = CGRectMake(bubbleXPos, bubbleYPos, self.frame.size.width, self.frame.size.height);

	[self setNeedsDisplay];
}

- (void) setStringValue:(NSString *)stringValue {
	valueLabel.text = stringValue;
}

- (void) setValue:(NSString *)aValue {
	DC_LOG(@"Setting value: %@", aValue);
	valueLabel.text = aValue;
}

- (void) dealloc {
	DC_DEALLOC(background);
	[valueLabel removeFromSuperview];
	DC_DEALLOC(valueLabel);
	DC_DEALLOC(decimalFormatter);
	DC_DEALLOC(color);
	DC_DEALLOC(borderColor);
	[super dealloc];
}

@end