//
//  DCUIRatingScale5StrategyTests.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 10/3/10.
//  Copyright (c) 2010 Oakton Pty Ltd. All rights reserved.
//

#import <GHUnitIOS/GHUnitIOS.h>
#import <OCMock/OCMock.h>

#import "DCUIRatingScaleDoubleStrategy.h"
#import "DCCommon.h"
#import "DCUIRating.h"
#import "GHUnitTest+DCUIRatingScaleUtils.h"

@interface DCUIRatingScaleDoubleStrategyTests : GHTestCase {
	
}
@end

@implementation DCUIRatingScaleDoubleStrategyTests

-(void) testDrawImageAtIndexWithRating0 {
	int imageTypes[5] = {IMAGE_OFF,IMAGE_OFF,IMAGE_OFF,IMAGE_OFF,IMAGE_OFF};
	[self runDrawAtTestWithRating:0 scaleType:DC_SCALE_0_TO_10 imageTypes:imageTypes];
}

-(void) testDrawImageAtIndexWithRating7 {
	int imageTypes[5] = {IMAGE_ON,IMAGE_ON,IMAGE_ON,IMAGE_HALF_ON,IMAGE_OFF};
	[self runDrawAtTestWithRating:7 scaleType:DC_SCALE_0_TO_10 imageTypes:imageTypes];
}

-(void) testDrawImageAtIndexWithRating5 {
	int imageTypes[5] = {IMAGE_ON,IMAGE_ON,IMAGE_ON,IMAGE_ON,IMAGE_ON};
	[self runDrawAtTestWithRating:10 scaleType:DC_SCALE_0_TO_10 imageTypes:imageTypes];
}

-(void) testCalcNewRatingFromTouchX {
	id mockOffImage = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(20, 10);
	[[[mockOffImage stub] andReturnValue:DC_MOCK_VALUE(size)] size];
	DCUIRatingScaleDoubleStrategy * strategy = [[DCUIRatingScaleDoubleStrategy alloc]init];
	strategy.offImage = mockOffImage;
	
	int xPos[22] = {0,2,3,9,10,19,20,29,30,39,40,49,50,59,60,69,70,79,80,89,90,99};
	float result[22] = {0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10};
	for (int x = 0;x<12;x++) {
		float actualResult = [strategy calcNewRatingFromTouchX:xPos[x]];
		GHAssertEquals(actualResult, result[x], @"Incorrect calculation: x: %i expected result: %f actual %f", xPos[x], result[x], actualResult);
	}
	
}

-(void) testFormattedRating0 {
	DCUIRatingScaleDoubleStrategy * strategy = [[DCUIRatingScaleDoubleStrategy alloc]init];
	strategy.rating = 0;
	GHAssertEqualStrings([strategy formattedRating], @"0", @"Rating not formatted correctly");
}

-(void) testFormattedRating5 {
	DCUIRatingScaleDoubleStrategy * strategy = [[DCUIRatingScaleDoubleStrategy alloc]init];
	strategy.rating = 5;
	GHAssertEqualStrings([strategy formattedRating], @"5", @"Rating not formatted correctly");
}

-(void) testFormattedRating10 {
	DCUIRatingScaleDoubleStrategy * strategy = [[DCUIRatingScaleDoubleStrategy alloc]init];
	strategy.rating = 10;
	GHAssertEqualStrings([strategy formattedRating], @"10", @"Rating not formatted correctly");
}

@end
