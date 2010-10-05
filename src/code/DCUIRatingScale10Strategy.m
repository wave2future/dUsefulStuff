//
//  DCUIRatingScale10Strategy.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 10/4/10.
//  Copyright (c) 2010 Oakton Pty Ltd. All rights reserved.
//

#import "DCUIRatingScale10Strategy.h"
#import "DCCommon.h"


@implementation DCUIRatingScale10Strategy

-(int) calcZeroAreaWidth {
	return imageWidth / 6;
}

-(float) calcRatingFromTouchX:(int) touchX{
	return touchX < zeroAreaWidth ? 0 : floor(touchX / (imageWidth / 2));
}

-(UIImage *) imageForIndex:(int) index {
	float onImages = self.rating / 2;
	if (index < onImages) {
		if (index + 1 > onImages) {
			DC_LOG(@"Drawing half rating at %i", index * imageWidth);
			return halfOnImage;
		} 
		DC_LOG(@"Drawing full rating at %i", index * imageWidth);
		return onImage;
	} 
	DC_LOG(@"Drawing inactive rating at %i", index * imageWidth);
	return offImage;
}

@end
