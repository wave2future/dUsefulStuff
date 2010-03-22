//
//  DCCommonTests.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 25/02/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHUnit.h"
#import "DCCommon.h"

@interface DCCommonTests : GHTestCase {}

@end

@implementation DCCommonTests

-(void) testDC_NSDICTIONARY_KEY_TO_INT {

	NSMutableDictionary * dic = [NSMutableDictionary dictionary];
	
	[dic setObject:@"abc" forKey:[NSNumber numberWithInt:1]];
	[dic setObject:@"def" forKey:[NSNumber numberWithInt:2]];
	
	GHAssertEquals(DC_NSDICTIONARY_KEY_TO_INT(dic, 0), 1, @"Incorrect key value returned");
	GHAssertEquals(DC_NSDICTIONARY_KEY_TO_INT(dic, 1), 2, @"Incorrect key value returned");
	
}

-(void) testDC_NSDICTIONARY_OBJ_FOR_INT_KEY {
	
	NSMutableDictionary * dic = [NSMutableDictionary dictionary];
	
	[dic setObject:@"abc" forKey:[NSNumber numberWithInt:1]];
	[dic setObject:@"def" forKey:[NSNumber numberWithInt:2]];
	
	GHAssertEqualStrings(DC_NSDICTIONARY_OBJ_FOR_INT_KEY(dic, 1), @"abc", @"Incorrect value returned");
	GHAssertEqualStrings(DC_NSDICTIONARY_OBJ_FOR_INT_KEY(dic, 2), @"def", @"Incorrect value returned");
	
}

-(void) testDC_NSDICTIONARY_INT_FOR_INT_KEY {
	
	NSMutableDictionary * dic = [NSMutableDictionary dictionary];
	
	[dic setObject:[NSNumber numberWithInt:10] forKey:[NSNumber numberWithInt:1]];
	[dic setObject:[NSNumber numberWithInt:20] forKey:[NSNumber numberWithInt:2]];
	
	GHAssertEquals(DC_NSDICTIONARY_INT_FOR_INT_KEY(dic, 1), 10, @"Incorrect value returned");
	GHAssertEquals(DC_NSDICTIONARY_INT_FOR_INT_KEY(dic, 2), 20, @"Incorrect value returned");
	
}

@end
