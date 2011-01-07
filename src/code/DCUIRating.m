//
//  DCUIRating.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 23/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DCUIRating.h"
#import "DCCommon.h"
#import "DCUIRatingScale5Strategy.h"
#import "DCUIRatingScale5HalfStrategy.h"
#import "DCUIRatingScale10Strategy.h"

/**
 private interface
 */
@interface DCUIRating ()
- (void) calculateRatingWithTouch:(UITouch *)aTouch;
- (void) popBubbleAtTouch:(UITouch *)atTouch;
- (void) hideBubble;
- (void) updateBubble;
@end

@implementation DCUIRating

@dynamic rating;
@synthesize offRatingImage;
@synthesize onRatingImage;
@synthesize halfRatingImage;
@synthesize scaleType;
@synthesize bubble;
@synthesize delegate;
@synthesize iconCount;

/**
 Sets the rating to be displayed. Usually used when setting up data in a display.

 @param rating the value to be set.
 */
-(void) setRating:(float)rating {
	if (scaleStrategy == nil) {
		initialRating = rating;
	} else {
		[scaleStrategy setRating:rating];
		DC_LOG(@"Triggering a refresh");
		[self setNeedsDisplay];
	}
}

/**
 Returns the current rating value.
 */
-(float) rating {
	return scaleStrategy == nil ? initialRating : [scaleStrategy rating];	
}

#pragma mark Constructors
-(id) initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.iconCount = 5;
	}
	return self;
}

-(id) initWithCoder:(NSCoder *)decoder {
	self = [super initWithCoder:decoder];
	if (self) {
		self.iconCount = 5;
	}
	return self;
}

#pragma mark -
#pragma mark Internal methods

- (CGSize)sizeThatFits:(CGSize)size {
    DC_LOG(@"being asked for size");
	 return CGSizeMake(self.offRatingImage.size.width * 5, self.offRatingImage.size.height);
}

- (void)layoutSubviews {
	if (scaleStrategy == nil) {
		if (self.scaleType == DC_UI_RATING_SCALE_WHOLE || self.scaleType == DC_SCALE_0_TO_5) {
			scaleStrategy = [[DCUIRatingScale5Strategy alloc]initWithOffImage:offRatingImage onImage:onRatingImage halfOnImage:halfRatingImage];
		} else if (self.scaleType == DC_UI_RATING_SCALE_HALF || self.scaleType == DC_SCALE_0_TO_5_WITH_HALVES) {
			scaleStrategy = [[DCUIRatingScale5HalfStrategy alloc]initWithOffImage:offRatingImage onImage:onRatingImage halfOnImage:halfRatingImage];
		} else {
			scaleStrategy = [[DCUIRatingScale10Strategy alloc]initWithOffImage:offRatingImage onImage:onRatingImage halfOnImage:halfRatingImage];
		}

		// sync the strategy with the current setting.
		[scaleStrategy setRating:initialRating];
	}
	[self sizeToFit];
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
	for (int i = 0; i < self.iconCount; i++) {
		[scaleStrategy drawImageAtIndex:i];
	}
}

- (void) calculateRatingWithTouch:(UITouch *)aTouch {

	DC_LOG_LAYOUT(aTouch.window);
	DC_LOG(@"Touch in window : %f x %f", [aTouch locationInView:aTouch.window].x, [aTouch locationInView:aTouch.window].y);
	DC_LOG_LAYOUT(aTouch.view);
	DC_LOG(@"Touch in control: %f x %f", [aTouch locationInView:self].x, [aTouch locationInView:self].y);

	// Store the current touch X and handle when it's out of the controls range.
	lastTouchX = (int)[aTouch locationInView:self].x;
	lastTouchX = fmin(self.frame.size.width - 1, lastTouchX);
	lastTouchX = fmax(0, lastTouchX);
	DC_LOG(@"New lastTouchX: %i", lastTouchX); 

	// Add the fuzz factor. This creates the area around each star's center where
	// the users touch will still select it. Dividing by the segment size gives the
	// new rating.
	float oldRating = [scaleStrategy rating];
	float newRating = [scaleStrategy calcNewRatingFromTouchX:lastTouchX];

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
