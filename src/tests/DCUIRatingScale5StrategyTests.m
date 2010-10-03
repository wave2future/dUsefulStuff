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

@interface DCUIRatingScale5StrategyTests : GHTestCase {
	
}
-(void) runDrawAtTestWithRating:(int) rating imageTypes:(int[5]) imageTypes;
@end

@implementation DCUIRatingScale5StrategyTests

-(void) testDrawImageAtIndexWithRating0 {
	int imageTypes[5] = {-1,-1,-1,-1,-1};
	[self runDrawAtTestWithRating:0 imageTypes:imageTypes];
}

-(void) testDrawImageAtIndexWithRating3 {
	int imageTypes[5] = {1,1,1,-1,-1};
	[self runDrawAtTestWithRating:3 imageTypes:imageTypes];
}

-(void) testDrawImageAtIndexWithRating5 {
	int imageTypes[5] = {1,1,1,1,1};
	[self runDrawAtTestWithRating:5 imageTypes:imageTypes];
}

-(void) runDrawAtTestWithRating:(int) rating imageTypes:(int[5]) imageTypes {
	id mockOnImage = [OCMockObject mockForClass:[UIImage class]];
	id mockOffImage = [OCMockObject mockForClass:[UIImage class]];
	
	CGSize size = CGSizeMake(10, 10);
	
	[[[mockOffImage stub] andReturnValue:DC_MOCK_VALUE(size)] size];
	
	for (int i = 0, offset = 0;i < 5;i++, offset+=10) {
		if (imageTypes[i] == 1) {
			[[mockOnImage expect] drawAtPoint:CGPointMake(offset, 0)]; 
		}else {
			[[mockOffImage expect] drawAtPoint:CGPointMake(offset, 0)]; 
		}
	}
	
	DCUIRatingScale5Strategy * strategy = [[DCUIRatingScale5Strategy alloc]initWithOffImage:mockOffImage onImage:mockOnImage halfOnImage:nil];
	[strategy setRating:rating];
	
	for (int i = 0;i < 5;i++) {
		[strategy drawImageAtIndex:i];
	}
	
	[mockOffImage verify];
	[mockOnImage verify];
	
}

-(void) testCalcNewRatingFromTouchX0 {
	id mockOffImage = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(20, 10);
	[[[mockOffImage stub] andReturnValue:DC_MOCK_VALUE(size)] size];
	DCUIRatingScale5Strategy * strategy = [[DCUIRatingScale5Strategy alloc]initWithOffImage:mockOffImage onImage:nil halfOnImage:nil];
	
	int xPos[12] = {1,3,4,23,24,43,44,63,64,83,84,100};
	float result[12] = {0,0,1,1,2,2,3,3,4,4,5,5};
	for (int x = 0;x<12;x++) {
		float actualResult = [strategy calcNewRatingFromTouchX:xPos[x]];
		GHAssertEquals(actualResult, result[x], @"Incorrect calculation: x: %i expected result: %f actual %f", xPos[x], result[x], actualResult);
	}
	
}

@end
