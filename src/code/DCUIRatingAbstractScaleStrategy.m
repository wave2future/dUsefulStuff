//
//  DCUIRatingScale5Strategy.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 10/3/10.
//  Copyright (c) 2010 Oakton Pty Ltd. All rights reserved.
//

#import "DCUIRatingAbstractScaleStrategy.h"
#import "DCCommon.h"

@implementation DCUIRatingAbstractScaleStrategy

@synthesize rating;
@synthesize onImage;
@synthesize halfOnImage;
@dynamic offImage;

-(void) setOffImage:(UIImage *) image {
	[offImage release];
	offImage = [image retain];

	// Setup common values.
	if (offImage != nil) {
		imageWidth = (int)offImage.size.width;
		DC_LOG(@"Image width: %i", imageWidth);
	
		// Calculate a fuzz factor around the users touch position.
		zeroAreaWidth = [self calcZeroAreaWidth];
		DC_LOG(@"Zero area width: %i", zeroAreaWidth);
	}
}

-(UIImage*) offImage {
	return offImage;
}

-(void) drawImageAtIndex:(int) index{
	[[self imageForIndex:index] drawAtPoint:CGPointMake(index * imageWidth, 0)];
}

-(float) calcNewRatingFromTouchX:(int) touchX{
	self.rating = [self calcRatingFromTouchX:touchX];
	return self.rating;
}

-(int) calcZeroAreaWidth {
	// implement this.
	return 0;
}

-(UIImage *) imageForIndex:(int) index {
	//implement this.
	return nil;
}

-(float) calcRatingFromTouchX:(int) touchX {
	// implement this.
	return 0;
}

-(NSString *) formattedRating{
	//Implement this.
	return nil;
}

- (void)dealloc {
	// Use DC_DEALLOC to avoid setter.
	self.offImage = nil;
	self.onImage = nil;
	self.halfOnImage = nil;
	[super dealloc];
}


@end
