//
//  DCUIRatingScale5HalfStrategy.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 10/4/10.
//  Copyright (c) 2010 Oakton Pty Ltd. All rights reserved.
//

#import "DCUIRatingScaleHalfStrategy.h"
#import "DCCommon.h"

@implementation DCUIRatingScaleHalfStrategy

-(int) calcZeroAreaWidth {
	return imageWidth / 6;
}

-(UIImage *) imageForIndex:(int) index {
	if (index < self.rating) {
		if (index + 1 > self.rating) {
			DC_LOG(@"Drawing half rating at %i", index * imageWidth);
			return self.halfOnImage;
		} 
		DC_LOG(@"Drawing full rating at %i", index * imageWidth);
		return self.onImage;
	} 
	DC_LOG(@"Drawing inactive rating at %i", index * imageWidth);
	return self.offImage;
}

-(float) calcRatingFromTouchX:(int) touchX{
	return touchX < zeroAreaWidth ? 0 : ceilf(((float)touchX + 1) / (float)imageWidth * 2) /2;
}

-(NSString *) formattedRating{
	if (decimalFormatter == nil) {
		DC_LOG(@"Creating formatter");
		decimalFormatter = [[NSNumberFormatter alloc] init];
		[decimalFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[decimalFormatter setMinimumFractionDigits:1];
		[decimalFormatter setMaximumFractionDigits:1];
	}
	
	return [decimalFormatter stringFromNumber:[NSNumber numberWithFloat:self.rating]];
}

- (void)dealloc {
	DC_DEALLOC(decimalFormatter);
	[super dealloc];
}

@end
