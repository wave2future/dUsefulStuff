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
@synthesize padding;
@synthesize scaleType;
@synthesize displayBubble;

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
	DC_LOG(@"Padding                   : %i", self.padding);
	DC_LOG(@"ScaleType                 : %i", self.scaleType);

	// Make sure the control cannot be auto sized.
	self.autoresizingMask = UIViewAutoresizingNone;

	// Setup common values.
	offsetPixels = offRatingImage.size.width + self.padding;

	// Work out the size of each segement in the display.
	segmentSize = scaleType == DC_SCALE_0_TO_5 ? offsetPixels : offsetPixels / 2;

	// Calculate a fuzz factor to require less precision.
	float fuzz = self.offRatingImage.size.width * 0.7;
	fuzzFactor = self.scaleType == DC_SCALE_0_TO_5 ? fuzz : fuzz / 2;

	// Adjust the size of the control to fit the new size.
	CGRect newSize = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.offRatingImage.size.width * 5 + self.padding * 4, self.offRatingImage.size.height);
	DC_LOG(@"Updating component size from %f x %f to %f x %f", self.bounds.size.width, self.bounds.size.height, newSize.size.width, newSize.size.height);
	self.frame = newSize;

	controlIsSetup = YES;

}

/*
 * - (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { // From UIResponder
 *      DC_LOG(@"Starting touch event");
 *      [self calculateRatingWithTouch:[[event touchesForView:self] anyObject]];
 * }
 */

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {     // From UIResponder
	DC_LOG(@"Ending touch event");
	[self calculateRatingWithTouch:[[event touchesForView:self] anyObject]];
	[super touchesEnded:touches withEvent:event];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {     // From UIResponder
	DC_LOG(@"Touch moved event");
	[self calculateRatingWithTouch:[[event touchesForView:self] anyObject]];
	[super touchesMoved:touches withEvent:event];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event { // From UIResponder
	DC_LOG(@"Touch cancelled event");
	[self calculateRatingWithTouch:[[event touchesForView:self] anyObject]];
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
			DC_LOG(@"Drawing active rating");

			// Use half ratings if 0-5 with halves or 0-10 and the next whole image index is grater than the rating.
			if (self.scaleType != DC_SCALE_0_TO_5 && i + 1 > scaledRating) {
				[self.halfRatingImage drawAtPoint:CGPointMake(offset, 0)];
			} else {
				[self.onRatingImage drawAtPoint:CGPointMake(offset, 0)];
			}

		} else {
			// Images for the off part of the rating.
			DC_LOG(@"Drawing inactive rating");
			[self.offRatingImage drawAtPoint:CGPointMake(offset, 0)];
		}

		// Advance the offset to the next position depending on the size of the images.
		offset += offsetPixels;
	}
}

- (void) calculateRatingWithTouch:(UITouch *)aTouch {

	// Get a basic rating.
	float touchLocationX = [aTouch locationInView:self].x;
	float newRating = floor((touchLocationX + fuzzFactor) / segmentSize);

	// Adjust rating if allowing halves.
	newRating = self.scaleType == DC_SCALE_0_TO_5_WITH_HALVES ? newRating / 2 : newRating;

	// Account for out of range.
	newRating = fmin(self.scaleType == DC_SCALE_0_TO_10 ? 10 : 5, newRating);
	newRating = fmax(0.0, newRating);

	DC_LOG(@"Touch x: %f, offsetSize: %i, fuzzFactor: %f, rating: %f", touchLocationX, offsetPixels, fuzzFactor, newRating);

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
	[super dealloc];
}

@end
