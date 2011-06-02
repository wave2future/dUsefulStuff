//
//  BubbleViewTests.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 21/04/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//
#import <GHUnit/GHUnit.h>
#import <OCMock/OCMock.h>

#import "DCUIBubble.h"
#import "DCCommon.h"
#import "UIColor+dUsefulStuff.h"

@interface DCUIBubbleTests : GHTestCase
{
}
- (void) verifyMoveToX:(int)x putsFrameAtX:(int)frameAt;

@end

@implementation DCUIBubbleTests


- (void) testInitWithSizeSetsSize {
	DCUIBubble *bubble = [[[DCUIBubble alloc] initWithSize:CGSizeMake(10, 20)] autorelease];
	GHAssertEquals(bubble.frame.size.width, (CGFloat)10, @"Width not set correctly");
	GHAssertEquals(bubble.frame.size.height, (CGFloat)20, @"Height not set correctly");
}

- (void) testInitWithBackgroundImageSetsSize {

	id mockBackground = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 20);
	[[[mockBackground stub] andReturnValue:OCMOCK_VALUE(size)] size];

	DCUIBubble *bubble = [[[DCUIBubble alloc] initWithBackgroundImage:mockBackground] autorelease];
	GHAssertEquals(bubble.frame.size.width, (CGFloat)10, @"Width not set correctly");
	GHAssertEquals(bubble.frame.size.height, (CGFloat)20, @"Height not set correctly");
}

- (void) testCommonInit {

	DCUIBubble *bubble = [[[DCUIBubble alloc] initWithSize:CGSizeMake(10, 20)] autorelease];

	GHAssertEquals(bubble.userInteractionEnabled, NO, @"User interaction not turned off");
	GHAssertTrue([[UIColor clearColor] isEqualToColor:bubble.backgroundColor], @"background colour not clear");
	GHAssertEquals(bubble.hidden, YES, @"Bubble should be hidden");

	id firstSubObject = [[bubble subviews] objectAtIndex:0];
	GHAssertTrue([firstSubObject isKindOfClass:[UILabel class]], @"value label not created");

	UILabel *valueLabel = (UILabel *)firstSubObject;
	GHAssertTrue([[UIColor clearColor] isEqualToColor:valueLabel.backgroundColor], @"Value label not transparent");
	GHAssertEquals(valueLabel.textAlignment, UITextAlignmentCenter, @"Value label not center aligned");

}


- (void) testMoveToX {
	[self verifyMoveToX:15 putsFrameAtX:15];
}

- (void) testMoveToXSticksAtLeftBounds {
	[self verifyMoveToX:1 putsFrameAtX:10];
}

- (void) testMoveToXSticksAtRightBounds {
	[self verifyMoveToX:100 putsFrameAtX:60];
}

- (void) verifyMoveToX:(int)x putsFrameAtX:(int)frameAt {

	UIWindow *window = [[[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
	UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(10, 20, 50, 50)] autorelease];
	[window addSubview:view];

	id mockTouch = [OCMockObject mockForClass:[UITouch class]];
	[[[mockTouch stub] andReturn:view] view];
	[[[mockTouch stub] andReturn:window] window];
	CGPoint touchPointInWindow = CGPointMake(x, 26);
	[[[mockTouch expect] andReturnValue:OCMOCK_VALUE(touchPointInWindow)] locationInView:window];

	DCUIBubble *bubble = [[[DCUIBubble alloc] initWithSize:CGSizeMake(10, 10)] autorelease];
	[window addSubview:bubble];
	[bubble alignWithTough:mockTouch];

	GHAssertEquals(bubble.frame.origin.x, (CGFloat)frameAt, @"Incorrect position x");
	GHAssertEquals(bubble.frame.origin.y, (CGFloat)10, @"Incorrect position y");
	GHAssertEquals(bubble.frame.size.width, (CGFloat)10, @"Incorrect width");
	GHAssertEquals(bubble.frame.size.height, (CGFloat)10, @"Incorrect height");

}

- (void) testDrawRect {

	id mockBackground = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	[[[mockBackground stub] andReturnValue:OCMOCK_VALUE(size)] size];
	CGRect expectedDrawInRect = CGRectMake(0, 0, 10, 10);
	[[mockBackground expect] drawInRect:expectedDrawInRect];

	DCUIBubble *bubble = [[[DCUIBubble alloc] initWithBackgroundImage:mockBackground] autorelease];
	[bubble drawRect:CGRectMake(0, 0, 1, 1)];

	// Nothing to assert.

	[mockBackground verify];
}


@end
