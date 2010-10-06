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

-(int) calcZeroAreaWidth {
	return imageWidth / 3;
}

-(UIImage *) imageForIndex:(int) index {
	if (index < self.rating) {
		DC_LOG(@"Drawing full rating at %i", index * imageWidth);
		return onImage;
	} else {
		DC_LOG(@"Drawing inactive rating at %i", index * imageWidth);
		return offImage;
	}
}

-(float) calcRatingFromTouchX:(int) touchX{
	return touchX < zeroAreaWidth ? 0 : ceilf(((float)touchX + 1) / (float)imageWidth);
}

-(NSString *) formattedRating{
	return [NSString stringWithFormat:@"%i", (int)self.rating];
}

@end
