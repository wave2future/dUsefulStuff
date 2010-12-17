//
//  GHUnitTest+DCUIRatingScaleUtils.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 10/5/10.
//  Copyright (c) 2010 Oakton Pty Ltd. All rights reserved.
//

#import <OCMock/OCMock.h>

#import "GHUnitTest+DCUIRatingScaleUtils.h"
#import "DCUIRatingScaleStrategy.h"
#import "DCUIRatingScale5Strategy.h"
#import "DCUIRatingScale5HalfStrategy.h"
#import "DCUIRatingScale10Strategy.h"
#import "DCCommon.h"


@implementation GHTestCase (GHUnitTest_DCUIRatingScaleUtils)

-(void) runDrawAtTestWithRating:(float) rating scaleType:(DCRATINGSCALE) scale imageTypes:(int[5]) imageTypes {
	
	// Mocks of images.
	id mockOnImage = [OCMockObject mockForClass:[UIImage class]];
	id mockOffImage = [OCMockObject mockForClass:[UIImage class]];
	id mockHalfOnImage = [OCMockObject mockForClass:[UIImage class]];
	
	// Expectations.
	CGSize size = CGSizeMake(10, 10);
	[[[mockOffImage stub] andReturnValue:DC_MOCK_VALUE(size)] size];
	
	// Set expectations.
	for (int i = 0, offset = 0;i < 5;i++, offset+=10) {
		if (imageTypes[i] == IMAGE_ON) {
			DC_LOG(@"Adding expectation On image at %i", offset);
			[[mockOnImage expect] drawAtPoint:CGPointMake(offset, 0)]; 
		} else if (imageTypes[i] == IMAGE_HALF_ON) {
			DC_LOG(@"Adding expectation Half On image at %i", offset);
			[[mockHalfOnImage expect] drawAtPoint:CGPointMake(offset, 0)]; 
		}else {
			DC_LOG(@"Adding expectation Off image at %i", offset);
			[[mockOffImage expect] drawAtPoint:CGPointMake(offset, 0)]; 
		}
	}
	
	NSObject<DCUIRatingScaleStrategy> * strategy;
	if (scale == DC_SCALE_0_TO_5) {
		strategy = [[DCUIRatingScale5Strategy alloc]initWithOffImage:mockOffImage onImage:mockOnImage halfOnImage:mockHalfOnImage];
	} else if (scale == DC_SCALE_0_TO_5_WITH_HALVES) {
		strategy = [[DCUIRatingScale5HalfStrategy alloc]initWithOffImage:mockOffImage onImage:mockOnImage halfOnImage:mockHalfOnImage];
	} else {
		strategy = [[DCUIRatingScale10Strategy alloc]initWithOffImage:mockOffImage onImage:mockOnImage halfOnImage:mockHalfOnImage];
	}
	
	[strategy setRating:rating];
	
	for (int i = 0;i < 5;i++) {
		[strategy drawImageAtIndex:i];
	}
	
	[mockOffImage verify];
	[mockOnImage verify];
	[mockHalfOnImage verify];
}

@end
