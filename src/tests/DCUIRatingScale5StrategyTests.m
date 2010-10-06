//
//  DCUIRatingScale5StrategyTests.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 10/3/10.
//  Copyright (c) 2010 Oakton Pty Ltd. All rights reserved.
//

#import <GHUnitIOS/GHUnitIOS.h>
#import "DCUIRatingScale5Strategy.h"
#import "OCMock.h"
#import "DCCommon.h"
#import "DCUIRating.h"
#import "GHUnitTest+DCUIRatingScaleUtils.h"

@interface DCUIRatingScale5StrategyTests : GHTestCase {
	
}
@end

@implementation DCUIRatingScale5StrategyTests

-(void) testDrawImageAtIndexWithRating0 {
	int imageTypes[5] = {IMAGE_OFF, IMAGE_OFF, IMAGE_OFF, IMAGE_OFF, IMAGE_OFF};
	[self runDrawAtTestWithRating:0 scaleType:DC_SCALE_0_TO_5 imageTypes:imageTypes];
}

-(void) testDrawImageAtIndexWithRating3 {
	int imageTypes[5] = {IMAGE_ON, IMAGE_ON, IMAGE_ON, IMAGE_OFF, IMAGE_OFF};
	[self runDrawAtTestWithRating:3 scaleType:DC_SCALE_0_TO_5 imageTypes:imageTypes];
}

-(void) testDrawImageAtIndexWithRating5 {
	int imageTypes[5] = {IMAGE_ON, IMAGE_ON, IMAGE_ON, IMAGE_ON, IMAGE_ON};
	[self runDrawAtTestWithRating:5 scaleType:DC_SCALE_0_TO_5 imageTypes:imageTypes];
}

-(void) testCalcNewRatingFromTouchX {
	id mockOffImage = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(20, 10);
	[[[mockOffImage stub] andReturnValue:DC_MOCK_VALUE(size)] size];
	DCUIRatingScale5Strategy * strategy = [[DCUIRatingScale5Strategy alloc]initWithOffImage:mockOffImage onImage:nil halfOnImage:nil];
	
	int xPos[12] = {0,5,6,19,20,39,40,59,60,79,80,99};
	float result[12] = {0,0,1,1,2,2,3,3,4,4,5,5};
	for (int x = 0;x<12;x++) {
		float actualResult = [strategy calcNewRatingFromTouchX:xPos[x]];
		GHAssertEquals(actualResult, result[x], @"Incorrect calculation: x: %i expected result: %f actual %f", xPos[x], result[x], actualResult);
	}
	
}

-(void) testFormattedRating0 {
	DCUIRatingScale5Strategy * strategy = [[DCUIRatingScale5Strategy alloc]initWithOffImage:nil onImage:nil halfOnImage:nil];
	strategy.rating = 0;
	GHAssertEqualStrings([strategy formattedRating], @"0", @"Rating not formatted correctly");
}

@end
