//
// DCUIRating.m
// dUsefulStuff
//
// Created by Derek Clarkson on 23/03/10.
// Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DCUIRating.h"
#import "DCCommon.h"
#import "DCUIRatingScaleStrategy.h"
#import "DCUIRatingScaleWholeStrategy.h"
#import "DCUIRatingScaleHalfStrategy.h"
#import "DCUIRatingScaleDoubleStrategy.h"

/**
 private interface
 */
@interface DCUIRating ()
- (void) setDefaults;
- (void) calculateRatingWithTouch:(UITouch *) aTouch;
- (void) popBubbleAtTouch:(UITouch *) atTouch;
- (void) hideBubble;
- (void) updateBubble;
@end

@implementation DCUIRating

@dynamic rating;
@dynamic offRatingImage;
@dynamic onRatingImage;
@dynamic halfRatingImage;

@synthesize iconCount;
@synthesize bubble;
@synthesize delegate;
@synthesize scale;

#pragma mark Dynamic properties

- (void) setRating:(float) aRating {
	
	//Check that the rating is not above the scale/iconCount maximum value.
	int maxValue = iconCount * (scale == DC_UI_RATING_SCALE_DOUBLE ? 2: 1);
	if (aRating > maxValue) {
		DC_LOG(@"Passed rating %f greater than max rating %i, resetting to max.", aRating, maxValue);
		aRating = maxValue;
	} else if (aRating < 0) {
		//Check that the rating is not below zero.
		DC_LOG(@"Passed rating %f less than  zero, resetting to zero.", aRating);
		aRating = 0;
	}
	
	[scaleStrategy setRating:aRating];
	DC_LOG(@"Triggering a refresh");
	[self setNeedsDisplay];
}

- (float) rating {
	return [scaleStrategy rating];
}

- (void) setOffRatingImage:(UIImage *) image {
	scaleStrategy.offImage = image;
	[self sizeToFit];
}

- (UIImage *) offRatingImage {
	return scaleStrategy.offImage;
}

- (void) setOnRatingImage:(UIImage *) image {
	scaleStrategy.onImage = image;
}

- (UIImage *) onRatingImage {
	return scaleStrategy.onImage;
}

- (void) setHalfRatingImage:(UIImage *) image {
	scaleStrategy.halfOnImage = image;
}

- (UIImage *) halfRatingImage {
	return scaleStrategy.halfOnImage;
}

#pragma mark -
#pragma mark Property setter overrides

- (void) setIconCount:(int) count {

	// Fast exit.
	if (count == iconCount ) {
		return;
	}
	
	// Range check.
	if (count < 3 || count > 5) {
		NSException * myException = [NSException
											  exceptionWithName:@"IconCountOutOfBoundsException"
											  reason:@"An attempt was made to set iconCount to a value <3 or >5."
											  userInfo:nil];
		@throw myException;
	}

	iconCount = count;
	[self sizeToFit];
}

- (void) setScale:(DCRATINGSCALE) aScale {
	
	//Store
	scale = aScale;
	
	// Get the new strategy.
	NSObject<DCUIRatingScaleStrategy> * newStrategy = nil;
	switch (aScale) {
		case DC_UI_RATING_SCALE_WHOLE:
			newStrategy = [[DCUIRatingScaleWholeStrategy alloc] init];
			break;
		case DC_UI_RATING_SCALE_HALF:
			newStrategy = [[DCUIRatingScaleHalfStrategy alloc] init];
			break;
		default:
			newStrategy = [[DCUIRatingScaleDoubleStrategy alloc] init];
	}
	
	// Transfer properties.
	newStrategy.offImage = scaleStrategy.offImage;
	newStrategy.onImage = scaleStrategy.onImage;
	newStrategy.halfOnImage = scaleStrategy.halfOnImage;
	[newStrategy setRating:scaleStrategy.rating];
	
	DC_DEALLOC(scaleStrategy);
	scaleStrategy = newStrategy;
}

#pragma mark -
#pragma mark Constructors

- (id) initWithFrame:(CGRect) frame {
	DC_LOG(@"InitWithFrame:");
	self = [super initWithFrame:frame];
	if (self) {
		[self setDefaults];
	}
	return self;
}

