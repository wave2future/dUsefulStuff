//
//  DCUIRatingScale5StrategyTests.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 10/3/10.
//  Copyright (c) 2010 Oakton Pty Ltd. All rights reserved.
//

#import <GHUnit/GHUnit.h>
#import <OCMock/OCMock.h>

#import "DCUIRatingScaleHalfStrategy.h"
#import "DCCommon.h"
#import "DCUIRating.h"
#import "GHUnitTest+DCUIRatingFixtures.h"

@interface DCUIRatingScaleHalfStrategyTests : GHTestCase {
	
}
@end

@implementation DCUIRatingScaleHalfStrategyTests

-(void) testDrawImageAtIndexWithRating0 {
	int imageTypes[5] = {IMAGE_OFF, IMAGE_OFF, IMAGE_OFF, IMAGE_OFF, IMAGE_OFF};
	[self verifyImagesDrawAtCorrectPostionWithRating:0 scaleType:DCRatingScaleHalf imageTypes:imageTypes iconCount:5];
}

-(void) testDrawImageAtIndexWithRating3Half {
	int imageTypes[5] = {IMAGE_ON, IMAGE_ON, IMAGE_ON, IMAGE_HALF_ON, IMAGE_OFF};
	[self verifyImagesDrawAtCorrectPostionWithRating:3.5 scaleType:DCRatingScaleHalf imageTypes:imageTypes iconCount:5];
}

-(void) testDrawImageAtIndexWithRating5 {
	int imageTypes[5] = {IMAGE_ON, IMAGE_ON, IMAGE_ON, IMAGE_ON, IMAGE_ON};
	[self verifyImagesDrawAtCorrectPostionWithRating:5 scaleType:DCRatingScaleHalf imageTypes:imageTypes iconCount:5];
}

-(void) testCalcNewRatingFromTouchX {
	id mockOffImage = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(20, 10);
	[[[mockOffImage stub] andReturnValue:OCMOCK_VALUE(size)] size];
	DCUIRatingScaleHalfStrategy * strategy = [[DCUIRatingScaleHalfStrategy alloc]init];
	strategy.offImage = mockOffImage;
	
	int xPos[22] = {0,2,3,9,10,19,20,29,30,39,40,49,50,59,60,69,70,79,80,89,90,99};
	float result[22] = {0,0,0.5,0.5,1,1,1.5,1.5,2,2,2.5,2.5,3,3,3.5,3.5,4,4,4.5,4.5,5,5};
	for (int x = 0;x<12;x++) {
		float actualResult = [strategy calcNewRatingFromTouchX:xPos[x]];
		DC_LOG(@"pos %i = %f", xPos[x], actualResult);
		GHAssertEquals(actualResult, result[x], @"Incorrect calculation: x: %i expected result: %f actual %f", xPos[x], result[x], actualResult);
	}
	
}

-(void) testFormattedRating0 {
	DCUIRatingScaleHalfStrategy * strategy = [[DCUIRatingScaleHalfStrategy alloc]init];
	strategy.rating = 0;
	GHAssertEqualStrings([strategy formattedRating], @"0.0", @"Rating not formatted correctly");
}

-(void) testFormattedRating2Half {
	DCUIRatingScaleHalfStrategy * strategy = [[DCUIRatingScaleHalfStrategy alloc]init];
	strategy.rating = 2.5;
	GHAssertEqualStrings([strategy formattedRating], @"2.5", @"Rating not formatted correctly");
}

-(void) testFormattedRating5 {
	DCUIRatingScaleHalfStrategy * strategy = [[DCUIRatingScaleHalfStrategy alloc]init];
	strategy.rating = 5;
	GHAssertEqualStrings([strategy formattedRating], @"5.0", @"Rating not formatted correctly");
}

@end
