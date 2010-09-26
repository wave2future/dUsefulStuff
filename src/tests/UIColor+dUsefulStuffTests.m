//
//  UIColor+dUsefulStuffTests.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 18/09/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//
#import <GHUnitIOS/GHUnitIOS.h>
#import "UIColor+dUsefulStuff.h"

@interface UIColor_dUsefulStuffTests : GHTestCase {}

@end


@implementation UIColor_dUsefulStuffTests

-(void) testTrue {
	GHAssertTrue([[UIColor clearColor] isEqualToColor:[UIColor clearColor]], @"Failed basic YES test.");
}
-(void) testFalse {
	GHAssertFalse([[UIColor clearColor] isEqualToColor:[UIColor redColor]], @"Failed basic NO test.");
}

@end
