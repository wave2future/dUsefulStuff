//
//  NSMutableDictionary+DCIntKey.m
//  dUsefulStuff
//
//  Created by Derek Clarkson on 23/03/10.
//  Copyright 2010 Derek Clarkson. All rights reserved.
//

#import "NSMutableDictionary+dUsefulStuff.h"


@implementation NSMutableDictionary (dUsefulStuff)

- (void) setObject:(id)anObject forIntKey:(int)aIntKey {
	[self setObject:anObject forKey:[NSNumber numberWithInteger:aIntKey]];
}

@end
