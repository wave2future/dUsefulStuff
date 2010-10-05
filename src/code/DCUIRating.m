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
#import "DCUIRatingScale5Strategy.h"
#import "DCUIRatingScale5HalfStrategy.h"
#import "DCUIRatingScale10Strategy.h"

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

-(void) setRating:(float)rating {
	if (scaleStrategy == nil) {
		initialRating = rating;
	} else {
		[scaleStrategy setRating:rating];
	}
}

-(float) rating {
	return scaleStrategy == nil ? initialRating : [scaleStrategy rating];	
}

- (CGSize)sizeThatFits:(CGSize)size {
    DC_LOG(@"being asked for size");
	 return CGSizeMake(self.offRatingImage.size.width * 5, self.offRatingImage.size.height);
}

- (void)layoutSubviews {
	if (scaleStrategy == nil) {
		if (scaleType == DC_SCALE_0_TO_5) {
			scaleStrategy = [[DCUIRatingScale5Strategy alloc]initWithOffImage:offRatingImage onImage:onRatingImage halfOnImage:halfRatingImage];
		} else if (scaleType == DC_SCALE_0_TO_5_WITH_HALVES) {
			scaleStrategy = [[DCUIRatingScale5HalfStrategy alloc]initWithOffImage:offRatingImage onImage:onRatingImage halfOnImage:halfRatingImage];
		} else {
			scaleStrategy = [[DCUIRatingScale10Strategy alloc]initWithOffImage:offRatingImage onImage:onRatingImage halfOnImage:halfRatingImage];
		}
		if (initialRating > 0) {
			[scaleStrategy setRating:initialRating];
		}
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
	for (int i = 0; i < 5; i++) {
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
	lastTouchX = fmin(self.frame.size.width, lastTouchX);
	lastTouchX = fmax(0, lastTouchX);

	// Add the fuzz factor. This creates the area around each star's center where
	// the users touch will still select it. Dividing by the segment size gives the
	// new rating.
	float oldRating = [scaleStrategy rating];
	float newRating = [scaleStrategy calcNewRatingFromTouchX:lastTouchX];

	if (oldRating != newRating) {
		[self updateBubble];
		[self setNeedsDisplay];
	}

}

- (void) updateBubble {
	[self.bubble setValue:[scaleStrategy formattedRating]];
}


- (void) dealloc {
	self.offRatingImage = nil;
	self.onRatingImage = nil;
	self.halfRatingImage = nil;
	DC_DEALLOC(bubble);
	DC_DEALLOC(scaleStrategy);
	[super dealloc];
}

/*
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
 @end
 
 @implementation DCUIRating
 
 @synthesize rating;
 @synthesize offRatingImage;
 @synthesize onRatingImage;
 @synthesize halfRatingImage;
 @synthesize scaleType;
 @synthesize bubble;
 
 - (CGSize)sizeThatFits:(CGSize)size {
 DC_LOG(@"being asked for size");
 return CGSizeMake(self.offRatingImage.size.width * 5, self.offRatingImage.size.height);
 }
 
 - (void)layoutSubviews {
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
 
 // Now lets resize the control.
 [self sizeToFit];
 }
 
 - (void) setupControl {
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
 
 // Adjust display rating so it's within the 0-5 range. Keep halves so we can tell when to draw them.
 float lastOnImageIndex = self.scaleType == DC_SCALE_0_TO_10 ? self.rating / 2.0 : self.rating;
 DC_LOG(@"lastOnImageIndex: %i", lastOnImageIndex);
 
 UIImage *image;
 for (int i = 0; i < 5; i++) {
 if (i < lastOnImageIndex) {
 // If scale is 0-5 with halves or 0-10 and the next whole image index is grater than the lastOnImageIndex, 
 // then we need a half image.
 if (self.scaleType != DC_SCALE_0_TO_5 && i + 1 > lastOnImageIndex) {
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

 */

@end