- (id) initWithCoder:(NSCoder *) decoder {
	DC_LOG(@"InitWithCoder:");
	self = [super initWithCoder:decoder];
	if (self) {
		[self setDefaults];
	}
	return self;
}

- (void) setDefaults {
	DC_LOG(@"Setting defaults");
	self.iconCount = 5;
	scaleStrategy = [[DCUIRatingScaleWholeStrategy alloc] init];
}

#pragma mark -
#pragma mark Public tasks


#pragma mark -
#pragma mark Internal messages

- (CGSize) sizeThatFits:(CGSize) size {
	DC_LOG(@"being asked for size");
	return CGSizeMake(self.offRatingImage.size.width * self.iconCount, self.offRatingImage.size.height);
}

- (void) popBubbleAtTouch:(UITouch *) atTouch {
	[self.bubble alignWithTough:atTouch];
	self.bubble.hidden = NO;
}

- (void) hideBubble {
	self.bubble.hidden = YES;
}

- (void) touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event { // From UIResponder
	DC_LOG(@"Starting touch event");
	UITouch * aTouch = [[event touchesForView:self] anyObject];
	[self calculateRatingWithTouch:aTouch];
	[self popBubbleAtTouch:aTouch];
	[super touchesBegan:touches withEvent:event];
}

- (void) touchesEnded:(NSSet *) touches withEvent:(UIEvent *) event {     // From UIResponder
	DC_LOG(@"Ending touch event");
	[self calculateRatingWithTouch:[[event touchesForView:self] anyObject]];
	[self hideBubble];
	[super touchesEnded:touches withEvent:event];
}

- (void) touchesMoved:(NSSet *) touches withEvent:(UIEvent *) event {     // From UIResponder
	DC_LOG(@"Touch moved event");
	UITouch * aTouch = [[event touchesForView:self] anyObject];
	if (lastTouchX != [aTouch locationInView:self].x) {
		[self calculateRatingWithTouch:aTouch];
		[self popBubbleAtTouch:aTouch];
	}
}

- (void) touchesCancelled:(NSSet *) touches withEvent:(UIEvent *) event { // From UIResponder
	DC_LOG(@"Touch cancelled event");
	[self calculateRatingWithTouch:[[event touchesForView:self] anyObject]];
	[self hideBubble];
	[super touchesCancelled:touches withEvent:event];
}

- (void) drawRect:(CGRect) rect {                                        // From UIView
	DC_LOG(@"Drawing rating control: %@", self);
	for (int i = 0; i < self.iconCount; i++) {
		[scaleStrategy drawImageAtIndex:i];
	}
}

- (void) calculateRatingWithTouch:(UITouch *) aTouch {
	
	DC_LOG_LAYOUT(aTouch.window);
	DC_LOG(@"Touch in window : %f x %f", [aTouch locationInView:aTouch.window].x, [aTouch locationInView:aTouch.window].y);
	DC_LOG_LAYOUT(aTouch.view);
	DC_LOG(@"Touch in control: %f x %f", [aTouch locationInView:self].x, [aTouch locationInView:self].y);
	
	// Store the current touch X and handle when it's out of the controls range.
	lastTouchX = (int) [aTouch locationInView:self].x;
	lastTouchX = fmin(self.frame.size.width - 1, lastTouchX);
	lastTouchX = fmax(0, lastTouchX);
	DC_LOG(@"New lastTouchX: %i", lastTouchX);
	
	float oldRating = [scaleStrategy rating];
	float newRating = [scaleStrategy calcNewRatingFromTouchX:lastTouchX];
	
	// Only trigger display updates if the rating has changed.
	if (oldRating != newRating) {
		[self updateBubble];
		[self setNeedsDisplay];
		
		// Notify the delegate.
		if (self.delegate != nil) {
			DC_LOG(@"Notifying delegate that rating has changed");
			[self.delegate ratingDidChange:self];
		}
	}
	
}

- (void) updateBubble {
	[self.bubble setValue:[scaleStrategy formattedRating]];
}


- (void) dealloc {
	self.offRatingImage = nil;
	self.onRatingImage = nil;
	self.halfRatingImage = nil;
	self.delegate = nil;
	DC_DEALLOC(bubble);
	DC_DEALLOC(scaleStrategy);
	[super dealloc];
}

@end
