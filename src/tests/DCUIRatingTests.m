//
//  DCUIRatingTests.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 26/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import "GHUnit.h"
#import "OCMock.h"
#import "DCUIRating.h"
#import "DCCommon.h"
#import <UIKit/UIKit.h>

@interface DCUIRatingTests : GHTestCase
{
}
- (void) runRatingSetValueTestForScale:(DCRATINGSCALE)scale x:(int)x result:(double)result;

@end



@implementation DCUIRatingTests

- (void) testSetupControl {
	// Mocks
	id mockNoRatingImage = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	[[[mockNoRatingImage stub] andReturnValue:DC_MOCK_VALUE(size)] size];

	// Test
	DCUIRating *rating = [[[DCUIRating alloc] init] autorelease];
	rating.offRatingImage = mockNoRatingImage;
	rating.onRatingImage = mockNoRatingImage;
	rating.padding = 2;
	[rating setupControl];

	// finish up
	GHAssertEquals((double)rating.frame.size.width, 58.0, @"Incorrect width calculated");
	GHAssertEquals((double)rating.frame.size.height, 10.0, @"Incorrect height calculated");
	[mockNoRatingImage verify];
}

- (void) testDrawRectThrowsIfSetupNotDone {

	// Test
	DCUIRating *rating = [[[DCUIRating alloc] init] autorelease];
	CGRect rect = CGRectMake(0, 0, 100, 100);
	GHAssertThrowsSpecificNamed([rating drawRect:rect], NSException, @"NotSetupException", @"The setUpControl: method must be called before drawing first occurs");

}

- (void) testDrawRect {

	// Mocks
	id mockNoRatingImage = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	[[[mockNoRatingImage stub] andReturnValue:DC_MOCK_VALUE(size)] size];
	[[mockNoRatingImage expect] drawAtPoint:CGPointMake(0, 0)];
	[[mockNoRatingImage expect] drawAtPoint:CGPointMake(10, 0)];
	[[mockNoRatingImage expect] drawAtPoint:CGPointMake(20, 0)];
	[[mockNoRatingImage expect] drawAtPoint:CGPointMake(30, 0)];
	[[mockNoRatingImage expect] drawAtPoint:CGPointMake(40, 0)];

	// Test
	DCUIRating *rating = [[[DCUIRating alloc] init] autorelease];
	CGRect rect = CGRectMake(0, 0, 100, 100);
	rating.offRatingImage = mockNoRatingImage;
	rating.onRatingImage	= mockNoRatingImage;
	[rating setupControl];
	[rating drawRect:rect];

	// finish up
	[mockNoRatingImage verify];

}

- (void) testDrawRectWithPadding {

	// Mocks
	id mockNoRatingImage = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	[[[mockNoRatingImage stub] andReturnValue:DC_MOCK_VALUE(size)] size];
	[[mockNoRatingImage expect] drawAtPoint:CGPointMake(0, 0)];
	[[mockNoRatingImage expect] drawAtPoint:CGPointMake(12, 0)];
	[[mockNoRatingImage expect] drawAtPoint:CGPointMake(24, 0)];
	[[mockNoRatingImage expect] drawAtPoint:CGPointMake(36, 0)];
	[[mockNoRatingImage expect] drawAtPoint:CGPointMake(48, 0)];

	// Test
	DCUIRating *rating = [[[DCUIRating alloc] init] autorelease];
	CGRect rect = CGRectMake(0, 0, 100, 100);
	rating.offRatingImage = mockNoRatingImage;
	rating.onRatingImage	= mockNoRatingImage;
	rating.padding = 2;
	[rating setupControl];
	[rating drawRect:rect];

	// finish up
	[mockNoRatingImage verify];
}

- (void) testDrawRectWithScale5AndRating3 {

	// Mocks
	id mockOnImage = [OCMockObject mockForClass:[UIImage class]];
	id mockOffImage = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	[[[mockOffImage stub] andReturnValue:DC_MOCK_VALUE(size)] size];
	[[mockOnImage expect] drawAtPoint:CGPointMake(0, 0)];
	[[mockOnImage expect] drawAtPoint:CGPointMake(10, 0)];
	[[mockOnImage expect] drawAtPoint:CGPointMake(20, 0)];
	[[mockOffImage expect] drawAtPoint:CGPointMake(30, 0)];
	[[mockOffImage expect] drawAtPoint:CGPointMake(40, 0)];

	// Test
	DCUIRating *rating = [[[DCUIRating alloc] init] autorelease];
	rating.rating = 3;
	CGRect rect = CGRectMake(0, 0, 100, 100);
	rating.offRatingImage = mockOffImage;
	rating.onRatingImage	= mockOnImage;
	[rating setupControl];
	[rating drawRect:rect];

	// finish up
	[mockOffImage verify];
	[mockOnImage verify];
}

