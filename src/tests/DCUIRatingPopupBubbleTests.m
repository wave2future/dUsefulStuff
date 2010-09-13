//
//  BubbleViewTests.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 21/04/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//
#import <GHUnitIOS/GHUnitIOS.h>
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
	id mockTouch = [OCMockObject mockForClass:[UITouch class]];
	id mockView = [OCMockObject mockForClass:[UIView class]];
	id mockWindow = [OCMockObject mockForClass:[UIWindow class]];

	CGSize size = CGSizeMake(10, 10);
	[[[mockBackground stub] andReturnValue:DC_MOCK_VALUE(size)] size];
	
	[[[mockTouch stub] andReturn:mockView] view];
	[[[mockTouch stub] andReturn:mockWindow] window];
	CGPoint viewTouchPoint = CGPointMake(25, 35);
	[[[mockTouch stub] andReturnValue:DC_MOCK_VALUE(viewTouchPoint)] locationInView:mockView]; 
	CGPoint windowTouchPoint = CGPointMake(35, 45);
	[[[mockTouch stub] andReturnValue:DC_MOCK_VALUE(windowTouchPoint)] locationInView:mockWindow]; 
	CGRect windowFrame = CGRectMake(0, 0, 320, 480);
	[[[mockWindow stub] andReturnValue:DC_MOCK_VALUE(windowFrame)] frame]; 
	CGRect viewFrame = CGRectMake(10, 110, 100, 100);
	[[[mockView stub] andReturnValue:DC_MOCK_VALUE(viewFrame)] frame]; 
	
	DCUIRatingPopupBubble *view = [[[DCUIRatingPopupBubble alloc] initWithImage:mockBackground
	                                                                       font:nil
	                                                                 textColour:nil
	                                                                    xOffset:0
	                                                                    yOffset:0
	                                                           displayAsDecimal:NO] autorelease];
	[view alignWithTough:mockTouch];

	GHAssertEquals(view.frame.origin.x, (CGFloat)35.0, @"Incorrect position x");
	GHAssertEquals(view.frame.origin.y, (CGFloat) 10.0, @"Incorrect position y");
	GHAssertEquals(view.frame.size.width, (CGFloat)10.0, @"Incorrect width");
	GHAssertEquals(view.frame.size.height, (CGFloat)10.0, @"Incorrect height");

}

@end
