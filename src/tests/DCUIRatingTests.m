//
//  DCUIRatingTests.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 26/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <GHUnitIOS/GHUnitIOS.h>
#import "OCMock.h"
#import "DCUIRating.h"
#import "DCCommon.h"
#import <UIKit/UIKit.h>

@interface DCUIRatingTests : GHTestCase
{
}
- (void) runRatingSetValueTestForScale:(DCRATINGSCALE)scale x:(int)x result:(float)result;

@end



@implementation DCUIRatingTests

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
	rating.onRatingImage    = mockNoRatingImage;
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
	rating.onRatingImage    = mockOnImage;
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
	rating.onRatingImage    = mockOnImage;
	rating.halfRatingImage = mockHalfImage;
	rating.scaleType = DC_SCALE_0_TO_5_WITH_HALVES;
	CGRect rect = CGRectMake(0, 0, 100, 100);
	[rating drawRect:rect];

	[mockOffImage verify];
	[mockHalfImage verify];
	[mockOnImage verify];
}

- (void) testRatingOverrunLeft {
	[self runRatingSetValueTestForScale:DC_SCALE_0_TO_5 x:-5 result:0.0];
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

- (void) runRatingSetValueTestForScale:(DCRATINGSCALE)scale x:(int)x result:(float)result {

	// Setup the rating control.
	DCUIRating *rating = [[[DCUIRating alloc] init] autorelease];
	CGFloat ratingXPos = 10;
	CGRect ratingFrame = CGRectMake(ratingXPos, 10, 50, 50);
	rating.frame = ratingFrame;
	rating.scaleType = scale;

	// Create a window and add the rating control.
	UIWindow *window = [[[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
	[window addSubview:rating];

	// mock out the touch.
	id mockTouch = [OCMockObject mockForClass:[UITouch class]];
	[[[mockTouch stub] andReturn:rating] view];
	[[[mockTouch stub] andReturn:window] window];

	// setup the touch points within the window and rating control.
	CGPoint touchPointInRating = CGPointMake(x, 26);
	[[[mockTouch stub] andReturnValue:DC_MOCK_VALUE(touchPointInRating)] locationInView:rating];
	CGPoint touchPointInWindow = CGPointMake(ratingXPos + x, 26);
	[[[mockTouch stub] andReturnValue:DC_MOCK_VALUE(touchPointInWindow)] locationInView:window];

	// setup the event.
	id mockEvent = [OCMockObject mockForClass:[UIEvent class]];
	NSMutableSet *touches = [NSMutableSet set];
	[touches addObject:mockTouch];
	[[[mockEvent expect] andReturn:touches] touchesForView:rating];

	// Mock up the images so that draw rect can be called. Use a nice mock because it's not important to the test.
	id mockImage = [OCMockObject niceMockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	[[[mockImage stub] andReturnValue:DC_MOCK_VALUE(size)] size];
	rating.offRatingImage = mockImage;
	rating.onRatingImage = mockImage;
	rating.halfRatingImage = mockImage;

	//Do a drawRect as this will always occur first and finishes the control setup.
	[rating drawRect:CGRectMake(0, 0, 50, 50)];
	
	// Trigger the calculation.
	[rating touchesEnded:touches withEvent:mockEvent];

	// Verify
	[mockEvent verify];
	[mockTouch verify];
	GHAssertEquals(rating.rating, result, @"Incorrect rating returned");

}

@end
