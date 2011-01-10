//
//  NSDictionary_dUsefulStuffTests.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 23/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//
#import <GHUnit/GHUnit.h> 
#import "NSDictionary+dUsefulStuff.h"
#import "NSMutableDictionary+dUsefulStuff.h"

@interface NSMutableDictionary_dUsefulStuffTests : GHTestCase {}

@end


@implementation NSMutableDictionary_dUsefulStuffTests

- (void) testStoringWithAnInt {
	
	NSMutableDictionary *dic = [NSMutableDictionary dictionary];

	[dic setObject:@"abc" forIntKey:1];
	
	NSString * result = [dic objectForIntKey:1];
	GHAssertEqualStrings(result, @"abc", @"failed to return string from dictionary");
	
}

@end
