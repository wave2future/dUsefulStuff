//
//  DCUIRatingScale5Strategy.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 10/3/10.
//  Copyright (c) 2010 Oakton Pty Ltd. All rights reserved.
//

#import "DCUIRatingScale5Strategy.h"
#import "DCCommon.h"


@implementation DCUIRatingScale5Strategy

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
		fuzzFactor = imageWidth * 0.8;
		DC_LOG(@"Fuzz factor: %f", fuzzFactor);

	}
	return self;
}

-(void) drawImageAtIndex:(int) index{
	UIImage * image;
	if (index < rating) {
		DC_LOG(@"Drawing full rating at %i", index * imageWidth);
		image = onImage;
	} else {
		DC_LOG(@"Drawing inactive rating at %i", index * imageWidth);
		image = offImage;
	}
	[image drawAtPoint:CGPointMake(index * imageWidth, 0)];
}

-(float) calcNewRatingFromTouchX:(int) touchX{
	rating = floor((touchX + fuzzFactor) / imageWidth);
	return rating;
}

-(void) setRating:(float) aRating{
	rating = aRating;
}

-(float) rating{
	return rating;
}

-(NSString *) formattedRating{
	return [NSString stringWithFormat:@"%i", (int)self.rating];
}

- (void)dealloc {
	DC_DEALLOC(onImage);
	DC_DEALLOC(offImage);
	DC_DEALLOC(halfOnImage);
	[super dealloc];
}


@end
