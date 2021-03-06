//
//  GHUnitTest+DCUIRatingScaleUtils.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 10/5/10.
//  Copyright (c) 2010 Oakton Pty Ltd. All rights reserved.
//

#import <OCMock/OCMock.h>

#import "GHUnitTest+DCUIRatingFixtures.h"
#import "DCUIRatingScaleStrategy.h"
#import "DCUIRatingScaleWholeStrategy.h"
#import "DCUIRatingScaleHalfStrategy.h"
#import "DCUIRatingScaleDoubleStrategy.h"
#import "DCCommon.h"


@implementation GHTestCase (GHUnitTest_DCUIRatingFixtures)

-(void) verifyImagesDrawAtCorrectPostionWithRating:(float) rating scaleType:(DCRatingScale) scale imageTypes:(int[]) imageTypes iconCount:(int) iconCount {
	
	// Mocks of images.
	id mockOnImage = [OCMockObject mockForClass:[UIImage class]];
	id mockOffImage = [OCMockObject mockForClass:[UIImage class]];
	id mockHalfOnImage = [OCMockObject mockForClass:[UIImage class]];
	
	// Expectations.
	CGSize size = CGSizeMake(10, 10);
	[[[mockOffImage stub] andReturnValue:OCMOCK_VALUE(size)] size];
	
	// Set expectations.
	for (int i = 0, offset = 0;i < iconCount;i++, offset+=10) {
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
	if (scale == DCRatingScaleWhole) {
		strategy = [[DCUIRatingScaleWholeStrategy alloc]init];
	} else if (scale == DCRatingScaleHalf) {
		strategy = [[DCUIRatingScaleHalfStrategy alloc]init];
	} else {
		strategy = [[DCUIRatingScaleDoubleStrategy alloc]init];
	}
	strategy.offImage = mockOffImage;
	strategy.onImage = mockOnImage;
	strategy.halfOnImage = mockHalfOnImage;

	DC_LOG(@"Setting rating %f", rating);
	[strategy setRating:rating];

	for (int i = 0;i < iconCount;i++) {
		[strategy drawImageAtIndex:i];
	}
	
	[mockOffImage verify];
	[mockOnImage verify];
	[mockHalfOnImage verify];
}

@end
