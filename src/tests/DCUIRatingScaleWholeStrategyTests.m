//
//  DCUIRatingScale5StrategyTests.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 10/3/10.
//  Copyright (c) 2010 Oakton Pty Ltd. All rights reserved.
//

#import <GHUnit/GHUnit.h>
#import <OCMock/OCMock.h>

#import "DCUIRatingScaleWholeStrategy.h"
#import "DCCommon.h"
#import "DCUIRating.h"
#import "GHUnitTest+DCUIRatingFixtures.h"

@interface DCUIRatingScaleWholeStrategyTests : GHTestCase {
	
}
@end

@implementation DCUIRatingScaleWholeStrategyTests

-(void) testDrawImageAtIndexWithRating0 {
	int imageTypes[5] = {IMAGE_OFF, IMAGE_OFF, IMAGE_OFF, IMAGE_OFF, IMAGE_OFF};
	[self verifyImagesDrawAtCorrectPostionWithRating:0 scaleType:DC_UI_RATING_SCALE_WHOLE imageTypes:imageTypes iconCount:5];
}

-(void) testDrawImageAtIndexWithRating3 {
	int imageTypes[5] = {IMAGE_ON, IMAGE_ON, IMAGE_ON, IMAGE_OFF, IMAGE_OFF};
	[self verifyImagesDrawAtCorrectPostionWithRating:3 scaleType:DC_UI_RATING_SCALE_WHOLE imageTypes:imageTypes iconCount:5];
}

-(void) testDrawImageAtIndexWithRating5 {
	int imageTypes[5] = {IMAGE_ON, IMAGE_ON, IMAGE_ON, IMAGE_ON, IMAGE_ON};
	[self verifyImagesDrawAtCorrectPostionWithRating:5 scaleType:DC_UI_RATING_SCALE_WHOLE imageTypes:imageTypes iconCount:5];
}

-(void) testCalcNewRatingFromTouchX {
	id mockOffImage = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(20, 10);
	[[[mockOffImage stub] andReturnValue:DC_MOCK_VALUE(size)] size];
	DCUIRatingScaleWholeStrategy * strategy = [[DCUIRatingScaleWholeStrategy alloc]init];
	strategy.offImage = mockOffImage;
	
	int xPos[12] = {0,5,6,19,20,39,40,59,60,79,80,99};
	float result[12] = {0,0,1,1,2,2,3,3,4,4,5,5};
	for (int x = 0;x<12;x++) {
		float actualResult = [strategy calcNewRatingFromTouchX:xPos[x]];
		GHAssertEquals(actualResult, result[x], @"Incorrect calculation: x: %i expected result: %f actual %f", xPos[x], result[x], actualResult);
	}
	
}

-(void) testFormattedRating0 {
	DCUIRatingScaleWholeStrategy * strategy = [[DCUIRatingScaleWholeStrategy alloc]init];
	strategy.rating = 0;
	GHAssertEqualStrings([strategy formattedRating], @"0", @"Rating not formatted correctly");
}

@end
