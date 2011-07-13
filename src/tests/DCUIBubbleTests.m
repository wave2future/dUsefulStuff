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
- (void) verifyMoveToOffset:(int)x putsBubbleFrameAtX:(int)frameAt;

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
	[self verifyMoveToOffset:15 putsBubbleFrameAtX:25];
}

- (void) testMoveToXSticksAtLeftBounds {
	[self verifyMoveToOffset:-1 putsBubbleFrameAtX:10];
}

- (void) testMoveToXSticksAtRightBounds {
	[self verifyMoveToOffset:100 putsBubbleFrameAtX:60];
}

- (void) verifyMoveToOffset:(int)x putsBubbleFrameAtX:(int)frameAt {

	UIWindow *window = [[[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
	UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(10, 20, 50, 50)] autorelease];
	[window addSubview:view];

	DCUIBubble *bubble = [[[DCUIBubble alloc] initWithSize:CGSizeMake(10, 10)] autorelease];
	[window addSubview:bubble];
	
	[bubble positionAtView:view offset:x];

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
