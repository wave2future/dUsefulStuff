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
-(void) runDrawRectTestWithScale:(DCRATINGSCALE) scale rating:(float) rating imageTypes:(int[5]) imageTypes;
@end



@implementation DCUIRatingTests

- (void) testDrawRectWithScale5AndRating0 {
	int expectedImages[5] = {-1,-1,-1,-1,-1};
	[self runDrawRectTestWithScale:DC_SCALE_0_TO_5 rating:0 imageTypes:expectedImages];
}

- (void) testDrawRectWithScale5AndRating3 {
	int expectedImages[5] = {1,1,1,-1,-1};
	[self runDrawRectTestWithScale:DC_SCALE_0_TO_5 rating:3 imageTypes:expectedImages];
}

- (void) testDrawRectWithScale5AndRating5 {
	int expectedImages[5] = {1,1,1,1,1};
	[self runDrawRectTestWithScale:DC_SCALE_0_TO_5 rating:5 imageTypes:expectedImages];
}

- (void) testDrawRectWithScale5AndHalfAndRating2AndHalf {
	int expectedImages[5] = {1,1,0,-1,-1};
	[self runDrawRectTestWithScale:DC_SCALE_0_TO_5_WITH_HALVES rating:2.5 imageTypes:expectedImages];
}

- (void) testDrawRectWithScale5AndHalfAndRating3 {
	int expectedImages[5] = {1,1,1,-1,-1};
	[self runDrawRectTestWithScale:DC_SCALE_0_TO_5_WITH_HALVES rating:3 imageTypes:expectedImages];
}

- (void) testDrawRectWithScale10AndRating5 {
	int expectedImages[5] = {1,1,0,-1,-1};
	[self runDrawRectTestWithScale:DC_SCALE_0_TO_10 rating:5 imageTypes:expectedImages];
}

- (void) testDrawRectWithScale10AndRating6 {
	int expectedImages[5] = {1,1,1,-1,-1};
	[self runDrawRectTestWithScale:DC_SCALE_0_TO_10 rating:6 imageTypes:expectedImages];
}

-(void) runDrawRectTestWithScale:(DCRATINGSCALE) scale rating:(float) rating imageTypes:(int[5]) imageTypes {
	// Create the mocks
	id mockOnImage = [OCMockObject mockForClass:[UIImage class]];
	id mockOffImage = [OCMockObject mockForClass:[UIImage class]];
	id mockHalfImage = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	
	[[[mockOffImage stub] andReturnValue:DC_MOCK_VALUE(size)] size];

	DC_LOG(@"Adding image expectations");
	for (int i = 0, offset = 0;i < 5; i++, offset += 10) {
		if (imageTypes[i] == 1) {
			DC_LOG(@"Adding expectation for on image at %i", offset);
			[[mockOnImage expect] drawAtPoint:CGPointMake(offset, 0)];
		} else if(imageTypes[i] == 0) {
			DC_LOG(@"Adding expectation for half image at %i", offset);
			[[mockHalfImage expect] drawAtPoint:CGPointMake(offset, 0)];
		} else {
			DC_LOG(@"Adding expectation for off image at %i", offset);
			[[mockOffImage expect] drawAtPoint:CGPointMake(offset, 0)];
		}
	}
	
	// Test
	DCUIRating *ratingControl = [[[DCUIRating alloc] init] autorelease];
	ratingControl.rating = rating;
	ratingControl.offRatingImage = mockOffImage;
	ratingControl.onRatingImage = mockOnImage;
	ratingControl.halfRatingImage = mockHalfImage;
	ratingControl.scaleType = scale;
	CGRect rect = CGRectMake(0, 0, 100, 100);
	[ratingControl layoutSubviews];
	[ratingControl drawRect:rect];
	
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
	[rating layoutSubviews];

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
