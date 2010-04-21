//
//  DCUIRating.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 23/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import "DCUIRating.h"
#import "DCCommon.h"
#import <UIKit/UIKit.h>

@interface DCUIRating ()
- (void) calculateRatingWithTouch:(UITouch *)aTouch;
@end

@implementation DCUIRating

@synthesize rating;
@synthesize offRatingImage;
@synthesize onRatingImage;
@synthesize halfRatingImage;
@synthesize scaleType;
@synthesize bubbleBackgroundImage;

- (void) setupControl {

	// Validate that all required properties are setup.
	if (self.offRatingImage == nil || self.onRatingImage == nil) {
		@throw [NSException exceptionWithName : @"InvalidSetupException" reason : @"Rating images have not been set. Both the off and on images must be present." userInfo : nil];
	}

	if (self.scaleType != DC_SCALE_0_TO_5 && self.halfRatingImage == nil) {
		@throw [NSException exceptionWithName : @"InvalidSetupException" reason : @"Scale type requires a half rating image to be set." userInfo : nil];
	}

	DC_LOG(@"offRatingImage.size.width : %f", self.offRatingImage.size.width);
	DC_LOG(@"offRatingImage.size.height: %f", self.offRatingImage.size.height);
	DC_LOG(@"ScaleType                 : %i", self.scaleType);

	// Make sure the control cannot be auto sized.
	self.autoresizingMask = UIViewAutoresizingNone;

	// Setup common values.
	offsetPixels = offRatingImage.size.width;

	// Work out the size of each segement in the display.
	segmentSize = scaleType == DC_SCALE_0_TO_5 ? offsetPixels : offsetPixels / 2;

	// Calculate a fuzz factor to require less precision.
	float fuzz = self.offRatingImage.size.width * 0.7;
	fuzzFactor = self.scaleType == DC_SCALE_0_TO_5 ? fuzz : fuzz / 2;

	// Adjust the size of the control to fit the new size.
	controlWidth = self.offRatingImage.size.width * 5;
	CGRect newSize = CGRectMake(self.frame.origin.x, self.frame.origin.y, controlWidth, self.offRatingImage.size.height);
	DC_LOG(@"Updating component size from %fx%f to %fx%f", self.frame.size.width, self.frame.size.height, newSize.size.width, newSize.size.height);
	self.frame = newSize;

	// Create a subview for the popup bubble.
	if (bubbleBackgroundImage != nil) {
		DC_LOG(@"Adding bubble to control");
		bubbleView = [[BubbleView alloc] initWithImage:self.bubbleBackgroundImage];
		[self addSubview:bubbleView];

		// Don't clip.
		self.clipsToBounds = NO;

		// Bring ourselves to the front of the window. This is only important when we
		// have a bubble so that the bubble appears on top of everything else.
		[self.superview bringSubviewToFront:self];
	}

	controlIsSetup = YES;

}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { // From UIResponder
	DC_LOG(@"Starting touch event");
	bubbleView.hidden = NO;
	[self calculateRatingWithTouch:[[event touchesForView:self] anyObject]];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {     // From UIResponder
	DC_LOG(@"Ending touch event");
	[self calculateRatingWithTouch:[[event touchesForView:self] anyObject]];
	bubbleView.hidden = YES;
	[self setNeedsDisplay];
	[super touchesEnded:touches withEvent:event];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {     // From UIResponder
	DC_LOG(@"Touch moved event");
	UITouch *aTouch = [[event touchesForView:self] anyObject];
	if (lastTouchX != [aTouch locationInView:self].x) {
		[self setNeedsDisplay];
	}
	[self calculateRatingWithTouch:aTouch];
	[super touchesMoved:touches withEvent:event];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event { // From UIResponder
	DC_LOG(@"Touch cancelled event");
	[self calculateRatingWithTouch:[[event touchesForView:self] anyObject]];
	bubbleView.hidden = YES;
	[self setNeedsDisplay];
	[super touchesCancelled:touches withEvent:event];
}

- (void) drawRect:(CGRect)rect {                                        // From UIView

	if (!controlIsSetup) {
		@throw [NSException exceptionWithName : @"NotSetupException" reason : @"The setUpControl: method must be called before drawing first occurs" userInfo : nil];
	}

	// Adjust display rating so it's within the 0-5 range.
	float scaledRating = self.scaleType == DC_SCALE_0_TO_10 ? self.rating / 2.0 : self.rating;

	int offset = 0;
	for (int i = 0; i < 5; i++) {
		if (i < scaledRating) {
			// Use half ratings if 0-5 with halves or 0-10 and the next whole image index is grater than the rating.
			if (self.scaleType != DC_SCALE_0_TO_5 && i + 1 > scaledRating) {
				DC_LOG(@"Drawing half rating at %i", offset);
				[self.halfRatingImage drawAtPoint:CGPointMake(offset, 0)];
			} else {
				DC_LOG(@"Drawing full rating at %i", offset);
				[self.onRatingImage drawAtPoint:CGPointMake(offset, 0)];
			}

		} else {
			// Images for the off part of the rating.
			DC_LOG(@"Drawing inactive rating at %i", offset);
			[self.offRatingImage drawAtPoint:CGPointMake(offset, 0)];
		}

		// Advance the offset to the next position depending on the size of the images.
		offset += offsetPixels;
	}

	// Adjust the bubble's frame to move it.
	[bubbleView moveToX:lastTouchX];

}

- (void) calculateRatingWithTouch:(UITouch *)aTouch {

	// Store the current touch X and handle when it's out of the controls range.
	lastTouchX = [aTouch locationInView:self].x;
	lastTouchX = fmin(controlWidth, lastTouchX);
	lastTouchX = fmax(0, lastTouchX);
	
	float newRating = floor((lastTouchX + fuzzFactor) / segmentSize);

	// Adjust rating if allowing halves.
	newRating = self.scaleType == DC_SCALE_0_TO_5_WITH_HALVES ? newRating / 2 : newRating;

	DC_LOG(@"Touch x: %f, offsetSize: %i, fuzzFactor: %f, rating: %f", lastTouchX, offsetPixels, fuzzFactor, newRating);

	// If the value has changed, initiate a screen update.
	if (self.rating != newRating) {
		self.rating = newRating;
		[self setNeedsDisplay];
	}

}

- (void) dealloc {
	self.offRatingImage = nil;
	self.onRatingImage = nil;
	self.halfRatingImage = nil;
	DC_DEALLOC(bubbleView);
	[super dealloc];
}

@end
