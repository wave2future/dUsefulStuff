//
//  DCCommonTests.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 25/02/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GHUnit/GHUnit.h> 
#import "DCCommon.h"
#import <UIKit/UIKit.h>

@interface DCCommonTests : GHTestCase {}

@end

@implementation DCCommonTests

/**
 * This test does nothing more than exercise the log routines.
 */
-(void) testLogging {
	DC_LOG(@"hello %@", @"abc");
	UIView * view = [[[UIView alloc]init]autorelease];
	CGRect rect = CGRectMake(1,2,3,4);
	view.frame = rect;
	DC_LOG_LAYOUT(view);
}

-(void) testDC_MOCK_VALUE {
	BOOL yes = YES;
	NSValue * value = DC_MOCK_VALUE(yes);
	GHAssertNotNil(value, @"Should have received a NSValue object");
	bool result;
	[value getValue:&result];
	DC_LOG(@"Result = %@", DC_PRETTY_BOOL(result));
}

@end
