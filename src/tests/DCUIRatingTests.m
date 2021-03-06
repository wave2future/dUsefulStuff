//
//  DCUIRatingTests.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 26/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <GHUnit/GHUnit.h>
#import <OCMock/OCMock.h>

#import "DCUIRating.h"
#import "DCCommon.h"
#import <UIKit/UIKit.h>

@interface DCUIRatingTests : GHTestCase {
@private 
	DCUIRating * ratingControl;
}
@end

@interface DCUIRating (testAccess)
- (IBAction)tapGesture:(UIPanGestureRecognizer *)sender;
- (IBAction)swipeGesture:(UIPanGestureRecognizer *)sender;
@end


@implementation DCUIRatingTests

-(void) setUp {
	ratingControl = [[DCUIRating alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
}

-(void) tearDown {
	DC_DEALLOC(ratingControl);
}

-(void) testInitWithCoderSetsDefaults {
	GHAssertEquals(ratingControl.iconCount, 5, @"Defaults not set.");
}

-(void) testInitWithFrameSetsDefaults {
	DCUIRating *control = [[[DCUIRating alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
	GHAssertEquals(control.iconCount, 5, @"Defaults not set.");
}

-(void) testSetScaleWithScaleWhole {
	// Create the mocks
	id mockOffImage = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	[[[mockOffImage stub] andReturnValue:OCMOCK_VALUE(size)] size];
	
	// Test
	ratingControl.offRatingImage = mockOffImage;
	
	[ratingControl setScale:DCRatingScaleWhole];
}

-(void) testSetScaleWithScaleHalf {
	// Create the mocks
	id mockOffImage = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	[[[mockOffImage stub] andReturnValue:OCMOCK_VALUE(size)] size];
	
	// Test
	ratingControl.offRatingImage = mockOffImage;
	
	[ratingControl setScale:DCRatingScaleHalf];
}

-(void) testSetScaleWithScaleDouble {
	// Create the mocks
	id mockOffImage = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	[[[mockOffImage stub] andReturnValue:OCMOCK_VALUE(size)] size];
	
	// Test
	ratingControl.offRatingImage = mockOffImage;
	
	[ratingControl setScale:DCRatingScaleDouble];
}

-(void) testSetRatingExceedsMaxAndIsReset {
	ratingControl.rating = 99;
	GHAssertEquals(ratingControl.rating, (float)5, @"Excessive rating not reduced.");
}

-(void) testSetRatingExceedsMaxAndIsResetWhenScaleDouble {
	ratingControl.scale = DCRatingScaleDouble;
	ratingControl.rating = 99;
	GHAssertEquals(ratingControl.rating, (float)10, @"Excessive rating not reduced.");
}

-(void) testSetRatingWithNegativeValueReset {
	ratingControl.rating = -99;
	GHAssertEquals(ratingControl.rating, (float)0, @"Negative rating not set to zero.");
}

-(void) testSetIconsInvalidLowNumberThrowsException {
	GHAssertThrowsSpecificNamed([ratingControl setIconCount:2], NSException, @"IconCountOutOfBoundsException", @"Incorrect exception thrown");
}

-(void) testSetIconsInvalidHighNumberThrowsException {
	GHAssertThrowsSpecificNamed([ratingControl setIconCount:6], NSException, @"IconCountOutOfBoundsException", @"Incorrect exception thrown");
}

-(void) testSizeThatFitsWith5 {
	// Create the mocks
	id mockOffImage = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	[[[mockOffImage stub] andReturnValue:OCMOCK_VALUE(size)] size];
	
	// Test
	ratingControl.offRatingImage = mockOffImage;
	
	GHAssertEquals([ratingControl sizeThatFits:CGSizeMake(100, 100)], CGSizeMake(50, 10), @"Incorrect size returned");
}

-(void) testSizeThatFitsWith4 {
	// Create the mocks
	id mockOffImage = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	[[[mockOffImage stub] andReturnValue:OCMOCK_VALUE(size)] size];
	
	// Test
	ratingControl.offRatingImage = mockOffImage;
	ratingControl.iconCount = 4;
	
	GHAssertEquals([ratingControl sizeThatFits:CGSizeMake(100, 100)], CGSizeMake(40, 10), @"Incorrect size returned");
}

-(void) testSizeThatFitsWith3 {
	// Create the mocks
	id mockOffImage = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	[[[mockOffImage stub] andReturnValue:OCMOCK_VALUE(size)] size];
	
	// Test
	ratingControl.offRatingImage = mockOffImage;
	ratingControl.iconCount = 3;
	
	GHAssertEquals([ratingControl sizeThatFits:CGSizeMake(100, 100)], CGSizeMake(30, 10), @"Incorrect size returned");
}


-(void) testDrawRect {
	// Create the mocks
	id mockOnImage = [OCMockObject mockForClass:[UIImage class]];
	id mockOffImage = [OCMockObject mockForClass:[UIImage class]];
	id mockHalfImage = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	
	[[[mockOffImage stub] andReturnValue:OCMOCK_VALUE(size)] size];
	
	DC_LOG(@"Adding image expectations");
	[[mockOnImage expect] drawAtPoint:CGPointMake(0, 0)];
	[[mockOnImage expect] drawAtPoint:CGPointMake(10, 0)];
	[[mockHalfImage expect] drawAtPoint:CGPointMake(20, 0)];
	[[mockOffImage expect] drawAtPoint:CGPointMake(30, 0)];
	[[mockOffImage expect] drawAtPoint:CGPointMake(40, 0)];
	
	// Test
	ratingControl.rating = 2.5;
	ratingControl.offRatingImage = mockOffImage;
	ratingControl.onRatingImage = mockOnImage;
	ratingControl.halfRatingImage = mockHalfImage;
	[ratingControl setScale:DCRatingScaleHalf];
	[ratingControl layoutSubviews];
	[ratingControl drawRect:CGRectMake(0, 0, 320, 480)];
	
	[mockOffImage verify];
	[mockHalfImage verify];
	[mockOnImage verify];
}

- (void) testTouchEndedCalculatesRating {
	
	// Setup the rating control.
	[ratingControl setScale:DCRatingScaleHalf];
	
	// Create a window and add the rating control.
	UIWindow *window = [[[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
	[window addSubview:ratingControl];
	
	// Mock out the tap gesture.
	id mockTapGesture = [OCMockObject mockForClass:[UITouch class]];
	CGPoint tapAt = CGPointMake(23, 26);
	[[[mockTapGesture stub] andReturnValue:OCMOCK_VALUE(tapAt)] locationInView:ratingControl];
	
	// Mock up the images so that draw rect can be called. Use a nice mock because it's not important to the test.
	id mockImage = [OCMockObject niceMockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	[[[mockImage stub] andReturnValue:OCMOCK_VALUE(size)] size];
	ratingControl.offRatingImage = mockImage;
	ratingControl.onRatingImage = mockImage;
	ratingControl.halfRatingImage = mockImage;
	ratingControl.iconCount = 5;
	
	// Trigger the calculation.
	[ratingControl tapGesture:mockTapGesture];
	
	// Verify
	[mockTapGesture verify];
	GHAssertEquals(ratingControl.rating, (float)2.5, @"Incorrect rating returned");
	
}

- (void) testDelegateIsCalledWhenValueChanges {
	
	//Setup the delegate.
	id mockDelegate = [OCMockObject mockForProtocol:@protocol(DCUIRatingDelegate)];
	[[mockDelegate expect] ratingDidChange:ratingControl];
	ratingControl.delegate = mockDelegate;
	
	// Create a window and add the rating control.
	UIWindow *window = [[[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
	[window addSubview:ratingControl];
	
	// Mock up the images so that draw rect can be called. Use a nice mock because it's not important to the test.
	id mockImage = [OCMockObject niceMockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	[[[mockImage stub] andReturnValue:OCMOCK_VALUE(size)] size];
	ratingControl.offRatingImage = mockImage;
	ratingControl.onRatingImage = mockImage;

	// Mock out the tap gesture.
	id mockTapGesture = [OCMockObject mockForClass:[UITouch class]];
	CGPoint tapAt = CGPointMake(35, 26);
	[[[mockTapGesture stub] andReturnValue:OCMOCK_VALUE(tapAt)] locationInView:ratingControl];
	
	// Trigger the calculation.
	DC_LOG(@"Make call to test code");
	[ratingControl tapGesture:mockTapGesture];
	
	// Verify
	[mockDelegate verify];
	GHAssertEquals(ratingControl.rating, (float)4, @"Incorrect rating returned");
	
}



@end
