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
#import <OCMock/OCMock.h>

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

-(void) testConcantination {
	int DC_CONCATINATE(abc, __LINE__) = 45;
	GHAssertEquals(abc33, 45, @"String not concatinated properly");
}

@end
