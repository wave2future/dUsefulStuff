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

-(id) initWithOffImage:(UIImage *) aOffImage onImage:(UIImage *) aOnImage halfOnImage:(UIImage *) aHalfOnImage{
	
	self = [super init];
	if (self) {
		
		//Store the images.
		onImage = [aOnImage retain];
		offImage = [aOffImage retain];
		halfOnImage = [aHalfOnImage retain];
		
		// Setup common values.
		imageWidth = (int)offImage.size.width;
		DC_LOG(@"Image width: %i", imageWidth);
		
		// Calculate a fuzz factor around the users touch position.
		zeroAreaWidth = [self calcZeroAreaWidth];
		DC_LOG(@"Zero area width: %i", zeroAreaWidth);
		
	}
	return self;
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
	DC_DEALLOC(onImage);
	DC_DEALLOC(offImage);
	DC_DEALLOC(halfOnImage);
	[super dealloc];
}


@end
