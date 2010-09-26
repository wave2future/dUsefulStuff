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
- (void) popBubbleAtTouch:(UITouch *)atTouch;
- (void) hideBubble;
- (void) updateBubble;
- (void) setupControl;
@end

@implementation DCUIRating

@synthesize rating;
@synthesize offRatingImage;
@synthesize onRatingImage;
@synthesize halfRatingImage;
@synthesize scaleType;
@synthesize bubble;

-(id) initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		self.hidden = YES;
	}
	return self;
}

- (id) initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.hidden = YES;
	}
	return self;
}

- (void) setupControl {

	DC_LOG(@"Doing final setup of control %@", self);

	// Setup common values.
	offsetPixels = (int)offRatingImage.size.width;
	DC_LOG(@"Offset pixels: %i", offsetPixels);

	// Work out the size of each segement in the display.
	segmentSize = scaleType == DC_SCALE_0_TO_5 ? offsetPixels : offsetPixels / 2;
	DC_LOG(@"Segment size: %i", segmentSize);

	// Calculate a fuzz factor around the users touch position.
	float fuzz = self.offRatingImage.size.width * 0.7;
	fuzzFactor = self.scaleType == DC_SCALE_0_TO_5 ? fuzz : fuzz / 2;
	DC_LOG(@"Fuzz factor: %f", fuzzFactor);

	// Adjust the size of the control to fit the new size.
	CGRect newSize = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.offRatingImage.size.width * 5, self.offRatingImage.size.height);
	DC_LOG(@"Updating component size from %f x %f to %f x %f", self.frame.size.width, self.frame.size.height, newSize.size.width, newSize.size.height);
	self.frame = newSize;

	self.hidden = NO;
	[self setNeedsDisplay];

}

- (void) popBubbleAtTouch:(UITouch *)atTouch {
	[self.bubble alignWithTough:atTouch];
	self.bubble.hidden = NO;
}

- (void) hideBubble {
	self.bubble.hidden = YES;
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { // From UIResponder
	DC_LOG(@"Starting touch event");
	UITouch *aTouch = [[event touchesForView:self] anyObject];
	[self calculateRatingWithTouch:aTouch];
	[self popBubbleAtTouch:aTouch];
	[super touchesBegan:touches withEvent:event];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {     // From UIResponder
	DC_LOG(@"Ending touch event");
	[self calculateRatingWithTouch:[[event touchesForView:self] anyObject]];
	[self hideBubble];
	[super touchesEnded:touches withEvent:event];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {     // From UIResponder
	DC_LOG(@"Touch moved event");
	UITouch *aTouch = [[event touchesForView:self] anyObject];
	if (lastTouchX != [aTouch locationInView:self].x) {
		[self calculateRatingWithTouch:aTouch];
		[self popBubbleAtTouch:aTouch];
	}
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event { // From UIResponder
	DC_LOG(@"Touch cancelled event");
	[self calculateRatingWithTouch:[[event touchesForView:self] anyObject]];
	[self hideBubble];
	[super touchesCancelled:touches withEvent:event];
}

- (void) drawRect:(CGRect)rect {                                        // From UIView

	DC_LOG(@"Drawing rating control: %@", self);

	// First check for the control had all setup precalculations done. If not, then queue
	// a setup call and exit.
	if (fuzzFactor == 0) {
		[self performSelector:@selector(setupControl)withObject:self afterDelay:0];
		return;
	}

	// Adjust display rating so it's within the 0-5 range.
	int lastActiveImageIndex = self.scaleType == DC_SCALE_0_TO_10 ? self.rating / 2.0 : self.rating;
	DC_LOG(@"Last active image index %i", lastActiveImageIndex);

	UIImage *image;
	for (int i = 0; i < 5; i++) {
		if (i < lastActiveImageIndex) {
			// Use half ratings if 0-5 with halves or 0-10 and the next whole image index is grater than the rating.
			if (self.scaleType != DC_SCALE_0_TO_5 && i + 1 > lastActiveImageIndex) {
				DC_LOG(@"Drawing half rating at %i", i * offsetPixels);
				image = self.halfRatingImage;
			} else {
				DC_LOG(@"Drawing full rating at %i", i * offsetPixels);
				image = self.onRatingImage;
			}
		} else {
			// Images for the off part of the rating.
			DC_LOG(@"Drawing inactive rating at %i", i * offsetPixels);
			image = self.offRatingImage;
		}
		[image drawAtPoint:CGPointMake(i * offsetPixels, 0)];

	}

}

- (void) calculateRatingWithTouch:(UITouch *)aTouch {

	DC_LOG_LAYOUT(aTouch.window);
	DC_LOG(@"Touch in window : %f x %f", [aTouch locationInView:aTouch.window].x, [aTouch locationInView:aTouch.window].y);
	DC_LOG_LAYOUT(aTouch.view);
	DC_LOG(@"Touch in control: %f x %f", [aTouch locationInView:self].x, [aTouch locationInView:self].y);

	// Store the current touch X and handle when it's out of the controls range.
	lastTouchX = (int)[aTouch locationInView:self].x;
	lastTouchX = fmin(self.frame.size.width, lastTouchX);
	lastTouchX = fmax(0, lastTouchX);

	// Add the fuzz factor. This creates the area around each star's center where
	// the users touch will still select it. Dividing by the segment size gives the
	// new rating.
	float newRating = floor((lastTouchX + fuzzFactor) / segmentSize);

	// Adjust rating if allowing halves.
	newRating = self.scaleType == DC_SCALE_0_TO_5_WITH_HALVES ? newRating / 2 : newRating;

	DC_LOG(@"Touch x: %i, offsetSize: %i, fuzzFactor: %f, rating: %f", lastTouchX, offsetPixels, fuzzFactor, newRating);
	if (self.rating != newRating) {
		self.rating = newRating;
		[self updateBubble];
		[self setNeedsDisplay];
	}

}

- (void) updateBubble {
	if (self.scaleType == DC_SCALE_0_TO_5_WITH_HALVES) {

		// If we are displaying a decimal and there is no formatter yet then create one.
		if (decimalFormatter == nil) {
			DC_LOG(@"Creating formatter");
			decimalFormatter = [[NSNumberFormatter alloc] init];
			[decimalFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
			[decimalFormatter setMinimumFractionDigits:1];
			[decimalFormatter setMaximumFractionDigits:1];
		}

		[self.bubble setValue:[decimalFormatter stringFromNumber:[NSNumber numberWithFloat:self.rating]]];

	} else {
		[self.bubble setValue:[NSString stringWithFormat:@"%i", (int)self.rating]];
	}

}


- (void) dealloc {
	self.offRatingImage = nil;
	self.onRatingImage = nil;
	self.halfRatingImage = nil;
	DC_DEALLOC(bubble);
	DC_DEALLOC(decimalFormatter);
	[super dealloc];
}

@end
