//
//  BubbleViewTests.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 21/04/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//
#import "GHUnit.h"
#import "OCMock.h"
#import "DCUIRatingPopupBubble.h"
#import "DCCommon.h"

@interface DCUIRatingPopupBubbleTests : GHTestCase
{
}

@end

@implementation DCUIRatingPopupBubbleTests

- (void) testInitWithBackgroundImage {
	id mockBackground = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	[[[mockBackground stub] andReturnValue:DC_MOCK_VALUE(size)] size];

	DCUIRatingPopupBubble *view = [[[DCUIRatingPopupBubble alloc] initWithImage:mockBackground
	                                                                       font:nil
	                                                                 textColour:nil
	                                                                    xOffset:0
	                                                                    yOffset:0
	                                                           displayAsDecimal:NO] autorelease];

	GHAssertEquals(view.frame.origin.x, (CGFloat)0.0, @"Incorrect position x");
	GHAssertEquals(view.frame.origin.y, (CGFloat) - 10.0, @"Incorrect position y");
	GHAssertEquals(view.frame.size.width, (CGFloat)10.0, @"Incorrect width");
	GHAssertEquals(view.frame.size.height, (CGFloat)10.0, @"Incorrect height");
	GHAssertEquals(view.userInteractionEnabled, NO, @"User interactive not set");
	GHAssertEquals(view.backgroundColor.CGColor, [UIColor clearColor].CGColor, @"Incorrect background color");
	GHAssertEquals(view.hidden, YES, @"Not hidden");

}

- (void) testDrawRect {
	id mockBackground = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	[[[mockBackground stub] andReturnValue:DC_MOCK_VALUE(size)] size];
	[[mockBackground expect] drawInRect:CGRectMake(0, 0, 10, 10)];

	DCUIRatingPopupBubble *view = [[[DCUIRatingPopupBubble alloc] initWithImage:mockBackground
	                                                                       font:nil
	                                                                 textColour:nil
	                                                                    xOffset:0
	                                                                    yOffset:0
	                                                           displayAsDecimal:NO] autorelease];
	[view drawRect:CGRectMake(0, 0, 0, 0)];

	// Nothing to assert.

}

- (void) testMoveToX {
	id mockBackground = [OCMockObject mockForClass:[UIImage class]];
	CGSize size = CGSizeMake(10, 10);
	[[[mockBackground stub] andReturnValue:DC_MOCK_VALUE(size)] size];

	DCUIRatingPopupBubble *view = [[[DCUIRatingPopupBubble alloc] initWithImage:mockBackground
	                                                                       font:nil
	                                                                 textColour:nil
	                                                                    xOffset:0
	                                                                    yOffset:0
	                                                           displayAsDecimal:NO] autorelease];
	[view moveToX:15];

	GHAssertEquals(view.frame.origin.x, (CGFloat)15.0, @"Incorrect position x");
	GHAssertEquals(view.frame.origin.y, (CGFloat) - 10.0, @"Incorrect position y");
	GHAssertEquals(view.frame.size.width, (CGFloat)10.0, @"Incorrect width");
	GHAssertEquals(view.frame.size.height, (CGFloat)10.0, @"Incorrect height");

}

@end