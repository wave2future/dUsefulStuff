//
//  NSDictionary+IntKey.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 23/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import "NSDictionary+dUsefulStuff.h"
#import "DCCommon.h"


@implementation NSDictionary (dUsefulStuff)

- (id) objectForIntKey:(int)aIntKey {
	DC_LOG(@"Returning value for key: %i", aIntKey);
	return [self objectForKey:[NSNumber numberWithInteger:aIntKey]];
}

@end