- (void) testDrawRectWithScale5AndHalfAndRating2AndHalf {


	// Create the mocks
	id mockOnImage = [OCMockObject mockForClass:[UIImage class]];
	id mockOffImage = [OCMockObject mockForClass:[UIImage class]];
	id mockHalfImage = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);

	[[[mockOffImage stub] andReturnValue:DC_MOCK_VALUE(size)] size];

	[[mockOnImage expect] drawAtPoint:CGPointMake(0, 0)];
	[[mockOnImage expect] drawAtPoint:CGPointMake(10, 0)];
	[[mockHalfImage expect] drawAtPoint:CGPointMake(20, 0)];
	[[mockOffImage expect] drawAtPoint:CGPointMake(30, 0)];
	[[mockOffImage expect] drawAtPoint:CGPointMake(40, 0)];

	// Test
	DCUIRating *rating = [[[DCUIRating alloc] init] autorelease];
	rating.rating = 2.5;
	rating.offRatingImage = mockOffImage;
	rating.onRatingImage	= mockOnImage;
	rating.halfRatingImage = mockHalfImage;
	rating.scaleType = DC_SCALE_0_TO_5_WITH_HALVES;
	[rating setupControl];
	CGRect rect = CGRectMake(0, 0, 100, 100);
	[rating drawRect:rect];

	[mockOffImage verify];
	[mockHalfImage verify];
	[mockOnImage verify];
}

- (void) testRatingOverrunLeft {
	[self runRatingSetValueTestForScale:DC_SCALE_0_TO_5 x:-50 result:0.0];
}

- (void) testRatingOverrunRightScale5 {
	[self runRatingSetValueTestForScale:DC_SCALE_0_TO_5 x:150 result:5.0];
}

- (void) testRatingOverrunRightScale10 {
	[self runRatingSetValueTestForScale:DC_SCALE_0_TO_10 x:150 result:10.0];
}

- (void) testScale5HalfWayTouch {
	[self runRatingSetValueTestForScale:DC_SCALE_0_TO_5 x:25 result:3.0];
}

- (void) testScale5WithHalvesHalfWayTouch {
	[self runRatingSetValueTestForScale:DC_SCALE_0_TO_5_WITH_HALVES x:25 result:2.5];
}

- (void) testScale10HalfWayTouch {
	[self runRatingSetValueTestForScale:DC_SCALE_0_TO_10 x:25 result:5.0];
}

- (void) runRatingSetValueTestForScale:(DCRATINGSCALE)scale x:(int)x result:(double)result {

	// Mocks - setup a mocked out touch event.
	id mockEvent = [OCMockObject mockForClass:[UIEvent class]];
	NSMutableSet *touches = [NSMutableSet set];
	id mockTouch = [OCMockObject mockForClass:[UITouch class]];
	[touches addObject:mockTouch];

	id mockOffImage = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	[[[mockOffImage stub] andReturnValue:DC_MOCK_VALUE(size)] size];
	// Expectations

	DCUIRating *rating = [[[DCUIRating alloc] init] autorelease];

	[[[mockEvent expect] andReturn:touches] touchesForView:rating];
	CGPoint location = CGPointMake(x, 50);
	[[[mockTouch expect] andReturnValue:DC_MOCK_VALUE(location)] locationInView:rating];

	// Test
	rating.offRatingImage = mockOffImage;
	rating.onRatingImage	= mockOffImage;
	rating.halfRatingImage = mockOffImage;
	rating.scaleType = scale;
	[rating setupControl];
	[rating touchesEnded:touches withEvent:mockEvent];

	[mockEvent verify];
	[mockTouch verify];
	[mockOffImage verify];
	GHAssertEquals(rating.rating, result, @"Incorrect rating returned");

}


@end
